extends Node2D 
class_name Enemy 

var TILE_SIZE: int = 32 
var MOVE_SPEED: float = 4 

var move_direction: Vector2i = Vector2i.ZERO 
var alias: String 

signal tried_move(tile: Vector2i) # Emitted when the enemy tries to take a step, with the location of the tile they tried to move to # This runs every time the Enemy successfully moves 

func on_player_moved():
	randomize()
	move_random_steps()
	
func move_random_steps():
	# Choose a random direction 
	var dirs = [Vector2i(1,0), Vector2i(-1,0), Vector2i(0,1), Vector2i(0,-1)]
	move_direction = dirs[randi_range(0, 3)]
	
	# Choose how many tiles to move 
	var steps = randi_range(1,1) 
	
	# Move one tile at a time (with walkability check) 
	for i in range(steps):
		var next_tile: Vector2i = Vector2i(self.global_position) / TILE_SIZE + move_direction
		tried_move.emit(next_tile,self)

func _on_move_response(valid_move: Vector2i) -> void:
	var next_tile: Vector2i = Vector2i(self.global_position) / TILE_SIZE + move_direction
	if valid_move == next_tile:
		tween_move()
		
func tween_move() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(self, "position", position + Vector2(move_direction) *TILE_SIZE, 1/MOVE_SPEED) 
	await tween.finished
