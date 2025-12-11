extends StaticBody2D

@onready var interactable: Area2D = $Interactable
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	interactable.interact = _on_interact()

func _on_interact():
	if animated_sprite_2d.frame == 0:
		animated_sprite_2d.frame = 1
		interactable.is_interactable = false
		print("yo whaddup.")
