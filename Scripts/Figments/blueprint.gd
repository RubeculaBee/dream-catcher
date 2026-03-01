class_name Blueprint

var speciesName: String
var sprite: Texture2D

var type1: Figment.Type
var type2: Figment.Type

var stats: Dictionary[String, Stat]

var moves: Array[Move]

func _init(n: String, spr: Texture2D, t1: Figment.Type, t2: Figment.Type, st: Dictionary[String, Stat], mo: Array[Move]) -> void:
	speciesName = n
	sprite = spr
	type1 = t1
	type2 = t2
	stats = st
	moves = mo