extends Resource

class_name inventoryData

@export var inventorySlots : Array[slotItemData]
@export var figmentPartySlots : Array[slotFigmentData]

# func goes here, because you want it unique to the inventory it is accessing
func onItemSlotClicked(index: int, button :int ) -> void:
	print("hey fucko, why are you touching my inventory")
	pass

func onFigSlotClicked(index: int, button :int ) -> void:
	print("stop tapping the glass")
	pass
