extends Resource
class_name Move

@export var title: String
@export var accuracy: float
@export var power: int
@export var type: FigmentBlueprint.Type
@export var effectScript: Script
var doEffect: Callable

static var typeChart: = [
	[  1,   1,   1,   1,   1,   1,   1,   1,   1, 0.75],
	[  1,   1,   2, 0.5,   1,   1,   2,   1, 0.5, 0.75],
	[  1, 0.5,   1,   2,   2,   1,   1, 0.5,   1, 0.75],
	[  1,   2, 0.5,   1,   1, 0.5,   1,   1,   1, 0.75],
	[  1,   1,   1,   2,   2, 0.5,   2, 0.5,   2, 0.75],
	[  1,   2, 0.5, 0.5, 0.5,   1, 0.5,   1,   1, 0.75],
	[  1, 0.5,   1,   2,   2,   1, 0.5,   2,   2, 0.75],
	[  1, 0.5,   1, 0.5,   2, 0.5,   2,   2,   1, 0.75],
	[  1,   2,   1,   1, 0.5,   2,   1,   1, 0.5, 0.75],
	[  1, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1.5, 1]
]
