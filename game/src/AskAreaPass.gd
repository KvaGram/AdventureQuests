extends PopupPanel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var passline;

# Called when the node enters the scene tree for the first time.
func _ready():
	passline = get_node("VBoxContainer/LineEdit")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


#make sure the passline is always clear
func _on_AskAreaPass_about_to_show():
	passline.text = "";
func _on_AskAreaPass_popup_hide():
	passline.text = "";
func onShow():
	popup();


func onPassEntered(locpass):
	visible = false;
