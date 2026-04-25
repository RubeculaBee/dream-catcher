class_name Stat

var rng = RandomNumberGenerator.new()

var value: float
var minInit: int
var maxInit: int

var growth: int
var minGrowth: int
var maxGrowth: int

var level: int

func _init(minI: int, maxI: int, minG: int, maxG: int) -> void:
	minInit = minI
	maxInit = maxI
	minGrowth = minG
	maxGrowth = maxG

func copy() -> Stat: 
	var stat = Stat.new(self.minInit, self.maxInit, self.minGrowth, self.maxGrowth)
	stat.value = self.value
	stat.growth = self.growth
	return stat 

func increase() -> bool:
	if level >= 20:
		return false
	level+=1
	value+=growth
	return true