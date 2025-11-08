extends Node

# Signals
signal player_move_response(response: bool) ## A signal designed to tell the player whether it can move

# Nodes
var terrain: TileMapLayer
var player: Player
var screen_transitions: Array

func _ready() -> void:
	player = get_parent().find_child("Player")
	player.tried_move.connect(_on_player_tried_move) # connect game_manager to player's signal
	player_move_response.connect(Callable(player, "_on_move_response")) # connect player to game_manager's signal
	
	terrain = get_parent().find_child("Terrain Tile Map")
	assert(terrain != null, "Terrain not found!")

	screen_transitions = get_parent().find_child("Screen Transitions").get_children()
	for i in screen_transitions.size()-1:
		for j in range(i+1, screen_transitions.size()):
			assert(screen_transitions[i].id != screen_transitions[j].id, "Duplicate ID in screen transition triggers!")

func _on_player_tried_move(tile: Vector2i) -> void:
	var tile_data: TileData = terrain.get_cell_tile_data(tile)
	var valid_move: bool = (tile_data != null) && (tile_data.get_custom_data("walkable"))

	player_move_response.emit(valid_move)
