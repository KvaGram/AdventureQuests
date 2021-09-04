extends PopupPanel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var passline:LineEdit;

# Called when the node enters the scene tree for the first time.
func _ready():
	passline = get_node("VBoxContainer/LineEdit")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


#make sure the passline is always clear
func _on_AskAreaPass_about_to_show():
	passline.text = "";
	passline.editable = true
func _on_AskAreaPass_popup_hide():
	passline.text = "";
	passline.editable = false
func onShow():
	popup();
