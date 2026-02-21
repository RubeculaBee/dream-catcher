extends Node
class_name Figment

enum Type {NONE, LAND, SEA, SKY, MIND, BODY, LIGHT, DARK, SYNTH, FEAR}
var rng = RandomNumberGenerator.new()

@export var blueprint: String 
var speciesName: String
var sprite: Texture2D
var type1: Type
var type2: Type
var stats: Dictionary


func _ready() -> void:
	generate()

	print(speciesName)
	print(sprite)
	print(Type.find_key(type1))
	print(Type.find_key(type2))
	for stat in stats:
		print("Stat: %s\nValue: %s\nGrowth: %s" % [stat, stats[stat].value, stats[stat].growth])

func generate() -> void:
	var bp = blueprints.skyTest

	speciesName = bp.speciesName
	sprite = bp.sprite
	type1 = bp.type1
	type2 = bp.type2
	stats = bp.stats

	for stat in bp.stats.values():
		stat.value = rng.randi_range(stat.minInit, stat.maxInit)
		stat.growth = rng.randi_range(stat.minGrowth, stat.maxGrowth)

static var blueprints: Dictionary = {
	"skyTest": Blueprint.new(
		"TYPE_SKY",
		null,
		Type.SKY,
		Type.NONE,
		{
			"will": Stat.new(5, 10, 2, 4),
			"coherence": Stat.new(5, 10, 2, 4),
			"lucidity": Stat.new(5, 10, 2, 4),
			"acuity": Stat.new(5, 10, 2, 4),
			"creativity": Stat.new(5, 10, 2, 4)
		}
	)
}