extends Resource

class_name slotItemData

const MAX_STACK_SIZE: int = 99

@export var item: itemData
@export_range (1, MAX_STACK_SIZE) var quantity: int = 1
