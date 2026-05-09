extends Interactable
class_name Sign

@export_multiline var message: String = "A sign with nothing written on it."

signal sign_read(messgae: String)

@onready var sprite_one: Sprite2D = $SpriteModeOne
@onready var sprite_two: Sprite2D = $SpriteModeTwo

func _ready():
	sprite_one.visible = true
	sprite_two.visible = false

func switch_mode():
	sprite_one.visible = not sprite_one.visible
	sprite_two.visible = not sprite_two.visible

func interact() -> void:
	print(message)
	sign_read.emit(message)

func on_focused() -> void:
	switch_mode()
	return


func on_unfocused() -> void:
	switch_mode()
	return
