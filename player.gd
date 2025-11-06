extends CharacterBody2D

const tile_size = 32
var moving = false
var input_dir

func _physics_process(_delta: float) -> void:
	input_dir = Vector2.ZERO
	if Input.is_action_pressed("move_down"):
		input_dir = Vector2(0,1)
		move()
	if Input.is_action_pressed("move_up"):
		input_dir = Vector2(0,-1)
		move()
	if Input.is_action_pressed("move_left"):
		input_dir = Vector2(-1,0)
		move()
	if Input.is_action_pressed("move_right"):
		input_dir = Vector2(1,0)
		move()
	move_and_slide()
	
func move():
	if input_dir:
		if moving == false:
			moving = true
			var tween = create_tween()
			tween.tween_property(self, "position", position + input_dir*tile_size, 0.35)
			tween.tween_callback(move_false)
			
func move_false():
	moving = false
