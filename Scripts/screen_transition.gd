extends Area2D
class_name ScreenTransition

@export var next_screen: PackedScene

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func _on_area_entered(area: Area2D) -> void:
	print("I, %s, have been entered by %s!" % [self, area])