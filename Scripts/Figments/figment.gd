class_name Figment

var rng = RandomNumberGenerator.new()

var speciesName: String
var sprite: Texture2D
var type1: FigmentBlueprint.Type
var type2: FigmentBlueprint.Type
var shape: Texture2D
var stats: Dictionary[String, Stat]
var moves: Array[Move]

var hp: int
var level: int

var bp: FigmentBlueprint
var startLvl: int

func _init(blueprint: FigmentBlueprint, lvl: int) -> void:
	bp = blueprint

	speciesName = blueprint.speciesName
	sprite = blueprint.sprite
	type1 = blueprint.type1
	type2 = blueprint.type2
	shape = blueprint.shape
	startLvl = lvl
	moves = blueprint.moves

	for move: Move in moves:
		move.doEffect = move.effectScript.main

	stats = {
		"Will": bp.will.duplicate(),
		"Coherence": bp.coherence.duplicate(),
		"Lucidity": bp.lucidity.duplicate(),
		"Acuity": bp.acuity.duplicate(),
		"Creativity": bp.creativity.duplicate(),
	}

	for stat: Stat in self.stats.values():
		stat.value = rng.randi_range(stat.minInit, stat.maxInit)
		stat.growth = rng.randi_range(stat.minGrowth, stat.maxGrowth)
	
	hp = stats.Coherence.value as int * 10
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
