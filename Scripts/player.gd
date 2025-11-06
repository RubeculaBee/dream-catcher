extends Node2D

var input_direction: Vector2
var move_direction: Vector2

@onready var sprite: AnimatedSprite2D = find_child("AnimatedSprite2D")

const TILE_SIZE: int = 32 # in pixels
const MOVE_SPEED: int = 4 # in tiles per second

func _process(delta: float) -> void:
	input_direction = get_movement()
	
	if move_direction == Vector2.ZERO:
		try_move()
	else:
		smoothe_move(delta)

	
func get_movement() -> Vector2:
	var dir: Vector2
	dir.x = Input.get_axis("left", "right")
	dir.y = Input.get_axis("up", "down")

	return dir.round()

func try_move() -> bool:
	if input_direction.y != 0:
		move_direction.y = input_direction.y
		return true
	elif input_direction.x != 0:
		move_direction.x = input_direction.x
		return true
	
	return false

func smoothe_move(delta: float) -> void:
	# round the position so that the player is always at an integer position
	# because we are doing modulus later, so decimal position can mess things up
	position += (move_direction * TILE_SIZE * MOVE_SPEED * delta).round()
	
	# if player is in the middle of the tile, stop moving
	if ((position.x as int) % TILE_SIZE == 16) and ((position.y as int) % TILE_SIZE == 16):
		move_direction = Vector2.ZERO
