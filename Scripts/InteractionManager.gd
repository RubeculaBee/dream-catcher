extends Node
class_name InteractionManager

## Detects the Interactable directly in front of the player and activates it on E.
## Lives as a child node of the Player scene.

const TILE_SIZE: int = 32

var _focused: Interactable = null

func _process(_delta: float) -> void:
	_update_focus()
	if Input.is_action_just_pressed("interact") and _focused != null:
		_focused.interact()

func _update_focus() -> void:
	var player: Player = get_parent()
	var target_tile: Vector2i = Vector2i(player.position) / TILE_SIZE + _look_offset(player.look_direction)

	var found: Interactable = null
	for child in player.get_parent().get_children():
		if child is Interactable and Vector2i(child.position) / TILE_SIZE == target_tile:
			found = child
			break
	
	if found == null:
		if _focused != null:
			_focused.on_unfocused()
			_focused = null
		return
		
	if found != _focused:
		if _focused != null:
			_focused.on_unfocused()
	
	if found != _focused:
		_focused = found
		_focused.on_focused()

func _look_offset(dir: String) -> Vector2i:
	match dir:
		"up":    return Vector2i( 0, -1)
		"down":  return Vector2i( 0,  1)
		"left":  return Vector2i(-1,  0)
		"right": return Vector2i( 1,  0)
	return Vector2i(0, 1)
