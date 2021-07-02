extends Resource

class_name AreaList

#The AreaList data. there is only one of this, and holds the list of every
#area. The list is an array of AreaData.
#The fallback is an AreaData presenting an "unknown area".

export var areas : Array
export var fallback : Resource

func getArea(code:String):
	code = code.to_upper() 
	for a in areas:
		if(!a is AreaData):
			printerr("non-AreaData object "+str(a) +" found in areas list.")
			continue
		if a.code.to_upper() == code:
			return a
	return fallback


func _ready():
	pass
