extends Node

# IF YOU CHANGE THE SAVEDATA DICTIONARY, YOU MIGHT HAVE TO DELETE THE PREVIOUS SAVE FILE AND THEN YOU CAN SAVE IT
# THE SAVE FILE CAN BE ACCESSED BY CLICKING PROJECT ON THE TOP LEFT AND SELECTING OPEN USER DATA FOLDER
const SAVE_LOCATION = "user://SaveFile.json"

var SaveData : Dictionary = {
	"saveFileVer" : 1,
	"Figment_1": [
		{
			"exists" : true,
			"level": 0.0,
			"xp": 0.0,
			"maxhp": 0.0,
			"hp": 0.0,
			"knownMoves": false, # TODO
			"stats": [
				{
					"Will": 0.0,
					"Coherence": 0.0,
					"Lucidity": 0.0,
					"Acuity": 0.0,
					"Creativity": 0.0,
				}
			]
		}
	]
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body
	
func _save() -> void:
	
	#makes code readable in the json save file, its otherwise partially illegible,
	#false prevents autosort, it'll make the save file A Pain otherwise
	var readableSaveData = JSON.stringify(SaveData, "\t" , false )
	
	var fileVar: FileAccess = FileAccess.open(SAVE_LOCATION, FileAccess.WRITE)
	fileVar.store_string(readableSaveData)
	fileVar.close()
	print("Save File Saved")

func _load() ->void:
	pass
