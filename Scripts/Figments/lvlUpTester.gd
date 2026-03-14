extends Node

var figment: Figment
var lShards: int
var indicators: Array[Array]

func _ready() -> void:
	figment = Figment.new("seaTest")
	$Figment.texture = figment.sprite
	$Level.text = "Level: %s" % figment.level

	setupLvlIndicator()
	connectSignals()

func connectSignals():
	$Stats/Button.pressed.connect(levelUp.bind(0))
	$Stats/Button2.pressed.connect(levelUp.bind(1))
	$Stats/Button3.pressed.connect(levelUp.bind(2))
	$Stats/Button4.pressed.connect(levelUp.bind(3))
	$Stats/Button5.pressed.connect(levelUp.bind(4))

func levelUp(statNum: int):
	var statname: String = figment.stats.keys()[statNum]
	indicators[statNum][figment.stats[statname].level].color = Color.YELLOW
	figment.levelUp(statname)

func setupLvlIndicator():
	for j in range(5):
		indicators.append([])
		for i in range(20):
			indicators[j].append(ColorRect.new())
			indicators[j][i].size = Vector2(16,16)
			indicators[j][i].color = Color.GRAY
			indicators[j][i].position = Vector2(272+20*i,240+62*j)
			add_child(indicators[j][i])
