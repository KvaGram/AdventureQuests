extends HBoxContainer
class_name AttributeEditor

#TODO: add as support is added
#TODO: move to KvaTools as a global constant
const ATTR_TYPE_NAMES = PoolStringArray([
	"Go to page",
	"Variable condition",
	"Set variable"
	])
const ATTR_TYPE_NAME_FORMATS = PoolStringArray([
	"Go to {var}",
	"if {var} {mod_name} {val}",
	"set {var} {mod_name} {val}"
])
const ATTR_TYPE_MOD_NAME = [
	["ERROR","ERROR","ERROR","ERROR"],
	["==", "!=", "<=", ">="],
	["=", "+=", "ERROR", "ERROR"]
]

#These are fields in the attribute editor.
#They are set using node-groups. see _ready()
var attrVarFields = []
var attrValFields = []
var attrModmenus = []
var target:Array
var attr_i

func setTarget(new_target:Array):
	target = new_target
	refresh()

func refresh(ignore = null): 
	# refresh names
	var items:ItemList = $"content 1/Panel/ItemList"
	#Note: renaming and adding/removing list-items as needed might be better.
	for i in target.size():
		var n = getName(i)
		if(items.get_item_count() <= i):
			items.add_item(n)
		else:
			items.set_item_text(i, n)
	while(items.get_item_count() > target.size()):
		items.remove_item(items.get_item_count()-1)
	#selects the current index. This should not trigger
	#signal item_selected. If it does, it will cause a loop
	items.select(attr_i, true)
	$"content 2/itemname_label".text = getName((attr_i))
	
	#DO NOT REFRESH any datafields if index is invalid.
	if(attr_i < 0 || attr_i >= target.size()):
		return
	# refresh mod
	for f in attrModmenus:
		if f == ignore:
			continue
		(f as OptionButton).selected = target[attr_i]["mod"]
	# refreshvar
	for f in attrVarFields:
		if f == ignore:
			continue
		(f as LineEdit).text = target[attr_i]["var"] 
	#refresh val
	for f in attrValFields:
		if f == ignore:
			continue
		(f as LineEdit).text = target[attr_i]["val"]
#End of refresh

func setAttrVar(data, origin=null):
	if(attr_i < 0 || attr_i >= target.size()):
		return
	if(data == target[attr_i]["var"]):
		return
	target[attr_i]["var"] = data
	refresh(origin)
func setAttrVal(data, origin=null):
	if(attr_i < 0 || attr_i >= target.size()):
		return
	if(data == target[attr_i]["val"]):
		return
	target[attr_i]["val"] = data
	refresh(origin)
func setAttrMode(data, origin=null):
	if(attr_i < 0 || attr_i >= target.size()):
		return
	if(data == target[attr_i]["mod"]):
		return
	target[attr_i]["mod"] = data
	refresh(origin)

func setAttrType(data):
	if(attr_i < 0 || attr_i >= target.size()):
		return
	target[attr_i]["typ"] = data
	refresh()
func getName(i) -> String:
	if(i >= target.size() || i < 0):
		return "ERROR"
	var itm = target[i] # attribute item
	var mod_name = ATTR_TYPE_MOD_NAME[itm["typ"]][itm["mod"]]
	return ATTR_TYPE_NAME_FORMATS[itm["typ"]].format({"var":itm["var"], "val":itm["val"], "mod_name": mod_name})

func CreateNewItem():
	target.push_back({"typ":0,"var":"null","mod":0,"val":""})
	attr_i = target.size()-1
	refresh()

func onItemSelected(new_index):
	attr_i = new_index
	refresh()


func DeleteItem():
	target.remove(attr_i)
	if(attr_i >= target.size()):
		attr_i = target.size()-1
	refresh()

func _ready():
	#link the variable, value and mode fields
	#get all edit choice item var fields members
	attrVarFields = get_tree().get_nodes_in_group("e_c_attrVarFields")
	attrValFields = get_tree().get_nodes_in_group("e_c_attrValFields")
	attrModmenus  = get_tree().get_nodes_in_group("e_c_attrModmenus")
	
	
	for f in attrVarFields:
		(f as LineEdit).connect("text_changed", self, "setAttrVar", [f])
	for f in attrValFields:
		(f as LineEdit).connect("text_changed", self, "setAttrVal", [f])
	for f in attrModmenus:
		(f as OptionButton).connect("item_selected", self, "setAttrMode", [f])
		
	refresh()
