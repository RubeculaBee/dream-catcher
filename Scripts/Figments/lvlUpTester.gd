extends Node

var figment: Figment
var lShards: int
var indicators: Array[Array]

func _ready() -> void:
	figment = Figment.new("seaTest")
	lShards = 10

	setupLvlIndicator()
	connectSignals()
	updateLevels()
	updateFigment()

func updateFigment():
	$Figment.texture = figment.sprite
	$Figment/Name.text = figment.speciesName
	for row: Array[ColorRect] in indicators:
		for ind: ColorRect in row:
			ind.color = Color.GRAY


func updateLevels():
	$Level.text = "Level: %s" % figment.level
	$LShards.text = "LShards: %s" % lShards
	for button: Button in $Stats.get_children():
		button.get_child(0).text = "lvl: %s" % figment.stats[button.text.to_lower()].level
		button.get_child(1).text = "value: %s\ngrowth: %s" %[
			figment.stats[button.text.to_lower()].value,
			figment.stats[button.text.to_lower()].growth
		]


func connectSignals():
	$Stats/Button.pressed.connect(levelUp.bind(0))
	$Stats/Button2.pressed.connect(levelUp.bind(1))
	$Stats/Button3.pressed.connect(levelUp.bind(2))
	$Stats/Button4.pressed.connect(levelUp.bind(3))
	$Stats/Button5.pressed.connect(levelUp.bind(4))
	$LShards/Button.pressed.connect(printShards)

	$Figment/Regenerate/Land.pressed.connect(newFigment.bind("landTest"))
	$Figment/Regenerate/Sea.pressed.connect(newFigment.bind("seaTest"))
	$Figment/Regenerate/Sky.pressed.connect(newFigment.bind("skyTest"))

func newFigment(bp: String):
	figment = Figment.new(bp)
	updateLevels()
	updateFigment()

func printShards():
	lShards += 5
	updateLevels()

func levelUp(statNum: int):
	if lShards > 0:
		var statname: String = figment.stats.keys()[statNum]
		if figment.levelUp(statname):
			indicators[statNum][figment.stats[statname].level-1].color = Color.YELLOW
			lShards-=1
			updateLevels()
		

func setupLvlIndicator():
	for j in range(5):
		indicators.append([])
		for i in range(20):
			indicators[j].append(ColorRect.new())
			indicators[j][i].size = Vector2(16,16)
			indicators[j][i].color = Color.GRAY
			indicators[j][i].position = Vector2(272+20*i,240+62*j)
			add_child(indicators[j][i])
