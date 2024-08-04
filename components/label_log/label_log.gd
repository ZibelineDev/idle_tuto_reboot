extends HBoxContainer


func _ready() -> void :
	ManagerLog.ref.log_updated.connect(_on_log_updated)
	_update_visibility()


func _update_visibility() -> void : 
	if ManagerLog.ref.get_log() == 0 : visible = false
	else : visible = true


func _on_log_updated() -> void :
	_update_visibility()
