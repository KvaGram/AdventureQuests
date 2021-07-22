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
		dialogue.addLine()
	$"Editor/VBoxContainer/Dialogue editor panel/Controller/lineIndex".text = str(line_index)
	if line_index >= dialogue.lines.size():
		return
	var line = dialogue.lines[line_index]
	$"Editor/VBoxContainer/Dialogue editor panel/VBoxContainer/Character_name".text = line["name"]
	$"Editor/VBoxContainer/Dialogue editor panel/VBoxContainer/Dialogue_box".text = line["text"]
	$"Editor/VBoxContainer/Dialogue editor panel/Aux data/HBoxContainer/audio_start_at".value = line["audio_start"]
	$"Editor/VBoxContainer/Dialogue editor panel/Aux data/HBoxContainer/audio_end_at".value = line["audio_end"]
	$"Editor/VBoxContainer/Dialogue editor panel/Aux data/Tag/TagName".text = line["tag"]
	
	#If at index 0, or somehow below, prev button is disabled
	$"Editor/VBoxContainer/Dialogue editor panel/Controller/prev".disabled = line_index <= 0
	#If at last line, or somehow beyond, and body text is empty, next button is disabled.
	$"Editor/VBoxContainer/Dialogue editor panel/Controller/next".disabled = line_index+1 >= dialogue.lines.size() && line["text"].empty()
	
func _on_Load_Audacity_labels_pressed():
	var input:TextEdit = $Settings/VBoxContainer/wildText
	var numLines = input.get_line_count()
	for i in numLines:
		var t = input.get_line(i)
		var vals = KvaTools.nestedSplit(t, [" ","\t"])
		if (vals.size() <= 2):
			continue
		#var vals = str(t.split(" ", false))
		dialogue.lines[i]["audio_start"] = float(vals[0])
		dialogue.lines[i]["audio_end"] = float(vals[1]) 
	
	
	
	#var input:String = $Settings/VBoxContainer/wildText.text
	#var labels = input.split("/n", false)
	#var numLines = labels.size()
	#for i in numLines:
	#	if(i >= dialogue.lines.size()):
	#		break
	#	

	


	
	#Todo: populate actions and choices
func open_dialogue(data):
	if(data is DialogueData):
		line_index = 0
		dialogue = data
		$TestaudioPlayer.stream = data.audio;
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
		dialogue.addLine()
	refresh()

func _on_Character_name_text_changed(new_name):
	dialogue.lines[line_index]["name"] = new_name


func _on_Dialouge_text_changed():
	var text = $"Editor/VBoxContainer/Dialogue editor panel/VBoxContainer/Dialogue_box".text
	dialogue.lines[line_index]["text"] = text
	$"Editor/VBoxContainer/Dialogue editor panel/Controller/next".disabled = line_index+1 >= dialogue.lines.size() && text.empty()

func _on_audio_start_at_value_changed(value):
	dialogue.lines[line_index]["audio_start"] = value


func _on_audio_end_at_value_changed(value):
	dialogue.lines[line_index]["audio_end"] = value


func _on_TagName_text_changed(new_text):
	dialogue.lines[line_index]["tag"] = new_text


func _on_LoadAudio_file_selected(path):
	var audio = ResourceLoader.load(path, "AudioStream");
	if(audio):
		$"Settings/VBoxContainer/HBoxContainer2/AudioPath".text = path
		dialogue.audio = audio;
		$TestaudioPlayer.stream = audio;


func _on_LoadAudiofile_pressed():
	$"Settings/LoadAudio".popup_centered_minsize(Vector2(500, 500))
	pass # Replace with function body.

var playto = 0.0;
func _on_TestAudioFull_pressed():
	if (dialogue.audio):
		playto = $TestaudioPlayer.stream.get_length()
		$TestaudioPlayer.play()
func _on_AudioStop_pressed():
	$TestaudioPlayer.stop()


func _on_TestAudioLine_pressed():
	if (dialogue.audio):
		var start = dialogue.lines[line_index]["audio_start"]
		playto = dialogue.lines[line_index]["audio_end"]
		$TestaudioPlayer.play(start)
func _process(_delta):
	if($TestaudioPlayer.is_playing() && $TestaudioPlayer.get_playback_position() > playto):
		$TestaudioPlayer.stop()



