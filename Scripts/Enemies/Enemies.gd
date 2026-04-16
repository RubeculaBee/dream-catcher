extends Node2D
class_name Enemies

@export var enemy_scene : PackedScene
@onready var player = get_parent().find_child("Player")

func spawn_enemy(world_pos: Vector2) -> Node2D:
	if enemy_scene == null:
		push_error("Enemies node has no enemy_scene assigned!")
		return null

	var enemy = enemy_scene.instantiate()
	enemy.position = world_pos
	enemy.alias = str(randi_range(0,1000))
	add_child(enemy)
	return enemy
