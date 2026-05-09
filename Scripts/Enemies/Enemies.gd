extends Node2D
class_name Enemies

var TILE_SIZE: int = 32 

@export var enemy_scene : PackedScene
@onready var player = get_parent().find_child("Player")

@export var numEnemies : int
@export var spawnpoints : Array[Vector2i]
var spawnpointsNow : Array[Vector2i]

@export var figment_list: Array[String]
@export var figment_lvl = {
	"from": 0,
	"to": 0
}

func _ready() -> void:
	spawnpointsNow = spawnpoints

func spawn_enemy() -> Node2D:
	if enemy_scene == null:
		push_error("Enemies node has no enemy_scene assigned!")
		return null
	
	assert(figment_list.size() > 0, "No figments in list!")

	var spawn = randi_range(0,spawnpointsNow.size()-1)
	var enemy = enemy_scene.instantiate()

	enemy.figment = Figment.new(figment_list[randi_range(0,figment_list.size()-1)], randi_range(figment_lvl.from,figment_lvl.to))
	enemy.get_node("Sprite2D").texture = enemy.figment.shape
	enemy.get_node("Sprite2D").self_modulate = Figment.typeColours[enemy.figment.type1]
	
	enemy.position = Vector2(spawnpoints[spawn] * TILE_SIZE)
	spawnpoints.remove_at(spawn)
	enemy.alias = str(randi_range(0,1000))
	add_child(enemy)
	return enemy
