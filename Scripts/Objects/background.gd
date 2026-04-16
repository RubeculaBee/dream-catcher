extends Sprite2D

var isClone: bool = false

func _ready() -> void:
	assert(texture != null, "Background has no texture!")
	if !isClone:
		copy(800)

func copy(distance: int):
	var dupe = self.duplicate()
	dupe.position.x += distance
	dupe.isClone = true
	add_sibling.call_deferred(dupe)

func _process(delta: float) -> void:
	position.x -= 32 * delta
	if position.x < -799:
		copy(1599)
		queue_free()
