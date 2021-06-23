extends Control

var textline;
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	textline = get_node("testsave/textline")

func save():
	Global.playername = textline.text #test
	Global.saveData()
func load():
	Global.loadData()
	textline.text = Global.playername #test

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
