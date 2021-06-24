extends CanvasLayer

export(String, FILE, "*.json") var dialogueFile

var dialogues =  []
var audiotracks = []
var currentLine = 0;
var hasAudio = false;


func _ready():
	play();
func _process(_delta):
	if hasAudio && $DialogueAudio.get_playback_position() > audiotracks[currentLine]["end Time"]:
		$DialogueAudio.stop()
		#Idea: auto next line?

func playline(line):
	currentLine = line
	$"Dialouge box/Character name".text = dialogues[line]["name"]
	$"Dialouge box/Dialouge".text = dialogues[line]["text"]
	if hasAudio && line < audiotracks.size():
		$DialogueAudio.play(audiotracks[line]["start Time"])

	
	
	#ideas:
	# * a 'goto' flags that when we hit the next button again,
	# we go to the specified line instead of the next one
	# * audio tag, plays voice acting, optional
	# * A 'choice' flags we are not allowed to go to the next line
	#  ** Instead a number of choice buttons with a set of choices must be clicked.
	#  ** Each choice must have a short 'reply' and a 'goto'.
	#  ** Each choice may have a 'condition'. if condition fails, choice will be diabled.

func play():
	load_dialogue()
	playline(0)

func load_dialogue():
	var d_file = File.new()
	if !d_file.file_exists(dialogueFile):
		return;
	d_file.open(dialogueFile, File.READ)
	var data = parse_json(d_file.get_as_text())
	dialogues = data["dialogue"]
	if data.has("audio") && data.has("tracks") && File.new().file_exists(data["audio"]):
		audiotracks = data["tracks"]
		var newAudio = load(data["audio"])
		$DialogueAudio.stream = newAudio
		hasAudio = true;
	else:
		hasAudio = false;
	
	
	
func nextLine():
	if(nextLineLegal()):
		playline(currentLine+1)

func nextLineLegal():
	if(dialogues.size() <= currentLine+1):
		return false
	return true
