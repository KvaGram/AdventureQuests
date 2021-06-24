extends CanvasLayer

export(String, FILE, "*.json") var dialogueFile

var dialogues =  []
var currentLine = 0;


func _ready():
	play();

func playline(line):
	currentLine = line
	$"Dialouge box/Character name".text = dialogues[line]["name"]
	$"Dialouge box/Dialouge".text = dialogues[line]["text"]
	#ideas:
	# * a 'goto' flags that when we hit the next button again,
	# we go to the specified line instead of the next one
	# * audio tag, plays voice acting, optional
	# * A 'choice' flags we are not allowed to go to the next line
	#  ** Instead a number of choice buttons with a set of choices must be clicked.
	#  ** Each choice must have a short 'reply' and a 'goto'.
	#  ** Each choice may have a 'condition'. if condition fails, choice will be diabled.

func play():
	dialogues = load_dialogue()
	playline(0)

func load_dialogue():
	var d_file = File.new()
	if d_file.file_exists(dialogueFile):
		d_file.open(dialogueFile, File.READ)
		return parse_json(d_file.get_as_text())
func nextLine():
	if(nextLineLegal()):
		playline(currentLine+1)

func nextLineLegal():
	if(dialogues.size() <= currentLine+1):
		return false
	return true
