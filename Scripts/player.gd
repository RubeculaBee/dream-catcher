extends Node2D

@onready var sprite: AnimatedSprite2D = find_child("AnimatedSprite2D")
const TILE_SIZE: int = 32

func _process(_delta: float) -> void:
	var move_direction: Vector2 = get_movement()
	
	move(move_direction)

	
func get_movement() -> Vector2:
	var dir: Vector2
	dir.x = Input.get_axis("left", "right")
	dir.y = Input.get_axis("up", "down")

	return dir.round()

func move(move_dir: Vector2) -> bool:
	if move_dir.y != 0:
		position.y += move_dir.y * TILE_SIZE
		return true
	elif move_dir.x != 0:
		position.x += move_dir.x * TILE_SIZE
		return true
	
	return false