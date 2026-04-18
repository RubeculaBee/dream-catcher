extends PanelContainer

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
