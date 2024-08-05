extends MarginContainer


@onready var _quest : TutoQuest01 = ManagerQuest.ref.get_tuto_quest_01()

@onready var _title : Label = %Title
@onready var _description : RichTextLabel = %Description
@onready var _button : Button = %Button


func _ready() -> void :
	_update_title()
	_update_description()
	_update_button()
	
	if not _quest.is_completed() :
		_quest.completed.connect(_on_quest_completed)
		_button.pressed.connect(_on_button_pressed)


func _update_button() -> void :
	_button.text = _quest.get_button_text()
	
	_button.disabled = true if _quest.is_completed() else false


func _update_description() -> void : 
	_description.text = _quest.get_description()


func _update_title() -> void : 
	_title.text = _quest.get_title()


func _on_button_pressed() -> void :
	_quest.purchase_completion()


func _on_quest_completed() -> void : 
	_update_button()
	_update_title()
	
	_quest.completed.disconnect(_on_quest_completed)
	_button.pressed.disconnect(_on_button_pressed)
