class_name Figment

var rng = RandomNumberGenerator.new()

var speciesName: String
var sprite: Texture2D
var type1: Type
var type2: Type
var shape: Texture2D
var stats: Dictionary
var moves: Array[Move]

var hp: int
var level: int

func _init(blueprint: String, startLvl: int) -> void:
	var bp: Blueprint = blueprints[blueprint]
	print("creating a %s" % blueprint)

	speciesName = bp.speciesName
	sprite = bp.sprite
	type1 = bp.type1
	type2 = bp.type2

	shape = load("res://Resources/Images/Enemies/enemy_%s.png" % Shape.find_key(bp.shape).to_lower())

	moves = bp.moves
	for stat: String in bp.stats.keys():
		self.stats[stat] = bp.stats[stat].copy()

	for stat: Stat in self.stats.values():
		stat.value = rng.randi_range(stat.minInit, stat.maxInit)
		stat.growth = rng.randi_range(stat.minGrowth, stat.maxGrowth)
	
	hp = stats.coherence.value * 10
	level = 0

	for i in range(min(startLvl*5 + randi_range(0,4), 100)):
		while !self.levelUp(self.stats.keys()[randi_range(0,4)]):
			pass

func levelUp(statName: String) -> bool:
	if !self.stats[statName].increase():
		return false
	
	var avg: float = 0
	for stat: Stat in self.stats.values():
		avg += stat.level
	avg /= 5

	self.level = floori(avg)
	return true

enum Type {NONE, LAND, SEA, SKY, MIND, BODY, LIGHT, DARK, SYNTH, FEAR}
static var typeColours = {
	Type.NONE: Color.WHITE,
	Type.LAND: Color.GREEN,
	Type.SEA: Color.BLUE,
	Type.SKY: Color.LIGHT_BLUE,
	Type.MIND: Color.PURPLE,
	Type.BODY: Color.RED,
	Type.LIGHT: Color.YELLOW,
	Type.DARK: Color.DARK_GRAY,
	Type.SYNTH: Color.LIGHT_GRAY,
	Type.FEAR: Color.BLACK,
}
enum Shape {BAT, CRAB, EYE, TONGUE}

static var blueprints: Dictionary[String, Blueprint] = {
	"skyTest": Blueprint.new(
		"TYPE_SKY",
		load("res://Resources/Images/Figment Sprites/TYPESKY.png"),
		Type.SKY,
		Type.NONE,
		Shape.BAT,
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
		Shape.CRAB,
		{
			"will": Stat.new(5, 10, 2, 4),
			"coherence": Stat.new(5, 10, 2, 4),
			"lucidity": Stat.new(5, 10, 2, 4),
			"acuity": Stat.new(5, 10, 2, 4),
			"creativity": Stat.new(5, 10, 2, 4)
		},
		[
			Move.moveList.seaAttack,
			Move.moveList.dragonRage
		]
	),
	"landTest": Blueprint.new(
		"TYPE_LAND",
		load("res://Resources/Images/Figment Sprites/TYPELAND.png"),
		Type.LAND,
		Type.NONE,
		Shape.TONGUE,
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
	var shape: Shape

	var type1: Type
	var type2: Type

	var stats: Dictionary[String, Stat]

	var moves: Array[Move]

	func _init(n: String, spr: Texture2D, t1: Type, t2: Type, sh: Shape, st: Dictionary[String, Stat], mo: Array[Move]) -> void:
		speciesName = n
		sprite = spr
		type1 = t1
		type2 = t2
		shape = sh
		stats = st
		moves = mo
