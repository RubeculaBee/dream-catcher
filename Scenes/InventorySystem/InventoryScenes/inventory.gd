extends PanelContainer

const slotRef = preload("res://Scenes/InventorySystem/InventoryScenes/slotItem.tscn")
@onready var itemGrid: GridContainer = $"MarginContainer/ItemGrid"


func _ready() -> void:
	var startingInv = preload("res://Scenes/InventorySystem/testResources/testInv.tres")
	populateItemGrid(startingInv.inventorySlots)

func populateItemGrid(slotData: Array[slotItemData]) -> void:
	for invSlot in itemGrid.get_children():
		invSlot.queue_free()
		
	for x in slotData:
		var aSlot = slotRef.instantiate()
		itemGrid.add_child(aSlot)
		
	
