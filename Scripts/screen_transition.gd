extends Area2D
class_name ScreenTransition

# Variables
var next_screen: PackedScene
@export var next_screen_name: String
@export var id: int

# Signal 
signal transition(transtion: ScreenTransition)

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	area_entered.connect(_on_area_entered)
	next_screen = load("res://Scenes/Rooms/%s.tscn" % next_screen_name)

func _on_area_entered(area: Area2D) -> void:
	if area.name == "PlayerCollision":
		await (area.get_parent() as Player).stopped_move
		transition.emit(self)