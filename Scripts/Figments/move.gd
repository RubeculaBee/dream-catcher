extends Node
class_name Move

var title: String
var accuracy: float
var type: Figment.Type
var effect: Variant #should be a function

func _init(t: String, a: float, ty: Figment.Type, e: Variant) -> void:
	title = t
	accuracy = a
	type = ty
	effect = e

static var moveList: Dictionary = {
	"landAttack": Move.new(
		"Land Attack",
		1,
		Figment.Type.LAND,
		func(): print("land attack")
	)
}