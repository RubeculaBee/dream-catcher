class_name Figment

enum Type {NONE, LAND, SEA, SKY, MIND, BODY, LIGHT, DARK, SYNTH, FEAR}
var rng = RandomNumberGenerator.new()

var speciesName: String
var sprite: Texture2D
var type1: Type
var type2: Type
var stats: Dictionary

var hp: int

func _init(blueprint: String) -> void:
	var bp = blueprints[blueprint]

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
		load("res://Resources/Images/Figment Sprites/TYPESKY.png"),
		Type.SKY,
		Type.NONE,
		{
			"will": Stat.new(2, 4, 2, 8),
			"coherence": Stat.new(5, 10, 2, 4),
			"lucidity": Stat.new(2, 4, 2, 4),
			"acuity": Stat.new(10, 20, 2, 4),
			"creativity": Stat.new(10, 20, 4, 8)
		},
		[
			Move.SkyAttack.new(),
			Move.Heal.new()
		]
	),
	"seaTest": Blueprint.new(
		"TYPE_SEA",
		load("res://Resources/Images/Figment Sprites/TYPESEA.png"),
		Type.SEA,
		Type.NONE,
		{
			"will": Stat.new(20, 25, 4, 8),
			"coherence": Stat.new(10, 20, 2, 4),
			"lucidity": Stat.new(10, 20, 4, 8),
			"acuity": Stat.new(2, 4, 2, 4),
			"creativity": Stat.new(5, 10, 2, 4)
		},
		[
			Move.SeaAttack.new()
		]
	),
	"landTest": Blueprint.new(
		"TYPE_LAND",
		load("res://Resources/Images/Figment Sprites/TYPELAND.png"),
		Type.LAND,
		Type.NONE,
		{
			"will": Stat.new(5, 10, 2, 4),
			"coherence": Stat.new(5, 10, 2, 4),
			"lucidity": Stat.new(5, 10, 2, 4),
			"acuity": Stat.new(5, 10, 2, 4),
			"creativity": Stat.new(5, 10, 2, 4)
		},
		[
			Move.LandAttack.new()
		]
	),
}