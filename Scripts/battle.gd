extends Control
class_name BattleScene

# Variables
var menuSelector = 0 # determines which menu is displayed in the battle
enum {STARTING_FIGMENT,BASE_MENU,FIGHT_MENU,SWITCH_MENU,INVENTORY_MENU,FLEE_MENU}
# 0 = choose starting figment
# 1 = fight/switch/bag/flee menu
# 2 = fight menu
# 3 = switch menu
# 4 = bag menu
# 5 = flee menu

# Signals
#signal textBoxClosed
signal fleeConfirmed ## emit when the player presses the flee button in the flee menu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$TextBox.hide()
	$ActionPanel.hide()
	changeActionPanel("Figment 1","Figment 2","Figment 3","Figment 4","Back")
	displayTextBox("You have encountered a real bad fella!")
	$ActionPanel/Actions/BottomActions/BottomMiddleAction.hide()
	return

#this function runs whenever an button is pressed
func _input(_event) -> void:
	if(Input.is_action_just_released("make_battle_text_box_disapear") ): # idk how to add check yet to make sure textbox is visible
		$TextBox.hide()
		$ActionPanel.show()
			
# this function controls what text will appear on the buttons depending on what number was fed into it
func menuSwitchFunction(menuNum):
	if(menuNum == BASE_MENU):
		changeActionPanel("Fight","Switch","Inventory","Flee","Back")
	elif(menuNum == FIGHT_MENU):
		changeActionPanel("Attack 1","Attack 2","Attack 3","Attack 4","Back")
	elif(menuNum == SWITCH_MENU):
		changeActionPanel("Figment 1 (out)","Figment 2","Figment 3","Figment 4","Back")
	elif(menuNum == INVENTORY_MENU):
		changeActionPanel("Item 1","Item 2","Item 3","Item 4","Back")
	elif(menuNum == FLEE_MENU):
		changeActionPanel("test","test","Flee","Back","test")
		
#this function actually changes the text on the buttons
func changeActionPanel(text1,text2,text3,text4,text5):
	$ActionPanel/Actions/TopActions/TopLeftAction.text = text1
	$ActionPanel/Actions/TopActions/TopRightAction.text = text2
	$ActionPanel/Actions/BottomActions/BottomLeftAction.text = text3
	$ActionPanel/Actions/BottomActions/BottomRightAction.text = text4
	$ActionPanel/Actions/BottomActions/BottomMiddleAction.text = text5

#This function just displays the textbox with whatever text was fed into it
func displayTextBox(text):
	$TextBox.show()
	$ActionPanel.hide()
	$TextBox.text = text
	return 

func _on_top_left_move_pressed() -> void:
	displayTextBox($ActionPanel/Actions/TopActions/TopLeftAction.text + " selected")  ## fill in with moves pulled from figment object
	if (menuSelector == BASE_MENU):
		menuSelector = FIGHT_MENU #sets the active menu to the menu where you can choose a figments attacks
		menuSwitchFunction(menuSelector)
		$ActionPanel/Actions/BottomActions/BottomMiddleAction.show()
	elif (menuSelector == STARTING_FIGMENT):
			menuSelector = BASE_MENU #sets the active menu to the battle menu after figments have been selected
			menuSwitchFunction(menuSelector)

func _on_top_right_move_pressed() -> void:
	displayTextBox($ActionPanel/Actions/TopActions/TopRightAction.text + " selected")  ## fill in with moves pulled from figment object
	if (menuSelector == BASE_MENU):
		menuSelector = SWITCH_MENU # sets the active menu where you can switch between your figments 
		menuSwitchFunction(menuSelector)
		$ActionPanel/Actions/BottomActions/BottomMiddleAction.show()
	elif (menuSelector == STARTING_FIGMENT):
			menuSelector = BASE_MENU #sets the active menu to the battle menu after figments have been selected
			menuSwitchFunction(menuSelector)
		
func _on_bottom_left_move_pressed() -> void:
	displayTextBox($ActionPanel/Actions/BottomActions/BottomLeftAction.text + " selected")  ## fill in with moves pulled from figment object
	if (menuSelector == BASE_MENU):
		menuSelector = INVENTORY_MENU # sets the active menu to the 
		menuSwitchFunction(menuSelector)
		$ActionPanel/Actions/BottomActions/BottomMiddleAction.show()
	elif (menuSelector == STARTING_FIGMENT):
			menuSelector = BASE_MENU #sets the menu to the battle menu after figments have been selected
			menuSwitchFunction(menuSelector)
	elif (menuSelector == FLEE_MENU):
		fleeConfirmed.emit();
		
func _on_bottom_right_move_pressed() -> void:
	displayTextBox($ActionPanel/Actions/BottomActions/BottomRightAction.text + " selected")  ## fill in with moves pulled from figment object
	if (menuSelector == BASE_MENU):
		menuSelector = FLEE_MENU
		menuSwitchFunction(menuSelector)
		$ActionPanel/Actions/TopActions.hide() 
	elif (menuSelector == STARTING_FIGMENT):
			menuSelector = BASE_MENU #sets the menu to the battle menu after figments have been selected
			menuSwitchFunction(menuSelector)
	elif (menuSelector == FLEE_MENU): #This brings back up the base menu if they are not elif's code does not work properly
		menuSelector = BASE_MENU
		$ActionPanel/Actions/BottomActions/BottomMiddleAction.hide() 
		$ActionPanel/Actions/TopActions.show()
		menuSwitchFunction(menuSelector)
		
func _on_bottom_middle_action_pressed() -> void:
	menuSelector = BASE_MENU
	$ActionPanel/Actions/BottomActions/BottomMiddleAction.hide() 
	menuSwitchFunction(menuSelector) 
