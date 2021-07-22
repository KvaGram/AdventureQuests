extends WindowDialog
export var itemVarFields = []
export var itemValFields = []
export var itemModmenus = []

var choiceItems = []
var index = -1

func _ready():
	#link the variable, value and mode fields
	for f in itemVarFields:
		(f as LineEdit).connect("text_changed", self, "setItemVar")
	for f in itemValFields:
		(f as LineEdit).connect("text_changed", self, "setItemVal")
	for f in itemModmenus:
		(f as OptionButton).connect("item_selected", self, "setItemVar")
		
	
	refresh()

func setItemVar(data):
	if(index >= choiceItems.size()):
		return
	choiceItems[index]["var"] = data
	pass
func setItemVal(data):
	if(index >= choiceItems.size()):
		return
	choiceItems[index]["val"] = data
	pass
func setItemMode(data):
	if(index >= choiceItems.size()):
		choiceItems[index]["mod"] = data
		return
	pass
func setItemType(data):
	if(index >= choiceItems.size()):
		choiceItems[index]["typ"] = data
		return
	pass


	
func refresh():
	var items:ItemList = null#$"HBoxContainer/content 1/Panel/ItemList"
	#TODO populate the itemlists with known items of the choice

	var addnewList:OptionButton = null#$"HBoxContainer/content 1/Panel/HBoxContainer/NewItemTypeDroplist"
	addnewList.add_item("Variable Condition")
	#TODO: add as support is added
	

	var varoptget:OptionButton = null#$"HBoxContainer/EditItemsPanel/EditItems/Condition (number)/HBoxContainer/Numvar_options"
	varoptget.clear()
	varoptget.add_item("equal")
	varoptget.add_item("not equal")
	varoptget.add_item("greater or equal*")
	varoptget.add_item("lesser or equal*")
	
	var varoptset:OptionButton = $"HBoxContainer/Itemeditor/EditItemsPanel/EditItems/Set Variable/HBoxContainer/VarOptSet"
	varoptget.clear()
	varoptget.add_item("set to")
	varoptget.add_item("add by*")

#"HBoxContainer/content 1/Panel/HBoxContainer/NewItemButton"
