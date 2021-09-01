extends GridContainer
var area_list:AreaList
var areaListLoc = "res://src/areas/AreaList.tres"

func _ready():
	area_list = ResourceLoader.load(areaListLoc)
	
func refresh():
	pass
