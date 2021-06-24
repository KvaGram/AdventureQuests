extends Control

var textline;
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
#	textline = get_node("testsave/textline")
	pass
	
func save():
	Global.saveData()
func load():
	Global.loadData()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
