extends Control
var editorPath = "null" # = "res://src/editor/DialougeEditor.tscn"
var area_list:AreaList
#var dialogic:Dialogic

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	area_list = ResourceLoader.load("res://src/resources/areas/AreaList.tres")
	if ResourceLoader.exists(editorPath):
		$"Buttonmenu/button bar/HBoxContainer/open editor".disabled = false
	else:
		$"Buttonmenu/button bar/HBoxContainer/open editor".disabled = true
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


func onPassEntered(passkey):
	var data : AreaData = area_list.getArea(passkey)
	
	$"Buttonmenu/AskAreaPass".hide()
	var dialog:CanvasLayer = Dialogic.start(data.timeline_name)
	add_child(dialog)
	$dummy.grab_focus()
