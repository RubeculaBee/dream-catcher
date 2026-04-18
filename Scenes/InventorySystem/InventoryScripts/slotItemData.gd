extends Resource

class_name slotItemData

const MAX_STACK_SIZE: int = 99

@export var itemInfo : itemData
@export_range (1, MAX_STACK_SIZE)
var quantity: int = 1:
	set = setQuantity # setter function, when quantity is changed it validates the change
	
func setQuantity(value: int) -> void:
	quantity = value;
	if quantity > 1 and !itemInfo.stackable:
		quantity =1
		push_error("%s is not stackable, setting quantity to 1" % itemInfo.itemName)
