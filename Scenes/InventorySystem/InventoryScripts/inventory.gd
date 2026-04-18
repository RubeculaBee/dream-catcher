extends PanelContainer

const slotRef = preload("res://Scenes/InventorySystem/InventoryScenes/slotItem.tscn")
@onready var itemGrid: GridContainer = $"MarginContainer/ItemGrid"


func _ready() -> void:
	var startingInv = preload("res://Scenes/InventorySystem/testResources/testInv.tres")
	populateItemGrid(startingInv.inventorySlots)

func populateItemGrid(invData: Array[slotItemData]) -> void:
	for child in itemGrid.get_children():
		child.queue_free()
		
	for currentSlotData in invData:
		var slotInstance = slotRef.instantiate()
		itemGrid.add_child(slotInstance)
		
		if currentSlotData != null:
			#print("Debugging slot data: " , currentSlotData.itemInfo.itemName)
			slotInstance.setSlotData(currentSlotData)
		
