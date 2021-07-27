extends WindowDialog
var itemVarFields = []
var itemValFields = []
var itemModmenus = []
var index:int = -1 #index of selected item

#name of choice
var choiceName:String = "new choice"
#list of items
var choiceItems = []

#TODO: add as support is added
#TODO: move to KvaTools as a global constant
const ITEM_TYPE_NAMES = PoolStringArray([
	"Go to page",
	"Variable condition",
	"Set variable"
	])
const ITEM_TYPE_NAME_FORMATS = PoolStringArray([
	"Go to {var}",
	"if {var} {mod_name} {val}",
	"set {var} {mod_name} {val}"
])
const ITEM_TYPE_MOD_NAME = [
	["ERROR","ERROR","ERROR","ERROR"],
	["==", "!=", "<=", ">="],
	["=", "+=", "ERROR", "ERROR"]
]



func _ready():
	#link the variable, value and mode fields
	#get all edit choice item var fields members
	itemVarFields = get_tree().get_nodes_in_group("e_c_itemVarFields")
	itemValFields = get_tree().get_nodes_in_group("e_c_itemValFields")
	itemModmenus  = get_tree().get_nodes_in_group("e_c_itemModmenus")
	
	
	for f in itemVarFields:
		(f as LineEdit).connect("text_changed", self, "setItemVar", [f])
	for f in itemValFields:
		(f as LineEdit).connect("text_changed", self, "setItemVal", [f])
	for f in itemModmenus:
		(f as OptionButton).connect("item_selected", self, "setItemMode", [f])
		
	refresh()

func setItemVar(data, origin=null):
	if(index < 0 || index >= choiceItems.size()):
		return
	if(data == choiceItems[index]["var"]):
		return
	choiceItems[index]["var"] = data
	refresh(origin)
func setItemVal(data, origin=null):
	if(index < 0 || index >= choiceItems.size()):
		return
	if(data == choiceItems[index]["val"]):
		return
	choiceItems[index]["val"] = data
	refresh(origin)
func setItemMode(data, origin=null):
	if(index < 0 || index >= choiceItems.size()):
		return
	if(data == choiceItems[index]["mod"]):
		return
	choiceItems[index]["mod"] = data
	refresh(origin)

	
func setItemType(data):
	if(index < 0 || index >= choiceItems.size()):
		return
	choiceItems[index]["typ"] = data
	refresh()
func getName(i) -> String:
	if(i >= choiceItems.size() || i < 0):
		return "ERROR"
	var itm = choiceItems[i] # item
	var mod_name = ITEM_TYPE_MOD_NAME[itm["typ"]][itm["mod"]]
	return ITEM_TYPE_NAME_FORMATS[itm["typ"]].format({"var":itm["var"], "val":itm["val"], "mod_name": mod_name})


	
func refresh(ignore = null): 
	# refresh names
	var items:ItemList = $"HBoxContainer/content 1/Panel/ItemList"
	#Note: renaming and adding/removing list-items as needed might be better.
	for i in choiceItems.size():
		var n = getName(i)
		if(items.get_item_count() <= i):
			items.add_item(n)
		else:
			items.set_item_text(i, n)
	while(items.get_item_count() > choiceItems.size()):
		items.remove_item(items.get_item_count()-1)
	#selects the current index. This should not trigger
	#signal item_selected. If it does, it will cause a loop
	items.select(index, true)
	$"HBoxContainer/content 2/itemname_label".text = getName((index))
	
	#DO NOT REFRESH any datafields if index is invalid.
	if(index < 0 || index >= choiceItems.size()):
		return
	# refresh mod
	for f in itemModmenus:
		if f == ignore:
			continue
		(f as OptionButton).selected = choiceItems[index]["mod"]
	# refreshvar
	for f in itemVarFields:
		if f == ignore:
			continue
		(f as LineEdit).text = choiceItems[index]["var"] 
	#refresh val
	for f in itemValFields:
		if f == ignore:
			continue
		(f as LineEdit).text = choiceItems[index]["val"]
#End of refresh

func CreateNewItem():
	choiceItems.push_back({"typ":0,"var":"null","mod":0,"val":""})
	index = choiceItems.size()-1
	refresh()
	


func onItemSelected(new_index):
	index = new_index
	refresh()


func DeleteItem():
	choiceItems.remove(index)
	if(index >= choiceItems.size()):
		index = choiceItems.size()-1
	refresh()

#make sure choice and name is set up right before showtime
func on_about_to_show():
	refresh()
	
func _on_Edit_Choice_popup_hide():
	index = -1
	choiceName = "new choice"
	choiceItems = []

func on_set_choice_name(new_name):
	choiceName = new_name

signal save_choice(name, items)
func on_save_create():
	emit_signal("save_choice", choiceName, choiceItems)
	hide()
