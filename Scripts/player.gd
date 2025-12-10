extends Node2D
class_name Player

# Variables
var input_direction: Vector2i	# The direction the user is inputting
var move_direction: Vector2i	# The direction the player character is actively moving
var look_direction: String		# The direction the player character is facing

# Constants
const TILE_SIZE: int = 32 			# width/height of a tile in pixels
@export var MOVE_SPEED: float = 4 	## How many tiles to move each second

# Signals
signal tried_move(tile: Vector2i)	## Emitted when the user tries to take a step, with the location of the tile they tried to move to

# Nodes
@onready var sprite: AnimatedSprite2D = find_child("AnimatedSprite2D")

func _process(_delta: float) -> void:
	input_direction = get_input()
	
	# If not moving and trying to move
	if move_direction == Vector2i.ZERO and try_move():
		# get the intended next tile (dividing by tile_size to get the tilemap coordinates)
		var next_tile: Vector2i = Vector2i(position) / TILE_SIZE + move_direction
		sprite.play(look_direction)
		tried_move.emit(next_tile)

func get_input() -> Vector2i:
	var dir: Vector2
	dir.x = Input.get_axis("left", "right")
	dir.y = Input.get_axis("up", "down")

	# Because we're working with discrete tiles, we convert the input to an integer vector
	return Vector2i(dir)

func try_move() -> bool:
	# Prioritise vertical movement, then horizontal
	# move_direction should only have a non-zero value in one axis at a time
	if input_direction.y != 0:
		move_direction.y = input_direction.y
		look_direction = "up" if move_direction.y == -1 else "down"
		return true
	elif input_direction.x != 0:
		move_direction.x = input_direction.x
		look_direction = "left" if move_direction.x == -1 else "right"
		return true
	
	return false

func _on_move_response(valid_move: bool) -> void:
	if valid_move:
		tween_move()
	else:
		move_direction = Vector2.ZERO

# thank you AJ!
func tween_move() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(self, "position", position + Vector2(move_direction) *TILE_SIZE, 1/MOVE_SPEED)
	tween.tween_callback(func(): move_direction = Vector2.ZERO)
