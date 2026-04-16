extends Sprite2D

var isClone: bool = false

func _ready() -> void:
	assert(texture != null, "Background has no texture!")
	if !isClone:
		copy(800, true)

func copy(distance: int, flip: bool):
	var dupe = self.duplicate()
	dupe.position.x += distance
	dupe.flip_h = flip
	dupe.isClone = true
	add_sibling.call_deferred(dupe)

func _process(delta: float) -> void:
	position.x -= 128 * delta
	if position.x < -799:
		copy(1599, self.flip_h)
		queue_free()
