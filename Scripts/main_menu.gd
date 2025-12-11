extends Control
class_name MainMenu

#Signals
signal start_pressed ## emit whe nstart button pressed

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	start_pressed.emit()
	print("Start pressed")


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/Menus/Options_Menu.tscn")
	print("Settings pressed")


func _on_exit_pressed() -> void:
	get_tree().quit()
	print("Exit pressed")
