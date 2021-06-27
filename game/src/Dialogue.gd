extends Resource
class_name DialogueData

#dialogue lines
export var lines = []
#conditions for showing this dialogue
export var conditions = []
#Name to display, if ever needed to select from a list
export var name = ""

export var audio:AudioStream

func addLine():
	var newline = {}
	newline["name"] = ""
	newline["text"] = ""
	newline["tag"] = ""
	newline["audio_start"] = 0.0
	newline["audio_end"] = 0.0
	newline["actions"] = []
	newline["choices"] = []
	
	lines.append(newline)
#The item action allow for the addinf or removal of an item
func addItemAction(lineIndex):
	if(lineIndex >= lines.size()):
		return
	var newaction = {}
	newaction["type"] = "item"
	newaction["add"] = true
	newaction["id"] = ""
	lines[lineIndex]["actions"].append(newaction);
#The variable action allow for setting and manipulating variables
func addVarAction(lineIndex):
	if(lineIndex >= lines.size()):
		return
	var newaction = {}
	newaction["type"] = "var"
	newaction["action"] = varDoAction.SET
	newaction["value"] = 0
	lines[lineIndex]["actions"].append(newaction);
#the tag variable allow for going to a different line next
func addTagAction(lineIndex):
	if(lineIndex >= lines.size()):
		return
	var newaction = {}
	newaction["type"] = "tag"
	newaction["tag"] = "varDoAction.SET"
	lines[lineIndex]["actions"].append(newaction);

#func addchoice(lineIndex):
#	if(lineIndex >= lines.size()):
#		return
#	var newChoice
	

#class Line:
#	var name := ""
#	var text := ""
#	var actions := []
#	var tag := ""
#	var audio_start := 0.0
#	var audio_end := 0.0
##used for both adding items, and checking if player have items
#class ItemAction:
#	var add := true
#	var id := ""
##used both for setting variables, and conditions
#class VarAction:
#	var action:int = varDoAction.SET #also varDoCondition.EQUAL
#	var id := ""
#	var value
#	func validate():
#		#if the action is anything other than SET or EQUAL
#		#Then the value must be either an int or a float.
#		#Otherswise, put a frog in there, for all I care.
#		if(action != varDoAction.SET):
#			return (value is int || value is float)
#		return true	

enum varDoAction {SET, ADD, SUBTRACT}
enum varDoCondition {EQUAL, GREATER_THAN, LESSER_THAN}
