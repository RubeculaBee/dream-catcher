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

	func doEffect(_user: Figment, target: Figment):
		print("land attack!")
		target.hp -= 20

class SeaAttack:
	extends Move

	func _init() -> void:
		title = "Sea Attack"
		accuracy = 1
		type = Figment.Type.SEA

	func doEffect(_user: Figment, target: Figment):
		print("sea attack!")
		target.hp -= 25

class SkyAttack:
	extends Move

	func _init() -> void:
		title = "Sky Attack"
		accuracy = 1
		type = Figment.Type.SKY

	func doEffect(_user: Figment, target: Figment):
		print("sky attack!")
		target.hp -= 10

class Heal:
	extends Move

	func _init() -> void:
		title = "Heal"
		accuracy = 1
		type = Figment.Type.LIGHT

	func doEffect(user: Figment, _target: Figment):
		print("so soothing")
		user.hp += 15

