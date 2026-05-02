static var rng = RandomNumberGenerator.new()

static func main(user: Figment, target: Figment, move: Move):
	
	var hitChance = move.accuracy+(user.stats.Acuity.value / 200)
	if(rng.randf() > hitChance):
		print("Missed!")
		return

	var damage: float = move.power
	var crit = rng.randf() < 0.04+(0.002*user.stats.Creativity.value)

	damage *= (user.stats.Will.value/target.stats.Lucidity.value)
	var typeAdv = Move.typeChart[move.type][target.type1] * Move.typeChart[move.type][target.type2]
	if typeAdv > 1: print("Super Effective!")
	if typeAdv < 1: print("Not Very Effective!")
	damage *= typeAdv
	if crit:
		print("Critical Hit!")
		damage *= 1.5
	damage *= (0.8 + randf()*0.4)


	damage = max(roundi(damage), 1)
	print("%s did %s damage to %s!" % [user.speciesName, roundi(damage), target.speciesName])
	target.hp -= damage as int
