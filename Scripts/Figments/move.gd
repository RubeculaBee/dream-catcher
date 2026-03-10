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
		func(user: Figment, target: Figment): print("Land Attack!"); target.takeDamage(user.stats.will.value, Figment.Type.LAND)
	),
	"seaAttack": Move.new(
		"Sea Attack",
		0.95,
		Figment.Type.SEA,
		func(user: Figment, target: Figment): print("Sea Attack!"); target.takeDamage(user.stats.will.value, Figment.Type.SEA)
	),
	"skyAttack": Move.new(
		"Sky Attack",
		1,
		Figment.Type.SKY,
		func(user: Figment, target: Figment): print("Sky Attack!"); target.takeDamage(user.stats.will.value, Figment.Type.SKY)
	),
	"heal": Move.new(
		"Heal",
		1,
		Figment.Type.LIGHT,
		func(user: Figment, _target: Figment): print("so soothing..."); user.hp += 10
	)
}
