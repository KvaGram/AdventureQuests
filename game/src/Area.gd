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


#The AreaList data. there is only one of this, and holds the list of every
#area. The list is an array of AreaData.
#The fallback is an AreaData presenting an "unknown area".
export var areas : Array
export var fallbackArea : Resource

func getArea(code:String):
	code = code.to_upper() 
	for a in areas:
		if(!a is AreaData):
			printerr("non-AreaData object "+str(a) +" found in areas list.")
			continue
		if a.code.to_upper() == code:
			return a
	return fallbackArea


func loadArea(a):
	if(a == null):
		return;
	var area:AreaData
	if(a is String):
		area = getArea(a)
	elif (a is AreaData):
		area = a
	else:
		printerr("Attempted to load non-AreaData")
	$TextureRect.texture = area.default_backround
	
	var d:DialogueData = area.getDialogue()
	$"Dialouge area".load_dialogue(d)




