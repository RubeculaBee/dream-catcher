extends Node

signal slotFigClicked(index: int, button :int )

@onready var figmentImage: TextureRect = $MarginContainer/MainFigmentSection/FigmentImage
@onready var nameLabel: Label = $MarginContainer/MainFigmentSection/InfoBlock/InfoLine/NameLabel
@onready var mainFigmentSection: HBoxContainer = $MarginContainer/MainFigmentSection

func setFigSlotData(incomingFigData:slotFigmentData) ->void:
	var figInSlotData = incomingFigData.figmentInfo
	nameLabel.text = figInSlotData.speciesName
	figmentImage.texture = figInSlotData.sprite
	
func emptyFigSlot(incomingFigData:slotFigmentData) -> void:
	mainFigmentSection.hide()
	

func _on_gui_input(input: InputEvent) -> void:
	if (input is InputEventMouseButton 
			and (input.is_action_pressed("left_click")or(input.is_action_pressed("right_click")))):
		slotFigClicked.emit(get_index(),input.button_index)
		print ("mouse deteced")
