extends TextEdit


func _ready():
	get_tree().connect("files_dropped", self, "on_file_dropped")

func on_file_dropped(files:PoolStringArray, _screen:int):
	#Only load the first file in the list. Ignore others.
	var path = files[0]
	var file = File.new()
	file.open(path, File.READ)
	self.text = file.get_as_text()
	file.close()


func _on_Clear_Wildcard_pressed():
	self.text = ""
