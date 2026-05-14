extends Resource
class_name Stat

var value: float
@export var minInit: int
@export var maxInit: int

var growth: int
@export var minGrowth: int
@export var maxGrowth: int

var level: int

func increase() -> bool:
	if level >= 20:
		return false
	level+=1
	value+=growth
	return true
