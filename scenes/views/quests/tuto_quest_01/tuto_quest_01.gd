extends MarginContainer


@onready var _title : Label = %Title
@onready var _description : RichTextLabel = %Description
@onready var _button : Button = %Button

@onready var _quest : TutoQuest01 = ManagerQuest.ref.get_tuto_quest_01()


func _ready() -> void :
	_update_title()
	_update_description()
	_update_button_text()
	_update_button_availability()
	
	_button.pressed.connect(_on_button_pressed)
	_quest.completed.connect(_on_quest_completed)


func _update_title() -> void : 
	_title.text = _quest.get_title()


func _update_description() -> void : 
	_description.text = _quest.get_description()


func _update_button_text() -> void :
	_button.text = _quest.get_button_text()


func _update_button_availability() -> void :
	_button.disabled = _quest.is_completed()


func _on_button_pressed() -> void : 
	_quest.purchase_completion()


func _on_quest_completed() -> void :
	_update_title()
	_update_button_text()
	_update_button_availability()
