extends Node

var figment: Figment

func _ready():
	$land_button.pressed.connect(_on_landButton_pressed)
	$sea_button.pressed.connect(_on_seaButton_pressed)
	$sky_button.pressed.connect(_on_skyButton_pressed)

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

func updateFigment():
	$Sprite2D.texture = figment.sprite
	$Sprite2D/Name.text = figment.speciesName
	$Sprite2D/Stats.text = "
	HP: %s
	
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
