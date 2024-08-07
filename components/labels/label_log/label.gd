extends Label


func _ready() -> void :
	_update_text()
	ManagerLog.ref.log_updated.connect(_on_log_updated)


func _update_text() -> void : 
	text = "Logs : %s" %StringFormat.thousands_sep(ManagerLog.ref.get_log())
	tooltip_text = StringFormat.thousands_sep(ManagerLog.ref.get_log())


func _on_log_updated() -> void : 
	_update_text()
