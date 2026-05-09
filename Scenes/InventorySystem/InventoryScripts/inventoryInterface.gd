extends Control

@onready var player_inventory: PanelContainer = $PlayerInventory

func setPlayerInventory(playerInv : inventoryData) -> void:
	player_inventory.setInventoryData(playerInv)
