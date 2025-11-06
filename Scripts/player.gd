extends Node2D

var movementHoriz: float
var movementVert: float

func _process(_delta: float) -> void:
	movementHoriz = Input.get_axis("left", "right")
	movementVert = Input.get_axis("up", "down")

	print("test")
	print("Horiz: %s | Vert: %s" % [movementHoriz, movementVert])
