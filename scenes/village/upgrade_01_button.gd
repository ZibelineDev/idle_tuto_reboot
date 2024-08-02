extends Button

var _cost : int = -1


func _ready() -> void :
	SilverGenerator.ref.get_upgrade_01().leveled_up.connect(_on_upgrade_01_leveled_up)
	ManagerSilver.ref.silver_updated.connect(_on_silver_updated)
	pressed.connect(_on_pressed)
	_update_cost()
	_update_disbaled()


func _update_text() -> void : 
	text = "Purchase\n%s Silver" %_cost


func _update_cost() -> void : 
	_cost = SilverGenerator.ref.get_upgrade_01().get_cost()
	_update_text()


func _update_disbaled() -> void : 
	if _cost < 0 :
		disabled = true
		return
	
	disabled = false if ManagerSilver.ref.can_spend(_cost) else true


func _on_upgrade_01_leveled_up() -> void :
	_update_cost()
	_update_disbaled()


func _on_silver_updated() -> void :
	_update_disbaled()


func _on_pressed() -> void : 
	SilverGenerator.ref.get_upgrade_01().purchase_level_up()
