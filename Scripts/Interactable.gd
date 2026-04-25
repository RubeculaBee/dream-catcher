extends Node2D
class_name Interactable

## Base class for all interactable objects.
## Extend this and override on_focused(), on_unfocused(), and interact().

func on_focused() -> void:
	pass # Called when the player starts facing this object

func on_unfocused() -> void:
	pass # Called when the player stops facing this object

func interact() -> void:
	pass # Called when the player presses E
