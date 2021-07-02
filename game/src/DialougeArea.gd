extends CanvasLayer

var data:DialogueData
var currentLine: = 0;
var hasAudio: = false;
var isMute: = false;
var audioStop: = 0.0

func load_dialogue(d:DialogueData):
	data = d
	if(data == null):
		pass #TODO what to do when dialouge is null?
		return
	if(data.audio != null):
		hasAudio = true
		$DialogueAudio.stream = data.audio
	else:
		hasAudio = false
	playline(0)
	$muteButton.visible = hasAudio

func playline(line:int):
	if(line >= data.lines.size()):
		return
	currentLine = line
	$"Dialouge box/Character name".text = data.lines[line]["name"]
	$"Dialouge box/Dialouge".text = data.lines[line]["text"]
	if !isMute && hasAudio:
		$DialogueAudio.play(data.lines[line]["audio_start"])
	audioStop = (data.lines[line]["audio_end"])
	
		
		
func _process(_delta):
	if hasAudio && $DialogueAudio.get_playback_position() > audioStop:
		$DialogueAudio.stop()

func nextLine():
	if(nextLineLegal()):
		playline(currentLine+1)

func nextLineLegal():
	if(data.lines.size() <= currentLine+1):
		return false
	return true

#when muting or unmuting stop any audio, then restart current line.
func set_mute(muteval):
	isMute = muteval
	$DialogueAudio.stop()
	playline(currentLine)

func _ready():
	if OS.is_class("HTML5"):
		set_mute(true);
		$muteButton.pressed = true;
