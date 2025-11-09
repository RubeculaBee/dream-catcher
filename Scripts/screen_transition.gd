extends Area2D
class_name ScreenTransition

# Variables
@export var next_screen: PackedScene
@export var id: int

# Signal 
signal transition(transtion: ScreenTransition)

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	if area.name == "PlayerCollision":
		transition.emit(self)