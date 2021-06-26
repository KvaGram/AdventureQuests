extends Resource

#dialouge lines
var lines := []
#conditions for showing this dialogue
var conditions := []
#Name to display, if ever needed to select from a list
var name = ""

class line:
	var name := ""
	var text := ""
	var actions := []
	var tag := ""
	
#used for both adding items, and checking if player have items
class ItemAction:
	var add := true
	var id := ""
#used both for setting variables, and conditions
class VarAction:
	var action:int = varDoAction.SET #also varDoCondition.EQUAL
	var id := ""
	var value
	func validate():
		#if the action is anything other than SET or EQUAL
		#Then the value must be either an int or a float.
		#Otherswise, put a frog in there, for all I care.
		if(action != varDoAction.SET):
			return (value is int || value is float)
		return true	

enum varDoAction {SET, ADD, SUBTRACT}
enum varDoCondition {EQUAL, GREATER_THAN, LESSER_THAN}
