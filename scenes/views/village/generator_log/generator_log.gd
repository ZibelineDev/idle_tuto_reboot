extends PanelContainer


func _ready() -> void :
	_update_visibility()
	ManagerQuest.ref.get_tuto_quest_01().completed.connect(_on_tuto_quest_01_completed)


func _update_visibility() -> void : 
	if ManagerQuest.ref.get_tuto_quest_01().is_completed() : visible = true
	else : visible = false


func _on_tuto_quest_01_completed() -> void : 
	_update_visibility()
