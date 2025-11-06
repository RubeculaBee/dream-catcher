extends Node

# Signals
signal player_move_response(response: bool) ## A signal designed to tell the player whether it can move

# Nodes
var terrain: TileMapLayer

func _ready() -> void:
	var player: Player = getPlayer()
	player.tried_move.connect(_on_player_tried_move)
	player_move_response.connect(Callable(player, "_on_move_response"))
	
	terrain = get_parent().find_child("Terrain Tile Map")
	if terrain == null:
		print("Terrain not found!")


func getPlayer() -> Player:
	var player: Player = get_parent().find_child("Player")
	
	if player == null:
		print("No player found!")
	else:
		print("Found: ", player)
	
	return player

func _on_player_tried_move(tile: Vector2i) -> void:
	if terrain == null:
		return

	var tile_data: TileData = terrain.get_cell_tile_data(tile)
	var valid_move: bool = (tile_data != null) && (tile_data.get_custom_data("walkable"))

	player_move_response.emit(valid_move)
