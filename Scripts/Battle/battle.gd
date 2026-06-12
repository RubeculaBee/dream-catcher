extends Control
class_name BattleScene
# todo
# change all the calls for Text box and Action Panel code
# they should instead be variables that hold the address, its quicker that way
# that way It doesn't have to trace the address, every single time 

# user interactable buttons
@onready var topLeftButton: Button = $ActionPanel/Actions/TopActions/TopLeftAction
@onready var topRightButton: Button = $ActionPanel/Actions/TopActions/TopRightAction
@onready var bottomLeftButton: Button = $ActionPanel/Actions/BottomActions/BottomLeftAction
@onready var bottomMiddleButton: Button = $ActionPanel/Actions/BottomActions/BottomMiddleAction
@onready var bottomRightButton: Button = $ActionPanel/Actions/BottomActions/BottomRightAction

@onready var textBox: Label = $TextBox
@onready var actionPanel: Panel = $ActionPanel
@onready var topActions: HBoxContainer = $ActionPanel/Actions/TopActions
@onready var bottomActions: HBoxContainer = $ActionPanel/Actions/BottomActions




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
	textBox.hide()
	actionPanel.hide()
	changeActionPanel("Figment 1","Figment 2","Figment 3","Figment 4","Back")
	displayTextBox("You have encountered a real bad fella!")
	bottomMiddleButton.hide()
	return

#this function runs whenever an button is pressed
func _input(_event) -> void:
	if(Input.is_action_just_released("make_battle_text_box_disapear") ): # idk how to add check yet to make sure textbox is visible
		textBox.hide()
		actionPanel.show()
	# test code for pressing 1-4 instead of manually pressing buttons with mouse
	elif (Input.is_action_just_pressed("test")):
		_on_top_left_move_pressed()
			
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
	topLeftButton.text = text1
	topRightButton.text = text2
	bottomLeftButton.text = text3
	bottomRightButton.text = text4
	bottomMiddleButton.text = text5
	
#This function just displays the textbox with whatever text was fed into it
func displayTextBox(text):
	textBox.show()
	actionPanel.hide()
	textBox.text = text
	return 

func _on_top_left_move_pressed() -> void:
	displayTextBox(topLeftButton.text + " selected")  ## fill in with moves pulled from figment object
	if (menuSelector == BASE_MENU):
		menuSelector = FIGHT_MENU #sets the active menu to the menu where you can choose a figments attacks
		menuSwitchFunction(menuSelector)
		bottomMiddleButton.show()
	elif (menuSelector == STARTING_FIGMENT):
		menuSelector = BASE_MENU #sets the active menu to the battle menu after figments have been selected
		menuSwitchFunction(menuSelector)

func _on_top_right_move_pressed() -> void:
	displayTextBox(topRightButton.text + " selected")  ## fill in with moves pulled from figment object
	if (menuSelector == BASE_MENU):
		menuSelector = SWITCH_MENU # sets the active menu where you can switch between your figments 
		menuSwitchFunction(menuSelector)
		bottomMiddleButton.show()
	elif (menuSelector == STARTING_FIGMENT):
		menuSelector = BASE_MENU #sets the active menu to the battle menu after figments have been selected
		menuSwitchFunction(menuSelector)
		
func _on_bottom_left_move_pressed() -> void:
	displayTextBox(bottomLeftButton.text + " selected")  ## fill in with moves pulled from figment object
	if (menuSelector == BASE_MENU):
		menuSelector = INVENTORY_MENU # sets the active menu to the inventory menu
		menuSwitchFunction(menuSelector)
		bottomMiddleButton.show()
	elif (menuSelector == STARTING_FIGMENT):
		menuSelector = BASE_MENU #sets the menu to the battle menu after figments have been selected
		menuSwitchFunction(menuSelector)
	elif (menuSelector == FLEE_MENU):
		fleeConfirmed.emit();
		
func _on_bottom_right_move_pressed() -> void:
	displayTextBox(bottomRightButton.text + " selected")  ## fill in with moves pulled from figment object
	if (menuSelector == BASE_MENU):
		menuSelector = FLEE_MENU
		menuSwitchFunction(menuSelector)
		topActions.hide() 
	elif (menuSelector == STARTING_FIGMENT):
		menuSelector = BASE_MENU #sets the menu to the battle menu after figments have been selected
		menuSwitchFunction(menuSelector)
	elif (menuSelector == FLEE_MENU): #This brings back up the base menu. if they are not elif's code does not work properly
		menuSelector = BASE_MENU
		bottomMiddleButton.hide() 
		topActions.show()
		menuSwitchFunction(menuSelector)
		
func _on_bottom_middle_action_pressed() -> void:
	menuSelector = BASE_MENU
	bottomMiddleButton.hide() 
	menuSwitchFunction(menuSelector) 
