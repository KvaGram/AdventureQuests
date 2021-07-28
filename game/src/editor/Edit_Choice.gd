extends WindowDialog
var attrVarFields = []
var attrValFields = []
var attrModmenus = []
var index:int = -1 #index of selected item

#name of choice
var choiceName:String = "new choice"
#list of items
var choiceAttrs = []

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

func setAttrVar(data, origin=null):
	if(index < 0 || index >= choiceAttrs.size()):
		return
	if(data == choiceAttrs[index]["var"]):
		return
	choiceAttrs[index]["var"] = data
	refresh(origin)
func setAttrVal(data, origin=null):
	if(index < 0 || index >= choiceAttrs.size()):
		return
	if(data == choiceAttrs[index]["val"]):
		return
	choiceAttrs[index]["val"] = data
	refresh(origin)
func setAttrMode(data, origin=null):
	if(index < 0 || index >= choiceAttrs.size()):
		return
	if(data == choiceAttrs[index]["mod"]):
		return
	choiceAttrs[index]["mod"] = data
	refresh(origin)

	
func setAttrType(data):
	if(index < 0 || index >= choiceAttrs.size()):
		return
	choiceAttrs[index]["typ"] = data
	refresh()
func getName(i) -> String:
	if(i >= choiceAttrs.size() || i < 0):
		return "ERROR"
	var itm = choiceAttrs[i] # item
	var mod_name = ATTR_TYPE_MOD_NAME[itm["typ"]][itm["mod"]]
	return ATTR_TYPE_NAME_FORMATS[itm["typ"]].format({"var":itm["var"], "val":itm["val"], "mod_name": mod_name})


	
func refresh(ignore = null): 
	# refresh names
	var items:ItemList = $"HBoxContainer/content 1/Panel/ItemList"
	#Note: renaming and adding/removing list-items as needed might be better.
	for i in choiceAttrs.size():
		var n = getName(i)
		if(items.get_item_count() <= i):
			items.add_item(n)
		else:
			items.set_item_text(i, n)
	while(items.get_item_count() > choiceAttrs.size()):
		items.remove_item(items.get_item_count()-1)
	#selects the current index. This should not trigger
	#signal item_selected. If it does, it will cause a loop
	items.select(index, true)
	$"HBoxContainer/content 2/itemname_label".text = getName((index))
	
	#DO NOT REFRESH any datafields if index is invalid.
	if(index < 0 || index >= choiceAttrs.size()):
		return
	# refresh mod
	for f in attrModmenus:
		if f == ignore:
			continue
		(f as OptionButton).selected = choiceAttrs[index]["mod"]
	# refreshvar
	for f in attrVarFields:
		if f == ignore:
			continue
		(f as LineEdit).text = choiceAttrs[index]["var"] 
	#refresh val
	for f in attrValFields:
		if f == ignore:
			continue
		(f as LineEdit).text = choiceAttrs[index]["val"]
#End of refresh

func CreateNewItem():
	choiceAttrs.push_back({"typ":0,"var":"null","mod":0,"val":""})
	index = choiceAttrs.size()-1
	refresh()
	


func onItemSelected(new_index):
	index = new_index
	refresh()


func DeleteItem():
	choiceAttrs.remove(index)
	if(index >= choiceAttrs.size()):
		index = choiceAttrs.size()-1
	refresh()

#make sure choice and name is set up right before showtime
func on_about_to_show():
	refresh()
	
func _on_Edit_Choice_popup_hide():
	index = -1
	choiceName = "new choice"
	choiceAttrs = []

func on_set_choice_name(new_name):
	choiceName = new_name

signal save_choice(name, attributes)
func on_save_create():
	emit_signal("save_choice", choiceName, choiceAttrs)
	hide()
