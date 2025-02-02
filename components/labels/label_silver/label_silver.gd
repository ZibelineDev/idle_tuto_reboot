extends Label


func _ready() -> void :
	_update_text()
	ManagerSilver.ref.silver_updated.connect(_on_silver_updated)


func _update_text() -> void : 
	text = "Silver : %s" %StringFormat.thousands_sep(ManagerSilver.ref.get_silver())
	tooltip_text = StringFormat.thousands_sep(ManagerSilver.ref.get_silver())


func _on_silver_updated() -> void : 
	_update_text()
