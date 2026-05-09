extends PanelContainer

const slotRef = preload("res://Scenes/InventorySystem/InventoryScenes/slotItem.tscn")
@onready var itemGrid: GridContainer = $MarginContainer/HBoxContainer/VBoxContainer/ItemGrid

# this just generates test inventory
#func _ready() -> void:
	#var startingInv = preload("res://Scenes/InventorySystem/testResources/testInv.tres")
	#populateItemGrid(startingInv.inventorySlots)
	
func setInventoryData(invData: inventoryData) -> void:
		populateItemGrid(invData)

func populateItemGrid(invData: inventoryData) -> void:
	for child in itemGrid.get_children():
		child.queue_free()
		
	for currentSlotData in invData.inventorySlots:
		var slotInstance = slotRef.instantiate()
		itemGrid.add_child(slotInstance)
		
		# signal (slot_clicked) from slotItem.gd is connected here when there is a mouse press on a slot
		# this then runs onSlotClicked function in inventoryData.gd
		slotInstance.slot_clicked.connect(invData.onSlotClicked) 
		
		if currentSlotData != null:
			#print("Debugging slot data: " , currentSlotData.itemInfo.itemName)
			slotInstance.setSlotData(currentSlotData)
