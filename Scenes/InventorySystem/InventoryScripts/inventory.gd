extends PanelContainer

const slotItemRef = preload("res://Scenes/InventorySystem/InventoryScenes/slotItem.tscn")
@onready var itemGrid: GridContainer = $MarginContainer/HBoxContainer/VBoxContainer/ItemGrid

const slotFigRef = preload("res://Scenes/InventorySystem/InventoryScenes/SlotFigment.tscn")
@onready var figmentPartyGrid: GridContainer = $MarginContainer/HBoxContainer/FigmentPartyGrid


# this just generates test inventory
#func _ready() -> void:
	#var startingInv = preload("res://Scenes/InventorySystem/testResources/testInv.tres")
	#populateItemGrid(startingInv.inventorySlots)
	
func setWholeInventoryData(invData: inventoryData) -> void:
		populateItemGrid(invData)
		populateFigmentPartyGrid(invData)

func populateItemGrid(invData: inventoryData) -> void:
	for child in itemGrid.get_children():
		child.queue_free()
		
	for currentSlotData in invData.inventorySlots:
		var slotInstance = slotItemRef.instantiate()
		itemGrid.add_child(slotInstance)
		
		# signal (slot_clicked) from slotItem.gd is connected here when there is a mouse press on a slot
		# this then runs onItemSlotClicked function in inventoryData.gd
		slotInstance.slotItemClicked.connect(invData.onItemSlotClicked) 
		
		if currentSlotData != null:
			#print("Debugging slot data: " , currentSlotData.itemInfo.itemName)
			slotInstance.setSlotData(currentSlotData)

func populateFigmentPartyGrid(figData: inventoryData)-> void:
	for child in figmentPartyGrid.get_children():
		child.queue_free()
		
	for currentSlotData in figData.figmentPartySlots:
		var slotInstance = slotFigRef.instantiate()
		figmentPartyGrid.add_child(slotInstance)
		
		slotInstance.slotFigClicked.connect(figData.onFigSlotClicked)
		
		if currentSlotData != null:
			#print("Debugging slot data: " , currentSlotData.itemInfo.itemName)
			slotInstance.setFigSlotData(currentSlotData)
		else:
			slotInstance.emptyFigSlot(currentSlotData)
