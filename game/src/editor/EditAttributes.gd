extends Control
#This script is a control-wrapper for AttributeEditor

var target_book:DialogueData = null
var target_is_book = false
var target_line = -1
var target_choice = ""

var tag_list:OptionButton
var page_spinbox:SpinBox
var page_choices:OptionButton
var aec:TabContainer #AttributeEditorContainer
var edit_mode:TabContainer #book attributes or page/line attributes?

func _ready():
	refresh()
	tag_list =     $"Attributes editor/Edit mode/Edit page choices/HBoxContainer/tag_list"
	page_spinbox = $"Attributes editor/Edit mode/Edit page choices/HBoxContainer/page_spinbox"
	page_choices = $"Attributes editor/Edit mode/Edit page choices/HBoxContainer/page_choices"
	aec =          $"Attributes editor/AttributeEditorContainer"
	edit_mode =    $"Attributes editor/Edit mode"#TODO: take tab selected signal from this, feed into target_is_book
	if(target_book == null):
		target_book = $"..".dialogue
	 
func refresh():
	if(visible == false):
		return
	#if(edit_mode.current_tab == 0)
	var tags = target_book.getTagList()
	var i = 0
	#Add or rename items in tag_list
	while i < tags.size():
		if i >= tag_list.get_item_count():
			tag_list.add_item(tags[i])
		tag_list.set_item_text(i, tags[i])
		i += 1
	#remove excess items in tag_list
	while(i < tag_list.get_item_count()):
		tag_list.remove_item(i)
	page_spinbox.max_value = target_book.lines.size()-1

func onSelectTag(value):
	value = tag_list.get_item_text(value)
	value = target_book.getIndexByTag(value)
	page_spinbox.value = value
	return onSetLine(value)

func onSetLine(value):
	#TODO: update page choices
	target_line = value
	#update selected tag
	tag_list.text = target_book.getTagByIndex((value))
	var choice_names = target_book.getChoicesKeys(value)
	var i = 0
	#add or rename items in page_choices
	while i < choice_names.size():
		if i >= page_choices.get_item_count():
			page_choices.add_item(choice_names[i])
		page_choices.set_item_text(i, choice_names[i])
		i += 1
	#remove excess items in page_choices
	while(i < page_choices.get_item_count()):
		page_choices.remove_item(i)
	page_choices.select(0)
	if(choice_names.size() <= 0):
		setAttributeTarget(null)
	else:
		setAttributeTarget(choice_names[0])

func setAttributeTarget(value):
	if not value is Array:
		value = target_book.getChoiceAttributes(target_line, value)
	if(value == null or not value is Array):
		#disable the attribute editor
		$"Attributes editor/AttributeEditorContainer".current_tab = 1
	else:
		#enable the attribute editor, and set the target array refrence
		$"Attributes editor/AttributeEditorContainer".current_tab = 0
		$"Attributes editor/AttributeEditorContainer/AttributeEditor".setTarget(value)
	
func _on_new_book(new_dialogue):
	target_book = new_dialogue


#When the editor tab change, do a reset.
#Just in case it is this one.
func _on_parent_tab_changed(_tab):
	refresh()
