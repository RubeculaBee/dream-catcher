extends Node2D

@onready var sprite: AnimatedSprite2D = find_child("AnimatedSprite2D")

func _process(_delta: float) -> void:
	var movement_direction: Vector2i = get_movement()
	print(movement_direction)

	
func get_movement() -> Vector2i:
	var dir: Vector2
	dir.x = Input.get_axis("left", "right")
	dir.y = Input.get_axis("up", "down")

	return dir