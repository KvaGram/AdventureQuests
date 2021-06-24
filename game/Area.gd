extends Control

### The Area view is the core of the questing experience.
# it is here the dialouge happens. It is here the choices are done.
# it is here the action is.
# But to do anything, you need to "walk there" first.
# You do this by finding the passkey in the game-word, and typing it in.
# Once a passcode is entered, the area will change
# If the pass is rejected, you will end up in an "unknown area".
# If the pass is accepted, it will check all active and unlockable quests
# For an activity in this area.
# If only 1, it will run right away. If more than one,
# you will be promted to select one.
# If none, you will be granted with a fallback.

const META_LOCATION = "res://src/areas/areas.json.tres"
var areaMeta

func loadArea(areaPass):
	
	pass
	
	
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#var file = File.new()
	#file.open(META_LOCATION, File.READ)
	#areaMeta = parse_json(file.get_as_text())
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

