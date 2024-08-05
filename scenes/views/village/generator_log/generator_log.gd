extends PanelContainer


func _ready() -> void :
	if GeneratorLog.ref.is_unlocked() : _unlock()
	else : _lock()


func _lock() -> void : 
	visible = false


func _unlock() -> void :
	visible = true
