extends Control

@onready var playerInventory: PanelContainer = $PlayerInventory

func setPlayerInventory(playerInv : inventoryData) -> void:
	playerInventory.setWholeInventoryData(playerInv)
