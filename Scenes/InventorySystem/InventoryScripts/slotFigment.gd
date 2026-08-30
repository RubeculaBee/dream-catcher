extends Node

signal slotFigClicked(index: int, button :int )

@onready var figmentImage: TextureRect = $MarginContainer/MainFigmentSection/FigmentImage
@onready var nameLabel: Label = $MarginContainer/MainFigmentSection/InfoBlock/InfoLine/NameLabel
@onready var mainFigmentSection: HBoxContainer = $MarginContainer/MainFigmentSection
@onready var healthBar: ProgressBar = $MarginContainer/MainFigmentSection/InfoBlock/HealthBar
@onready var healthNumbers: Label = $MarginContainer/MainFigmentSection/InfoBlock/HealthBar/HealthNumbers
@onready var levelLabel: Label = $MarginContainer/MainFigmentSection/InfoBlock/InfoLine/LevelLabel

@onready var will: Label = $MarginContainer/MainFigmentSection/InfoBlock/StatBox/Will
@onready var coherence: Label = $MarginContainer/MainFigmentSection/InfoBlock/StatBox/Coherence
@onready var lucidity: Label = $MarginContainer/MainFigmentSection/InfoBlock/StatBox/Lucidity
@onready var acuity: Label = $MarginContainer/MainFigmentSection/InfoBlock/StatBox/Acuity
@onready var creativity: Label = $MarginContainer/MainFigmentSection/InfoBlock/StatBox/Creativity


func setFigSlotData(incomingFigData:slotFigmentData) ->void:
	if (mainFigmentSection.visible == false):
		mainFigmentSection.show()
	var figInSlotData = incomingFigData.figmentInfo
	# TODO move the line belowline  and figure out why the fig resource has the BP var and a seperate
	# figment Blueprint Section, and what to do with it
	#figInSlotData.populateFigData(incomingFigData.figmentInfo,5) #-----------------testing
	# TODO the 5 is just because i did not know what else to put ^
	
	nameLabel.text = figInSlotData.speciesName
	figmentImage.texture = figInSlotData.sprite
	healthBar.max_value = figInSlotData.maxhp
	if (figInSlotData.hp > figInSlotData.maxhp):
		figInSlotData.hp = figInSlotData.maxhp
	healthBar.value =  figInSlotData.hp
	levelLabel.text =  "Lv:" + str(figInSlotData.level) + " "
	healthNumbers.text = str(figInSlotData.hp) + "/" + str(figInSlotData.maxhp)
	
	#print(figInSlotData.hp)
	#print(figInSlotData.stats)
	
	#will.text = "W: " + str(figInSlotData.stats["Will"].value)
	#coherence.text = "Co: " + str(figInSlotData.stats["Coherence"].value)
	#lucidity.text = "L: " + str(figInSlotData.stats["Lucidity"].value)
	#acuity.text = "A: " + str(figInSlotData.stats["Acuity"].value)
	#creativity.text = "Cr: " + str(figInSlotData.stats["Creativity"].value)
	
	# TODO xp bar and code for how xp is calculated
	
func emptyFigSlot() -> void:
	mainFigmentSection.hide()
	

func _on_gui_input(input: InputEvent) -> void:
	if (input is InputEventMouseButton 
			and (input.is_action_pressed("left_click")or(input.is_action_pressed("right_click")))):
		slotFigClicked.emit(get_index(),input.button_index)
