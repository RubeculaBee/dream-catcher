extends PanelContainer

signal slot_clicked(index: int, button :int )

@onready var itemImage: TextureRect = $MarginContainer/ItemImage
@onready var quantityLabel: Label = $QuantityLabel

func setSlotData (incomingSlotData: slotItemData) -> void:
	var itemInSlotData = incomingSlotData.itemInfo
	itemImage.texture = itemInSlotData.itemTexture
	# tooltip_text = "%s\n%s" % [itemInSlotData.itemName, itemInSlotData.description]
	# ^ above line allows you to hover over item to read name and description, not needed for
	# the project but useful to know thats how it works
	if incomingSlotData.quantity > 1:
		quantityLabel.text = "x%s" % incomingSlotData.quantity
		quantityLabel.show()


func _on_gui_input(input: InputEvent) -> void:
	if (input is InputEventMouseButton 
			and (input.is_action_pressed("left_click")or(input.is_action_pressed("right_click")))):
		slot_clicked.emit(get_index(),input.button_index)
		print ("mouse deteced")
	
	
