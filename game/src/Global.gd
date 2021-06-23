extends Node

var playername = "";

const SAVEFILE_NAME = "tenebrae_quests";


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

# region playerdata packing

#pack the playerdata into a serialized state
func packPlayerdata():
	return {
		"playername" : playername,
		"placeholder": "place that holds"
	}
#unpack the playerdata from a serialized state
func unpackPlayerData(data):
	playername = data["playername"]

# endregion

func saveData():
	var savefile = File.new()
	savefile.open("user://"+SAVEFILE_NAME+".save", File.WRITE)
	savefile.store_line( to_json(packPlayerdata()))
	savefile.close()

func loadData():
	var savefile = File.new()
	if savefile.file_exists("user://savegame.save"):
		print("no savefile found. Skipping")
		return
	savefile.open("user://"+SAVEFILE_NAME+".save", File.READ)
	while savefile.get_position() < savefile.get_len():
		var data = parse_json(savefile.get_line())
		
		#If data has playername key, it is the player data packet.
		if data.has("playername"):
			unpackPlayerData(data)
			continue
	savefile.close();


