extends Camera2D
class_name PlayerCamera

# Nodes
@onready var screen_cover: ColorRect = $ColorRect

#signals
signal screen_covered ## Emit when the screen is fully covered
signal screen_uncovered ## Emit when the transition is done

func _ready() -> void:
	# Turn off screen cover at start
	screen_cover.color.a = 0;
	screen_covered.connect(_on_screen_covered)
	screen_uncovered.connect(_on_screen_uncovered)

func fade_transition() -> void:
	screen_cover.position = Vector2(-screen_cover.size.x/2, -screen_cover.size.y/2)
	screen_cover.color.a = 0

	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	
	tween.tween_property(screen_cover, "color", Color(0, 0, 0, 1), 0.25)
	tween.tween_callback(screen_covered.emit)
	tween.tween_property(screen_cover, "color", Color(0, 0, 0, 0), 0.25)
	tween.tween_callback(screen_uncovered.emit)

func swipe_transition() -> void:
	screen_cover.position = Vector2(800, -screen_cover.size.y/2)
	screen_cover.color.a = 1

	var tween: Tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD)

	# tween.set_ease(Tween.EASE_IN)
	tween.tween_property(screen_cover, "position", Vector2(-screen_cover.size.x/2, -screen_cover.size.y/2), 0.4)
	tween.tween_callback(screen_covered.emit)

	# tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(screen_cover, "position", Vector2(-screen_cover.size.x*2, -screen_cover.size.y/2), 0.4)
	tween.tween_callback(screen_uncovered.emit)

func _on_screen_covered():
	position_smoothing_enabled = false

func _on_screen_uncovered():
	position_smoothing_enabled = true