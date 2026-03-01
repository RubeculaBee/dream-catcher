@abstract
class_name Move

var title: String
var accuracy: float
var type: Figment.Type

@abstract
func doEffect(user: Figment, target: Figment)

class LandAttack:
	extends Move

	func _init() -> void:
		title = "Land Attack"
		accuracy = 1
		type = Figment.Type.LAND

	func doEffect(user: Figment, target: Figment):
		print("land attack!")


