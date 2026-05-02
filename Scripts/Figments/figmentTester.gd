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

	figment = Figment.new(load("res://Resources/Figment Blueprints/landTest.tres"), 0)
	dummy = Figment.new(load("res://Resources/Figment Blueprints/seaTest.tres"), 0)
	updateFigment()
	updateDummy()

func _on_landButton_pressed():
	figment = Figment.new(load("res://Resources/Figment Blueprints/landTest.tres"), 0)
	updateFigment()

func _on_seaButton_pressed():
	figment = Figment.new(load("res://Resources/Figment Blueprints/seaTest.tres"), 0)
	updateFigment()

func _on_skyButton_pressed():
	figment = Figment.new(load("res://Resources/Figment Blueprints/skyTest.tres"), 0)
	updateFigment()

func _on_landButton2_pressed():
	dummy = Figment.new(load("res://Resources/Figment Blueprints/landTest.tres"), 0)
	updateDummy()

func _on_seaButton2_pressed():
	dummy = Figment.new(load("res://Resources/Figment Blueprints/seaTest.tres"), 0)
	updateDummy()

func _on_skyButton2_pressed():
	dummy = Figment.new(load("res://Resources/Figment Blueprints/skyTest.tres"), 0)
	updateDummy()

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
		figment.stats.Will.value,
		figment.stats.Coherence.value,
		figment.stats.Lucidity.value,
		figment.stats.Acuity.value,
		figment.stats.Creativity.value,
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

func updateDummy():
	$"Training Dummy".texture = dummy.sprite
	$"Training Dummy/Name".text = dummy.speciesName
	$"Training Dummy/Stats".text = "HP: %s
	
	Will: %s
	Coherence: %s
	Lucidity: %s
	Acuity: %s
	Creativity: %s" % [
		dummy.hp,
		dummy.stats.Will.value,
		dummy.stats.Coherence.value,
		dummy.stats.Lucidity.value,
		dummy.stats.Acuity.value,
		dummy.stats.Creativity.value,
	]

func move(i: int):
	if i < figment.moves.size():
		figment.moves[i].doEffect.call(figment, dummy, figment.moves[i])
		updateFigment()
		updateDummy()
