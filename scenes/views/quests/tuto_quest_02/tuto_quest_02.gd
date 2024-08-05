extends MarginContainer


@onready var _title : Label = %Title
@onready var _description : RichTextLabel = %Description
@onready var _button : Button = %Button
@onready var _progress_bar : ProgressBar = %ProgressBar

@onready var _quest : TutoQuest02 = ManagerQuest.ref.get_tuto_quest_02()


func _ready() -> void :
	_update_title()
	_update_description()
	_update_button_text()
	_update_button_availability()
	_update_progress_bar()
	_update_visibility()
	
	_button.pressed.connect(_on_button_pressed)
	
	if not _quest.is_unlocked() : 
		_quest.unlocked.connect(_on_quest_unlocked)
	
	if not _quest.is_completed() :
		_quest.completed.connect(_on_quest_completed)
		_quest.progressed.connect(_on_quest_progressed)


func _update_title() -> void : 
	_title.text = _quest.get_title()


func _update_description() -> void : 
	_description.text = _quest.get_description()


func _update_button_text() -> void :
	_button.text = _quest.get_button_text()


func _update_button_availability() -> void :
	_button.disabled = _quest.is_completed()


func _update_progress_bar() -> void : 
	_progress_bar.value = _quest.get_progress()


func _update_visibility() -> void : 
	if _quest.is_unlocked() : visible = true
	else : visible = false


func _on_button_pressed() -> void : 
	_quest.purchase_completion()


func _on_quest_completed() -> void :
	_update_title()
	_update_button_text()
	_update_button_availability()


func _on_quest_progressed() -> void : 
	_update_progress_bar()


func _on_quest_unlocked() -> void : 
	_update_visibility()
