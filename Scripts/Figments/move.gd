class_name Move

var title: String
var accuracy: float
var type: Figment.Type
var doEffect: Callable

func _init(ti: String, ac: float, ty: Figment.Type, ef: Callable):
	title = ti
	accuracy = ac
	type = ty
	doEffect = ef

static var moveList: Dictionary[String, Move] = {
	"landAttack": Move.new(
		"Land Attack",
		0.8,
		Figment.Type.LAND,
		func(_user: Figment, target: Figment): print("Land Attack!"); target.hp -= 25
	),
	"seaAttack": Move.new(
		"Sea Attack",
		0.95,
		Figment.Type.SEA,
		func(_user: Figment, target: Figment): print("Sea Attack!"); target.hp -= 15
	),
	"skyAttack": Move.new(
		"Sky Attack",
		1,
		Figment.Type.SKY,
		func(_user: Figment, target: Figment): print("Sky Attack!"); target.hp -= 10
	),
	"heal": Move.new(
		"Heal",
		1,
		Figment.Type.LIGHT,
		func(user: Figment, _target: Figment): print("so soothing..."); user.hp += 10
	)
}
