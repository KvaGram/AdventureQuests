extends Control

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Save_External_pressed():
	var data:DialogueData = $"../..".dialogue
	$Save_Dialogue.filename = data.name
	$Load_Dialogue.access = FileDialog.ACCESS_FILESYSTEM;
	$Save_Dialogue.popup_centered_minsize(Vector2(500, 500))

#TODO: add warning
# load a dialogue object from file
func _on_Load_External_pressed():
	$Load_Dialogue.access = FileDialog.ACCESS_FILESYSTEM;
	$Load_Dialogue.popup_centered_minsize(Vector2(500, 500))

func _on_Save_Internal_pressed():
	var data:DialogueData = $"../..".dialogue
	$Save_Dialogue.filename = data.name
	$Load_Dialogue.access = FileDialog.ACCESS_RESOURCES;
	$Save_Dialogue.popup_centered_minsize(Vector2(500, 500))

#TODO: add warning
# load a dialogue object from file
func _on_Load_Internal_pressed():
	$Load_Dialogue.access = FileDialog.ACCESS_RESOURCES;
	$Load_Dialogue.popup_centered_minsize(Vector2(500, 500))

#TODO: add warning.
#replace dialogue object with a new one
func _on_New_Dialogue_pressed():
	$"../..".open_dialogue(DialogueData.new())


func _on_Save_Dialogue_file_selected(path:String):
	var data:DialogueData = $"../..".dialogue
	if !path.ends_with(".book.tres"):
		path = path + ".book.tres"
	var result = ResourceSaver.save(path, data)#, ResourceSaver.FLAG_BUNDLE_RESOURCES) #bundle? yes or no?
	if(result != 0):
		print("Error saving file. Error-code: " + result)
	
func _on_Load_Dialogue_file_selected(path):
	var data = ResourceLoader.load(path)
	$"../..".open_dialogue(data)

