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
	var data:DialogueData = $"../Dialouge Inner editor".dialogue
	$Save_Dialogue.filename = data.name
	$Save_Dialogue.popup_centered_minsize(Vector2(300, 300))
	pass # Replace with function body.

#TODO: add warning
# load a dialogue object from file
func _on_Load_External_pressed():
	$Load_Dialogue.popup_centered_minsize(Vector2(300, 300))
	pass # Replace with function body.


#TODO: add warning.
#replace dialogue object with a new one
func _on_New_Dialogue_pressed():
	$"../Dialouge Inner editor".open_dialogue(DialogueData.new())


func _on_Save_Dialogue_file_selected(path):
	var data:DialogueData = $"../Dialouge Inner editor".dialogue
	var result = ResourceSaver.save(path+".book.tres", data)#, ResourceSaver.FLAG_BUNDLE_RESOURCES) #bundle? yes or no?
	if(result != 0):
		print("Error saving file. Error-code: " + result)
	
