extends Node2D
class_name Enemies

@export var enemy_scene : PackedScene
@export var figment_list: Array[String]
@export var figment_lvl = {
	"from": 0,
	"to": 0
}
@onready var player = get_parent().find_child("Player")

func spawn_enemy(world_pos: Vector2) -> Node2D:
	if enemy_scene == null:
		push_error("Enemies node has no enemy_scene assigned!")
		return null

	assert(figment_list.size() > 0, "No figments in list!")

	var enemy = enemy_scene.instantiate()
	enemy.figment = Figment.new(figment_list[randi_range(0,figment_list.size()-1)], randi_range(figment_lvl.from,figment_lvl.to))
	enemy.get_node("Sprite2D").texture = enemy.figment.shape
	enemy.get_node("Sprite2D").self_modulate = Figment.typeColours[enemy.figment.type1]
	enemy.position = world_pos
	enemy.alias = str(randi_range(0,1000))
	add_child(enemy)
	return enemy
