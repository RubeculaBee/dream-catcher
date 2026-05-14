extends Control


@onready var game_manager = $"../../"

func _on_resume_pressed():
	game_manager.pauseMenu()



func _on_main_menu_pressed():
	game_manager.pauseMenu()



func _on_quit_pressed():
	get_tree().quit()
