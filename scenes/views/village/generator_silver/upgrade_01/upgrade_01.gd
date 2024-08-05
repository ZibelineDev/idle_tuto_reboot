extends MarginContainer


@onready var _title : Label = get_node("HBoxContainer/Description/Title")
@onready var _description : Label = get_node("HBoxContainer/Description/Description")
@onready var _purchase_button : Button  = get_node("HBoxContainer/Button")

@onready var _upgrade : GeneratorLogUpgrade01 = GeneratorLog.ref.get_upgrade_01()


func _ready() -> void :
	_purchase_button.pressed.connect(_on_purchas_button_pressed)
	_upgrade.leveled_up.connect(_on_upgrade_01_leveled_up)
	ManagerSilver.ref.silver_updated.connect(_on_silver_updated)
	_update_title()
	_update_description()
	_update_button_text()
	_update_button_availability()


func _update_title() -> void :
	_title.text = _upgrade.get_title()


func _update_description() -> void :
	_description.text = _upgrade.get_description()


func _update_button_text() -> void :
	_purchase_button.text = _upgrade.get_button_text()


func _update_button_availability() -> void :
	if _upgrade.is_max_level():
		_purchase_button.disabled = true
	
	else : 
		if ManagerSilver.ref.can_spend(_upgrade.get_cost()) : _purchase_button.disabled = false
		else : _purchase_button.disabled = true


func _on_silver_updated() -> void : 
	_update_button_availability()


func _on_upgrade_01_leveled_up() -> void : 
	_update_button_text()
	_update_button_availability()
	_update_title()


func _on_purchas_button_pressed() -> void :
	_upgrade.purchase_level()
