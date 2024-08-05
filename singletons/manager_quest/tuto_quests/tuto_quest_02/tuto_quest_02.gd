class_name TutoQuest02
extends Node


signal completed
signal progressed
signal unlocked


var _goal : int = 2

@onready var _progression : DataProgression = Game.ref.data.progression


func _ready() -> void :
	if not is_unlocked() :
		ManagerQuest.ref.get_tuto_quest_01().completed.connect(_on_tuto_quest_01_completed)
	
	if not is_completed() and is_unlocked() :
		ManagerLog.ref.log_created.connect(_on_log_created)


func get_button_text() -> String : 
	if is_completed() : return "Completed"
	return "Validate"


func get_description() -> String : 
	return "[center]You can produce some logs at the lumbering camp.\
	\nProduce 2 logs.[/center]"


func get_progress() -> float : 
	if _progression.tuto_quest_02_progress >= _goal : return 100
	return _progression.tuto_quest_02_progress / float(_goal) * 100


func get_title() -> String :
	var text : String = "Producing a few Logs"
	
	if is_completed() : text += " (Completed)"
	
	return text


func is_completed() -> bool : 
	return _progression.tuto_quest_02_completed


func is_unlocked() -> bool : 
	return _progression.tuto_quest_01_completed


func purchase_completion() -> Error : 
	if is_completed() : return FAILED
	
	if _progression.tuto_quest_02_progress < _goal : return FAILED 
	
	Game.ref.data.progression.tuto_quest_02_completed = true
	completed.emit()
	
	return OK 


func _on_log_created(quantity : int) -> void : 
	_progress(quantity)


func _on_tuto_quest_01_completed() -> void :
	ManagerLog.ref.log_created.connect(_on_log_created)
	
	unlocked.emit()


func _progress(quantity : int) -> void : 
	_progression.tuto_quest_02_progress += quantity
	
	if _progression.tuto_quest_02_progress > _goal :
		_progression.tuto_quest_02_progress = _goal
	
	if _progression.tuto_quest_02_progress >= _goal : 
		ManagerLog.ref.log_created.disconnect(_on_log_created)
	
	progressed.emit()
