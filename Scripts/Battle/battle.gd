extends Control
class_name BattleScene

#TODO after buttons are set up to put forward player figments, add check to make sure 
# figment slot isn't empty when trying to put forward a figment
# 		add 2 figment nodes (enemy and player figments) so that all the stats moves,etc
# can be easily refered to, also allows easy implementation for capturing, as
# you can just copy the figmint info
#	^ OR maybe just add a variable to hold the data from the enemy fig, so I can be saved to 
#	when player captures it
#		check either that ui and battle player inv are the same inv or not (duplicates)
# or just set up signal to make UI refresh if that is actually the problem

var PlayerInv = load("res://Resources/zzzTestInv/newTestInv.tres")

# user interactable buttons and child nodes
@onready var topLeftButton: Button = $ActionPanel/Actions/TopActions/TopLeftAction
@onready var button1Fig: MarginContainer = $ActionPanel/Actions/TopActions/TopLeftAction/Button1Fig
@onready var button1FigImage: TextureRect = $ActionPanel/Actions/TopActions/TopLeftAction/Button1Fig/HBoxContainer/Button1FigImage
@onready var button1FigHealth: ProgressBar = $ActionPanel/Actions/TopActions/TopLeftAction/Button1Fig/HBoxContainer/Button1FigHealth

@onready var topRightButton: Button = $ActionPanel/Actions/TopActions/TopRightAction
@onready var button2Fig: MarginContainer = $ActionPanel/Actions/TopActions/TopRightAction/Button2Fig
@onready var button2FigImage: TextureRect = $ActionPanel/Actions/TopActions/TopRightAction/Button2Fig/HBoxContainer/Button2FigImage
@onready var button2FigHealth: ProgressBar =$ActionPanel/Actions/TopActions/TopRightAction/Button2Fig/HBoxContainer/Button2FigHealth

@onready var bottomLeftButton: Button = $ActionPanel/Actions/BottomActions/BottomLeftAction
@onready var button3Fig: MarginContainer = $ActionPanel/Actions/BottomActions/BottomLeftAction/Button3Fig
@onready var button3FigImage: TextureRect = $ActionPanel/Actions/BottomActions/BottomLeftAction/Button3Fig/HBoxContainer/Button3FigImage
@onready var button3FigHealth: ProgressBar =$ActionPanel/Actions/BottomActions/BottomLeftAction/Button3Fig/HBoxContainer/Button3FigHealth

@onready var bottomRightButton: Button = $ActionPanel/Actions/BottomActions/BottomRightAction
@onready var button4Fig: MarginContainer = $ActionPanel/Actions/BottomActions/BottomRightAction/Button4Fig
@onready var button4FigImage: TextureRect = $ActionPanel/Actions/BottomActions/BottomRightAction/Button4Fig/HBoxContainer/Button4FigImage
@onready var button4FigHealth: ProgressBar =$ActionPanel/Actions/BottomActions/BottomRightAction/Button4Fig/HBoxContainer/Button4FigHealth

@onready var bottomMiddleButton: Button = $ActionPanel/Actions/BottomActions/BottomMiddleAction


@onready var textBox: Label = $TextBox
@onready var actionPanel: Panel = $ActionPanel
@onready var topActions: HBoxContainer = $ActionPanel/Actions/TopActions
@onready var bottomActions: HBoxContainer = $ActionPanel/Actions/BottomActions

# enemy Figment variables
@onready var enemyFigData: Figment
@onready var enemyLevel: Label = $EnemyInfoBox/EnemyInfoBar/EnemyLevel
@onready var enemyFigment: TextureRect = $EnemyFigment
@onready var enemyName: Label = $EnemyInfoBox/EnemyInfoBar/EnemyName
@onready var enemyHealth: ProgressBar = $EnemyInfoBox/EnemyHealth
@onready var enemyFigmentType1: Label = $EnemyInfoBox/EnemyFigmentTypesBox/EnemyFigmentType1
@onready var enemyFigmentType2: Label = $EnemyInfoBox/EnemyFigmentTypesBox/EnemyFigmentType2
# player Figment variables
@onready var playerName: Label = $PlayerInfoBox/PlayerInfoBar/PlayerName
@onready var playerLevel: Label = $PlayerInfoBox/PlayerInfoBar/PlayerLevel
@onready var playerHealth: ProgressBar = $PlayerInfoBox/PlayerHealth
@onready var playerFigmentType1: Label = $PlayerInfoBox/PlayerFigmentTypesBox/PlayerFigmentType1
@onready var playerFigmentType2: Label = $PlayerInfoBox/PlayerFigmentTypesBox/PlayerFigmentType2
@onready var playerFigment: TextureRect = $PlayerFigment



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
	print(PlayerInv.figmentPartySlots[0].figmentInfo.speciesName)
	PlayerInv.figmentPartySlots[0].figmentInfo.speciesName = "dickyWicky"
	PlayerInv.figmentPartySlots[0].figmentInfo.hp = 0
	changeActionPanel("Figment 1","Figment 2","Figment 3","Figment 4","Back")
	displayTextBox("You have encountered a real bad fella!")
	bottomMiddleButton.hide()
	print(topLeftButton.get_child(0).name)
	updateButtonFigInfo()
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
	
func updateButtonFigInfo():
	if (PlayerInv.figmentPartySlots[0].figmentInfo != null):
		if (button1Fig.visible == true):
			button1Fig.show()
		button1FigImage.texture = PlayerInv.figmentPartySlots[0].figmentInfo.sprite
		button1FigHealth.value = PlayerInv.figmentPartySlots[0].figmentInfo.hp
	else:
		button1Fig.hide()
		
	if (PlayerInv.figmentPartySlots[1].figmentInfo != null):
		if (button2Fig.visible == true):
			button2Fig.show()
		button2FigImage.texture = PlayerInv.figmentPartySlots[1].figmentInfo.sprite
		button2FigHealth.value = PlayerInv.figmentPartySlots[1].figmentInfo.hp
	else:
		button2Fig.hide()
		
	if (PlayerInv.figmentPartySlots[2].figmentInfo != null):
		if (button3Fig.visible == true):
			button3Fig.show()
		button3FigImage.texture = PlayerInv.figmentPartySlots[2].figmentInfo.sprite
		button3FigHealth.value = PlayerInv.figmentPartySlots[2].figmentInfo.hp
	else:
		button3Fig.hide()
		
	if (PlayerInv.figmentPartySlots[3].figmentInfo != null):
		if (button4Fig.visible == true):
			button4Fig.show()
		button4FigImage.texture = PlayerInv.figmentPartySlots[3].figmentInfo.sprite
		button4FigHealth.value = PlayerInv.figmentPartySlots[3].figmentInfo.hp
	else:
		button4Fig.hide()
	

func applyEnemyFigmentInfo(incomingFig: Figment):
	enemyFigData = incomingFig
	enemyFigment.texture = incomingFig.sprite
	enemyName.text = incomingFig.speciesName
	enemyHealth.max_value = incomingFig.maxhp
	enemyHealth.value = incomingFig.hp
	enemyLevel.text = "Lv: " + str(incomingFig.level)
	enemyFigmentType1.text = incomingFig.Type.find_key(incomingFig.type1)
	enemyFigmentType2.text = incomingFig.Type.find_key(incomingFig.type2)
	
	# if it doesn't have a second type hide the box
	if (enemyFigmentType2.visible == true):
		if(incomingFig.type2 == incomingFig.Type.NONE):
			enemyFigmentType2.hide()
	# incase it was hidden previously but it does have a second type
	elif (enemyFigmentType2.visible != true):
		if(incomingFig.type2 != incomingFig.Type.NONE):
			enemyFigmentType2.show()
			
	# kept the print statements because it can be really confusing otherwise
	#print("type 1 enum value is: ",incomingFig.type1)# prints 1-3
	#print("type 1 type is: ",incomingFig.Type.find_key(incomingFig.type1)) #prints Land,Sea,Sky
	#print("type NONE value is: ",incomingFig.Type.NONE) # prints 0
	#print("All enum values and connected colors are: ",incomingFig.typeColours) #prints all enum values and corresponding colors
	#print("All enum values in typeColours are: ",incomingFig.typeColours.keys()) #prints 0-9
	#print("The actual color values for the tested type are: ",incomingFig.typeColours.get(incomingFig.type1)) # gets the color values for each type
	#if (incomingFig.type1 == incomingFig.Type.SKY):
	#	print("test matching works")
	#print("The current color of type1 style box is: ",enemyFigmentType1.get_theme_stylebox("normal").bg_color)# prints current color correctly
	#enemyFigmentType1.get_theme_stylebox("normal").bg_color = Color(0.694, 0.0, 0.0, 1.0) #YESSSSSSSS IT WORKS
	#enemyFigmentType1.get_theme_stylebox("normal").bg_color = incomingFig.typeColours.get(incomingFig.type1) # this dynamically changes the color, moved to its own function
	changeTypeColor(incomingFig.typeColours.get(incomingFig.type1), enemyFigmentType1)
	changeTypeColor(incomingFig.typeColours.get(incomingFig.type2), enemyFigmentType2)

func applyPlayerFigmentInfo(incomingFig: Figment):
	playerFigment.texture = incomingFig.sprite
	playerName.text = incomingFig.speciesName
	playerHealth.max_value = incomingFig.maxhp
	playerHealth.value = incomingFig.hp
	playerLevel.text = "Lv: " + str(incomingFig.level)
	playerFigmentType1.text = incomingFig.Type.find_key(incomingFig.type1)
	playerFigmentType2.text = incomingFig.Type.find_key(incomingFig.type2)
	
	# if it doesn't have a second type hide the box
	if (playerFigmentType2.visible == true):
		if(incomingFig.type2 == incomingFig.Type.NONE):
			playerFigmentType2.hide()
	# incase it was hidden previously but it does have a second type
	elif (playerFigmentType2.visible != true):
		if(incomingFig.type2 != incomingFig.Type.NONE):
			playerFigmentType2.show()
	
	changeTypeColor(incomingFig.typeColours.get(incomingFig.type1), playerFigmentType1)
	changeTypeColor(incomingFig.typeColours.get(incomingFig.type2), playerFigmentType2)


func changeTypeColor(newColor: Color,label : Label):
	label.get_theme_stylebox("normal").bg_color = newColor

func _on_top_left_move_pressed() -> void:
	displayTextBox(topLeftButton.text + " selected")  ## fill in with moves pulled from figment object
	if (menuSelector == BASE_MENU):
		menuSelector = FIGHT_MENU #sets the active menu to the menu where you can choose a figments attacks
		menuSwitchFunction(menuSelector)
		bottomMiddleButton.show()
	elif (menuSelector == STARTING_FIGMENT):
		if(PlayerInv.figmentPartySlots[0].figmentInfo == null):
			displayTextBox("you don't have a figment there")
		elif(PlayerInv.figmentPartySlots[0].figmentInfo.hp == 0):
			displayTextBox("that Figment is fucking dead dude")
		else:
			applyPlayerFigmentInfo(PlayerInv.figmentPartySlots[0].figmentInfo)
			menuSelector = BASE_MENU #sets the active menu to the battle menu after figments have been selected
			menuSwitchFunction(menuSelector)

func _on_top_right_move_pressed() -> void:
	displayTextBox(topRightButton.text + " selected")  ## fill in with moves pulled from figment object
	if (menuSelector == BASE_MENU):
		menuSelector = SWITCH_MENU # sets the active menu where you can switch between your figments 
		menuSwitchFunction(menuSelector)
		bottomMiddleButton.show()
	elif (menuSelector == STARTING_FIGMENT):
		if(PlayerInv.figmentPartySlots[1].figmentInfo == null):
			displayTextBox("you don't have a figment there")
		elif(PlayerInv.figmentPartySlots[1].figmentInfo.hp == 0):
			displayTextBox("that Figment is fucking dead dude")
		else:
			applyPlayerFigmentInfo(PlayerInv.figmentPartySlots[1].figmentInfo)
			menuSelector = BASE_MENU #sets the active menu to the battle menu after figments have been selected
			menuSwitchFunction(menuSelector)
		
func _on_bottom_left_move_pressed() -> void:
	displayTextBox(bottomLeftButton.text + " selected")  ## fill in with moves pulled from figment object
	if (menuSelector == BASE_MENU):
		menuSelector = INVENTORY_MENU # sets the active menu to the inventory menu
		menuSwitchFunction(menuSelector)
		bottomMiddleButton.show()
	elif (menuSelector == STARTING_FIGMENT):
		if(PlayerInv.figmentPartySlots[2].figmentInfo == null):
			displayTextBox("you don't have a figment there")
		elif(PlayerInv.figmentPartySlots[2].figmentInfo.hp == 0):
			displayTextBox("that Figment is fucking dead dude")
		else:
			applyPlayerFigmentInfo(PlayerInv.figmentPartySlots[2].figmentInfo)
			menuSelector = BASE_MENU #sets the active menu to the battle menu after figments have been selected
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
		if(PlayerInv.figmentPartySlots[3].figmentInfo ==  null):
			displayTextBox("you don't have a figment there")
		elif(PlayerInv.figmentPartySlots[3].figmentInfo.hp == 0):
			displayTextBox("that Figment is fucking dead dude")
		else:
			applyPlayerFigmentInfo(PlayerInv.figmentPartySlots[3].figmentInfo)
			menuSelector = BASE_MENU #sets the active menu to the battle menu after figments have been selected
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


func _on_capture_button_pressed() -> void:
	# TODO read that for the path you wanna save to user:// player data not res:// since it
	#	would be specific to the player rather then the project itself, using res rn for testing purposes
	#TODO figure out how to actually save the fig data between booting up the gaem
	PlayerInv.figmentPartySlots[3].figmentInfo = enemyFigData
	#ResourceSaver.save(enemyFigData,PlayerInv.figmentPartySlots[3].figmentInfo	) 
