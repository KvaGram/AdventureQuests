extends Object
class_name KvaTools

static func nestedSplit(source:String, delimiters:Array) -> Array:
	var res1 = source.split(delimiters[0], false)
	if delimiters.size() <= 1:
		return res1
	var deli2 = delimiters.duplicate()
	deli2.pop_front()
	var res2 = []
	for r in res1.size():
		res2.append_array( nestedSplit(res1[r], deli2))
	return res2;
	
#todo: add set list OptionsButton
