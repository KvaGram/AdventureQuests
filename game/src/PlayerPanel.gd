extends WindowDialog


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func populate():
	get_node("VBoxContainer/HBoxContainer/LineEdit").text = Global.playername
	pass

func updatePlayername(newname):
	Global.playername = newname


func onShow():
	popup_centered_minsize(Vector2(100, 100))
