extends Control
@onready var optionsMenu = preload("res://Scenes/Options_Menu.tscn")
func _ready():
	$AnimationPlayer.play("RESET")
	
func pause():
	get_tree().paused = true
	$AnimationPlayer.play("blur")
	
func resume():
	get_tree().paused = false
	$AnimationPlayer.play_backwards("blur")

func testEsc():
	if Input.is_action_just_pressed("escape") and !get_tree().paused:
		pause()
		print("ESC pressed")
	elif Input.is_action_just_pressed("escape") and get_tree().paused:
		resume()
		
func _process(delta):
	testEsc()

func _on_resume_pressed():
	resume()


func _on_main_pressed():
	resume()
	get_tree().change_scene_to_file("res://Scenes/Rooms/main_menu.tscn")


func _on_options_pressed():
	resume()
	get_tree().change_scene_to_file("res://Scenes/Options_Menu.tscn")
	
func _on_hotel_pressed():
	get_tree().change_scene_to_file("res://Scenes/Rooms/Hotel_lobby.tscn")
