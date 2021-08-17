extends Resource
class_name DialogueData

#WARNING: Due to my own inconsistancy of thinking,
# Lines are interchangable with pages in
# variablenames and documentation.
#  - KvaGram

#dialogue lines
export var lines = []
#conditions for showing this dialogue
export var conditions = []
#Name to display, if ever needed to select from a list
export var name = ""

export var audio:AudioStream

func addLine(index = -1):
	var newline = {}
	newline["name"] = ""
	newline["text"] = ""
	newline["tag"] = ""
	newline["audio_start"] = 0.0
	newline["audio_end"] = 0.0 
	newline["choices"] = {}
	
	#if index is valid, insert it there.
	if index >= 0 && index < lines.size():
		lines.insert(index, newline)
	#else appent the new line
	else:
		lines.append(newline)

func getTagList() -> Array :
	var list = []
	for l in lines:
		if l["tag"].length() > 0 and not list.has(l["tag"]):
			list.append(l["tag"])
	return list
func getLineByTag(tag:String):
	for l in lines:
		if(l["tag"] == tag):
			return tag
	return null
func getIndexByTag(tag:String):
	for i in lines.size():
		if(lines[i]["tag"] == tag):
			return i
	return -1
func getTagByIndex(ind:int):
	return lines[ind]["tag"]
func getChoicesKeys(ind):
	return lines[ind]["choices"].keys()
func getChoiceAttributes(ind, choicename):
	if(ind < 0 || ind >= lines.size() || choicename == null || choicename == ""):
		return null
	return lines[ind]["choices"][choicename]
func getLine(index:int):
	if(index < 0 || index > lines.size()):
		return null
	return lines[index]

