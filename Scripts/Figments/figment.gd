class_name Figment

var rng = RandomNumberGenerator.new()

var speciesName: String
var sprite: Texture2D
var type1: Type
var type2: Type
var stats: Dictionary
var moves: Array[Move]

var hp: int

func _init(blueprint: String) -> void:
	var bp: Blueprint = blueprints[blueprint]
	print("creating a %s" % blueprint)

	speciesName = bp.speciesName
	sprite = bp.sprite
	type1 = bp.type1
	type2 = bp.type2
	moves = bp.moves
	for stat: String in bp.stats.keys():
		self.stats[stat] = bp.stats[stat].copy()

	for stat in self.stats.values():
		stat.value = rng.randi_range(stat.minInit, stat.maxInit)
		stat.growth = rng.randi_range(stat.minGrowth, stat.maxGrowth)
	
	hp = stats.coherence.value * 10

enum Type {NONE, LAND, SEA, SKY, MIND, BODY, LIGHT, DARK, SYNTH, FEAR}

static var blueprints: Dictionary[String, Blueprint] = {
	"skyTest": Blueprint.new(
		"TYPE_SKY",
		load("res://Resources/Images/Figment Sprites/TYPESKY.png"),
		Type.SKY,
		Type.NONE,
		{
			"will": Stat.new(5, 10, 2, 4),
			"coherence": Stat.new(5, 10, 2, 4),
			"lucidity": Stat.new(5, 10, 2, 4),
			"acuity": Stat.new(5, 10, 2, 4),
			"creativity": Stat.new(5, 10, 2, 4)
		},
		[
			Move.moveList.skyAttack,
			Move.moveList.heal
		]
	),
	"seaTest": Blueprint.new(
		"TYPE_SEA",
		load("res://Resources/Images/Figment Sprites/TYPESEA.png"),
		Type.SEA,
		Type.NONE,
		{
			"will": Stat.new(5, 10, 2, 4),
			"coherence": Stat.new(5, 10, 2, 4),
			"lucidity": Stat.new(5, 10, 2, 4),
			"acuity": Stat.new(5, 10, 2, 4),
			"creativity": Stat.new(5, 10, 2, 4)
		},
		[
			Move.moveList.seaAttack
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
			Move.moveList.landAttack
		]
	),
}

class Blueprint:
	var speciesName: String
	var sprite: Texture2D

	var type1: Type
	var type2: Type

	var stats: Dictionary[String, Stat]

	var moves: Array[Move]

	func _init(n: String, spr: Texture2D, t1: Type, t2: Type, st: Dictionary[String, Stat], mo: Array[Move]) -> void:
		speciesName = n
		sprite = spr
		type1 = t1
		type2 = t2
		stats = st
		moves = mo