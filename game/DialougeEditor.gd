extends TabContainer
class_name DialogueEditor

var dialogue := DialogueData.new()
var line_index := 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
func _ready():
	refresh()

func refresh():
	#special case. if lines is empty, add one, then force the index to 0.
	if(dialogue.lines.size() <= 0):
		line_index = 0
		dialogue.lines.append(DialogueData.Line.new())
	$"Editor/VBoxContainer/Dialogue editor panel/Controller/lineIndex".text = str(line_index)
	if line_index >= dialogue.lines.size():
		return
	var line:DialogueData.Line = dialogue.lines[line_index]
	$"Editor/VBoxContainer/Dialogue editor panel/VBoxContainer/Character_name".text = line.name
	$"Editor/VBoxContainer/Dialogue editor panel/VBoxContainer/Dialogue_box".text = line.text
	$"Editor/VBoxContainer/Dialogue editor panel/Aux data/HBoxContainer/audio_start_at".value = line.audio_start
	$"Editor/VBoxContainer/Dialogue editor panel/Aux data/HBoxContainer/audio_end_at".value = line.audio_end
	
	#If at index 0, or somehow below, prev button is disabled
	$"Editor/VBoxContainer/Dialogue editor panel/Controller/prev".disabled = line_index <= 0
	#If at last line, or somehow beyond, and body text is empty, next button is disabled.
	$"Editor/VBoxContainer/Dialogue editor panel/Controller/next".disabled = line_index+1 >= dialogue.lines.size() && line.text.empty()
	
	#Todo: populate actions and choices
func open_dialogue(data):
	if(data is DialogueData):
		line_index = 0
		dialogue = data
		refresh()
		return
	print("Attempted to load non-dialogue data. Ignored")
	
	

#class line:
#	var name := ""
#	var text := ""
#	var actions := []
#	var tag := ""
#	var audio_start := 0.0
#	var audio_end := 0.0

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_prev_line():
	#if at fist line, or somehow below, refuse to decrease line index
	if(line_index <= 0):
		return
	line_index -= 1
	refresh()

#Increase line_index. If at the last line, this will add a new line.
func _on_next_line():
	#if somehow already beyond last line, refuse to increase line index
	if(line_index >= dialogue.lines.size()):
		return;
	line_index += 1
	#If line index is now boyond the last line, add a new line
	if(line_index >= dialogue.lines.size()):
		dialogue.lines.append(DialogueData.Line.new())
	refresh()

func _on_Character_name_text_changed(new_name):
	dialogue.lines[line_index].name = new_name


func _on_Dialouge_text_changed():
	var text = $"Editor/VBoxContainer/Dialogue editor panel/VBoxContainer/Dialogue_box".text
	dialogue.lines[line_index].text = text
	$"Editor/VBoxContainer/Dialogue editor panel/Controller/next".disabled = line_index+1 >= dialogue.lines.size() && text.empty()

func _on_audio_start_at_value_changed(value):
	dialogue.lines[line_index].audio_start = value


func _on_audio_end_at_value_changed(value):
	dialogue.lines[line_index].audio_end = value
