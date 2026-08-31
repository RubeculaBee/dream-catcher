extends FigmentBlueprint

class_name Figment

var rng = RandomNumberGenerator.new()

@export var figmentStats: Dictionary[String, float] = {
		"Will": 1,
		"Coherence": 1,
		"Lucidity": 1,
		"Acuity": 1,
		"Creativity": 1,
	}
@export var knownMoves: Array[Move]

@export var maxhp: int
@export var hp: int
@export var xp: int
@export var level: int 

#@export var bp: FigmentBlueprint # commented out to remove duplicate blueprints
@export var startLvl: int

# dont want to use init here, because if you create a Figment any way other then .new() it won't run _init
# this was causing the inventory to only have null for the data
#func _init(blueprint: FigmentBlueprint, lvl: int) -> void:

#this is to run when creating a new figment 
func populateFigData(blueprint: FigmentBlueprint, lvl: int)-> void:
	#bp = blueprint
	
	self.speciesName = blueprint.speciesName
	self.sprite = blueprint.sprite
	self.shape = blueprint.shape 
	self.type1 = blueprint.type1
	self.type2 = blueprint.type2
	# TODO have array of known moves not be an array of all the moves it can ever know, and rather just 4 of them
	knownMoves = blueprint.allKnowableMoves
	
	#TODO not sure the dif between startlvl and level, and why there is 2
	startLvl = lvl
	level = 1
	xp = 0

	for move: Move in knownMoves:
		move.doEffect = move.effectScript.main

	speciesStats = {
		"Will": blueprint.speciesStats["Will"].duplicate(),
		"Coherence": blueprint.speciesStats["Coherence"].duplicate(),
		"Lucidity": blueprint.speciesStats["Lucidity"].duplicate(),
		"Acuity": blueprint.speciesStats["Acuity"].duplicate(),
		"Creativity": blueprint.speciesStats["Creativity"].duplicate(),
	}
	
	
	
	#sets all figment specific values, was not able to figure out how to get two dictionaries inside a for loop to share data so did it this way
	figmentStats["Will"] = rng.randi_range(speciesStats["Will"].minInit, speciesStats["Will"].maxInit)
	figmentStats["Coherence"] = rng.randi_range(speciesStats["Coherence"].minInit, speciesStats["Coherence"].maxInit)
	figmentStats["Lucidity"] = rng.randi_range(speciesStats["Lucidity"].minInit, speciesStats["Lucidity"].maxInit)
	figmentStats["Acuity"] = rng.randi_range(speciesStats["Acuity"].minInit, speciesStats["Acuity"].maxInit)
	figmentStats["Creativity"] = rng.randi_range(speciesStats["Creativity"].minInit, speciesStats["Creativity"].maxInit)
	
	
	#for stat: Stat in self.speciesStats.values():
	#	#stat.value = rng.randi_range(stat.minInit, stat.maxInit)
	#	stat.growth = rng.randi_range(stat.minGrowth, stat.maxGrowth)
		
		
		
	maxhp = figmentStats["Coherence"] as int * 10
	hp = maxhp # when figment is created it gives it full health

#	for i in range(min(startLvl*5 + randi_range(0,4), 100)):
#		while !self.levelUp(self.stats.keys()[randi_range(0,4)]):
#			pass

#func levelUp(statName: String) -> bool:
#	if !self.stats[statName].increase():
#		return false
#	
#	var avg: float = 0
#	for stat: Stat in self.stats.values():
#		avg += stat.level
#	avg /= 5
#
#	self.level = floori(avg)
#	return true
