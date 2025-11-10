extends Area2D
class_name ScreenTransition

# Variables
var next_screen: PackedScene 			#  The next screen that this transition should send the player to 
@export var next_screen_name: String	## The file name of the next screen (without the file extension)
@export var id: int						## This transition's ID (must be qunique!). After the transition, the player will be sent to the transition tile in the next room with the same id

# Signal 
signal transition(transtion: ScreenTransition, offset: Vector2) ## Trigger a screen transition with data about itself and where the player entered.

func _ready() -> void:
	# wait before conencting the signal, such that the player doesnt trigger this as soon as the room loads
	await get_tree().create_timer(0.5).timeout
	area_entered.connect(_on_area_entered)
	next_screen = load("res://Scenes/Rooms/%s.tscn" % next_screen_name)

func _on_area_entered(area: Area2D) -> void:
	if area.name == "PlayerCollision":
		#wait for the player to stop moving before triggering the screen transition
		await (area.get_parent() as Player).stopped_move
		
		# How far from the transitions orgin is the player
		var offset: Vector2 = area.global_position - position
		transition.emit(self, offset)