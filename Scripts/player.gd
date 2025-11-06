extends Node2D

var input_direction: Vector2
var move_direction: Vector2
var look_direction: String

@onready var sprite: AnimatedSprite2D = find_child("AnimatedSprite2D")

const TILE_SIZE: int = 32 # in pixels
@export var MOVE_SPEED: float = 4 # in tiles per second

func _process(_delta: float) -> void:
	input_direction = get_input()
	
	if move_direction == Vector2.ZERO and try_move():
		sprite.play(look_direction)
		tween_move()

	
func get_input() -> Vector2:
	var dir: Vector2
	dir.x = Input.get_axis("left", "right")
	dir.y = Input.get_axis("up", "down")

	return dir.round()

func try_move() -> bool:
	if input_direction.y != 0:
		move_direction.y = input_direction.y
		look_direction = "up" if move_direction.y == -1 else "down"
		return true
	elif input_direction.x != 0:
		move_direction.x = input_direction.x
		look_direction = "left" if move_direction.x == -1 else "right"
		return true
	
	return false

# thank you AJ!
func tween_move() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(self, "position", position + move_direction *TILE_SIZE, 1/MOVE_SPEED)
	tween.tween_callback(func(): move_direction = Vector2.ZERO)
