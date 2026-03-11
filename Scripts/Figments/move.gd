class_name Move

var rng = RandomNumberGenerator.new()

var title: String
var accuracy: float
var power: int
var type: Figment.Type
var doEffect: Callable

func _init(ti: String, ac: float, po: int, ty: Figment.Type, ef: Callable):
	title = ti
	accuracy = ac
	power = po
	type = ty
	if(ef == basicDamage):
		doEffect = bd
	else: doEffect = ef

static func basicDamage():
	# this is a placeholder that seems unnecessary but i promise it is ok i can explain-
	pass

func bd(user: Figment, target: Figment):
	
	var hitChance = self.accuracy+(user.stats.acuity.value / 200)
	if(rng.randf() > hitChance):
		print("Missed!")
		return

	const SCALAR = 1
	var damage: float = self.power
	var crit = rng.randf() < 0.04+(0.002*user.stats.creativity.value)

	damage *= (user.stats.will.value/target.stats.lucidity.value)
	var typeAdv = typeChart[self.type][target.type1] * typeChart[self.type][target.type2]
	if typeAdv > 1: print("Super Effective!")
	if typeAdv < 1: print("Not Very Effective!")
	damage *= typeAdv
	if crit:
		print("Critical Hit!")
		damage *= 1.5
	damage *= SCALAR

	damage = max(roundi(damage), 1)
	print("%s did %s damage to %s!" % [user.speciesName, roundi(damage), target.speciesName])
	target.hp -= damage as int


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

static var moveList: Dictionary[String, Move] = {
	"landAttack": Move.new(
		"Land Attack",
		0.65,
		15,
		Figment.Type.LAND,
		basicDamage
	),
	"seaAttack": Move.new(
		"Sea Attack",
		0.70,
		10,
		Figment.Type.SEA,
		basicDamage
	),
	"skyAttack": Move.new(
		"Sky Attack",
		0.75,
		5,
		Figment.Type.SKY,
		basicDamage
	),
	"heal": Move.new(
		"Heal",
		1,
		0,
		Figment.Type.LIGHT,
		func(user: Figment, _target: Figment): print("so soothing..."); user.hp += 10
	)
}
