extends WindowDialog


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func populate():
	pass
	#get_node("VBoxContainer/HBoxContainer/LineEdit").text = Global.playername

func onShow():
	popup_centered_minsize(Vector2(100, 100))

#func updatePlayername(newname):
#	Global.playername = newname
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
