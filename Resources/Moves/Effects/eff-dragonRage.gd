static func main(_user: Figment, target: Figment, move: Move):
	if randf() < move.accuracy:
		target.hp -= move.power