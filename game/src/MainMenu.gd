extends Control
var editorPath = "res://src/editor/DialougeEditor.tscn"
var textline;
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
#	textline = get_node("testsave/textline")
	if ResourceLoader.exists(editorPath):
		$"VBoxContainer/button bar/HBoxContainer/open editor".disabled = false
	else:
		$"VBoxContainer/button bar/HBoxContainer/open editor".disabled = true
	$"dev_build_alert".popup_centered()
	
func save():
	Global.saveData()
func load():
	Global.loadData()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_open_editor_pressed():
	if ResourceLoader.exists(editorPath):
		get_tree().change_scene(editorPath)
