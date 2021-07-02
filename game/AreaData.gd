extends Resource
class_name AreaData

export var name : String = "Undefined place"
export var code : String = "NONE"
export var description : String = "Undefined place"
export var default_backround : ImageTexture = null
export var books : Array = []
	
func _ready():
	pass
	
func getDialogue():
	if(books.size() <= 0):
		return null
	#stub!
	#todo add checks for variables, set up a manu with lists to load etc.
	return books[0];
