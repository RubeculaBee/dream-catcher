extends Node

var figment: Figment
var dummy: Figment

func _ready():
	$land_button.pressed.connect(_on_landButton_pressed)
	$sea_button.pressed.connect(_on_seaButton_pressed)
	$sky_button.pressed.connect(_on_skyButton_pressed)
	$land_button2.pressed.connect(_on_landButton2_pressed)
	$sea_button2.pressed.connect(_on_seaButton2_pressed)
	$sky_button2.pressed.connect(_on_skyButton2_pressed)

	figment = Figment.new("seaTest")
	dummy = Figment.new("landTest")
	updateFigment()

func _on_landButton_pressed():
	print("creating land figment...")
	figment = Figment.new("landTest")
	updateFigment()

func _on_seaButton_pressed():
	print("creating sea figment...")
	figment = Figment.new("seaTest")
	updateFigment()

func _on_skyButton_pressed():
	print("creating sky figment...")
	figment = Figment.new("skyTest")
	updateFigment()

func _on_landButton2_pressed():
	print("creating land figment...")
	dummy = Figment.new("landTest")
	updateFigment()

func _on_seaButton2_pressed():
	print("creating sea figment...")
	dummy = Figment.new("seaTest")
	updateFigment()

func _on_skyButton2_pressed():
	print("creating sky figment...")
	dummy = Figment.new("skyTest")
	updateFigment()

func updateFigment():
	$Sprite2D.texture = figment.sprite
	$Sprite2D/Name.text = figment.speciesName
	$Sprite2D/Stats.text = "HP: %s
	
	Will: %s
	Coherence: %s
	Lucidity: %s
	Acuity: %s
	Creativity: %s" % [
		figment.hp,
		figment.stats.will.value,
		figment.stats.coherence.value,
		figment.stats.lucidity.value,
		figment.stats.acuity.value,
		figment.stats.creativity.value,
	]
	for i in range(4):
		var button: Button = $Sprite2D/Moves.get_child(i)

		for connection in button.pressed.get_connections():
			button.pressed.disconnect(connection.callable)

		if i < figment.moves.size():
			button.text = figment.moves[i].title
			button.pressed.connect(move.bind(i))
		else:
			button.text = ""

	$"Training Dummy".texture = dummy.sprite
	$"Training Dummy/Name".text = figment.speciesName
	$"Training Dummy/Stats".text = "HP: %s
	
	Will: %s
	Coherence: %s
	Lucidity: %s
	Acuity: %s
	Creativity: %s" % [
		dummy.hp,
		dummy.stats.will.value,
		dummy.stats.coherence.value,
		dummy.stats.lucidity.value,
		dummy.stats.acuity.value,
		dummy.stats.creativity.value,
	]

func move(i: int):
	if i < figment.moves.size():
		figment.moves[i].doEffect.call(figment, dummy)
		updateFigment()
