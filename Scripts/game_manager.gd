extends Node

# Signals
signal player_move_response(response: bool) ## A signal designed to tell the player whether it can move
signal enemy_move_response(response: bool) ## A signal designed to tell the enemy whether it can move

const TILE_SIZE: int = 32 			# width/height of a tile in pixels

# Nodes
var main_menu: MainMenu			# The main menu that loads whe nteh game starts
var current_room: Node			# The current room the player is in
var last_room: Node				# The last room that the player was in before a battle
var terrain: TileMapLayer		# The terrain in the current room
var player: Player				# The player object
var camera: PlayerCamera		# The camera that will follow the player
var enemies: Enemies
var screen_transitions: Array	# An array of all the screen transitions in the current room

# Exports(?)
@export var start_room: PackedScene ## the room that should be loaded when the game starts

# Contants
const player_path: String = "res://Scenes/Gameobjects/player.tscn"	# The location of the player scene file
const camera_path: String = "res://Scenes/Gameobjects/player_camera.tscn" # the location of the camera scene file
const battle_path: String = "res://Scenes/BattleScene/battle.tscn" # The location of the battle scene

func _ready() -> void:
	main_menu = get_node("MenuContainer").get_child(0)

	main_menu.start_pressed.connect(_on_mainMenu_startPressed)

func _on_mainMenu_startPressed():
	main_menu.queue_free()
	load_overworld()

func load_overworld():
	current_room = start_room.instantiate()
	get_node("Rooms").add_child(current_room)
	
	var spawnpoint: Node2D = current_room.get_node("Player Spawn")
	if spawnpoint != null:
		spawn_player(spawnpoint.position)
		attach_camera()

	update_references()

func attach_camera():
	camera = load(camera_path).instantiate(TYPE_OBJECT)
	add_child(camera)
	player.find_child("RemoteTransform2D").remote_path = camera.get_path()

func spawn_player(spawn_position: Vector2):
	player = load(player_path).instantiate(TYPE_OBJECT)
	player.position = spawn_position
	current_room.add_child(player)

	player.tried_move.connect(_on_player_tried_move) # connect game_manager to player's signal
	player_move_response.connect(Callable(player, "_on_move_response")) # connect player to game_manager's signal

func update_references() -> void:
	terrain = current_room.get_node("Terrain Tile Map")
	assert(terrain != null, "Terrain not found!")

	screen_transitions = current_room.get_node("Screen Transitions").get_children()
	for i in screen_transitions.size():
		for j in range(i+1, screen_transitions.size()):
			assert(screen_transitions[i].id != screen_transitions[j].id, "Duplicate ID in screen transition triggers!")
		
		screen_transitions[i].transition.connect(_on_transition)
		
	#connect enemies in this room
	enemies = current_room.find_child("Enemies")
	if enemies != null:
		for i in 1:
			var enemy = enemies.spawn_enemy((spawnlocation()))
			player.stopped_move.connect(Callable(enemy, "on_player_moved")) # connect enemy to player's signal  
			enemy.tried_move.connect(_on_enemy_tried_move) # connect game_manager to enemy's signal
			enemy_move_response.connect(Callable(enemy, "_on_move_response")) # connect enemy to game_manager's signal

func spawnlocation() -> Vector2:
	return Vector2.ZERO

# also known as: enterBattle(enemy: Enemy)
func doGarrett(enemy: Enemy):
	print(enemy)
	last_room = get_node("Rooms").get_child(0)

	camera.swipe_transition()
	await camera.screen_covered
	get_node("Rooms").remove_child(last_room)

	camera.position = Vector2.ZERO

	var battleScene: BattleScene = load(battle_path).instantiate(TYPE_OBJECT)
	battleScene.fleeConfirmed.connect(_on_battleScene_flee_confirmed)
	get_node("BattleContainer").add_child(battleScene)

func _on_battleScene_flee_confirmed():
	var container: Node = get_node("BattleContainer")

	camera.swipe_transition()
	await camera.screen_covered
	container.remove_child(container.get_child(0))
	get_node("Rooms").add_child(last_room)

func _on_player_tried_move(tile: Vector2i) -> void:
	var tile_data: TileData = terrain.get_cell_tile_data(tile)
	if enemies != null:
		for enemy in enemies.get_children():
			if tile == Vector2i(enemy.global_position/TILE_SIZE):
				doGarrett(enemy)
	var valid_move: bool = (tile_data != null) && (tile_data.get_custom_data("walkable"))
	player_move_response.emit(valid_move)

func _on_enemy_tried_move(tile: Vector2i, enemy: Enemy) -> void:
	if tile == Vector2i(player.global_position/TILE_SIZE):
		doGarrett(enemy)
	var tile_data: TileData = terrain.get_cell_tile_data(tile)
	var valid_move: bool = (tile_data != null) && (tile_data.get_custom_data("walkable"))
	if valid_move:
		enemy_move_response.emit(tile)
	else: enemy_move_response.emit(Vector2i(999,999))


func _on_transition(transition: ScreenTransition, offset: Vector2):
	camera.fade_transition()
	await camera.screen_covered

	current_room.queue_free()
	current_room = transition.next_screen.instantiate()
	get_node("Rooms").add_child.call_deferred(current_room)

	player.reparent(current_room)
	update_references()

	var entrance: ScreenTransition
	for t: ScreenTransition in screen_transitions:
		if t.id == transition.id:
			entrance = t
			break
	
	# Don't spawn the player off of the next rooms entrance
	offset = offset.clamp(Vector2.ZERO, (entrance.scale - Vector2(1,1)) * 32)
	player.position = entrance.position + offset
