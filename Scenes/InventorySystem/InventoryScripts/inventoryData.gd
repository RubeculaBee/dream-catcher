extends Resource

class_name inventoryData

@export var inventorySlots : Array[slotItemData]

# func goes here, because you want it unique to the inventory it is accessing
func onSlotClicked(index: int, button :int ) -> void:
	#print("hey fucko, why are you touching my inventory")
	pass
