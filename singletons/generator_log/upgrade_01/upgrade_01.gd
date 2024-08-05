class_name GeneratorLogUpgrade01
extends Node


signal leveled_up


var _cost : Array[int] = [1000, 2500, 25000]
var _bonus : Array[Vector2i] = [
	Vector2i(1, 2),
	Vector2i(2, 5),
	Vector2i(5, 10),
]

var _max_level : int = 3

@onready var _data : DataGeneratorLog = Game.ref.data.generator_log


func get_title() -> String : 
	var text : String =  "Increase Log Production"
	
	if not _data.upgrade_01_level : return text
	
	text += " (%s)" %_data.upgrade_01_level
	
	return text


func get_description() -> String : 
	return "Increase the amount of logs produced."


func get_cost() -> int :
	if _data.upgrade_01_level < 0 or _data.upgrade_01_level >= _max_level : return -1
	
	return _cost[int(_data.upgrade_01_level)]


func get_level() -> int :
	return _data.upgrade_01_level


func get_bonus() -> Vector2i : 
	if _data.upgrade_01_level <= 0 or _data.upgrade_01_level > _max_level : return Vector2i(0, 0)
	
	return _bonus[int(_data.upgrade_01_level - 1)]


func get_button_text() -> String :
	if is_max_level() : return "Max Level"
	else : return "Purchase\n%s : Silver" %StringFormat.thousands_sep(get_cost())


func is_max_level() -> bool : 
	if _data.upgrade_01_level >= _max_level : return true
	else : return false


func purchase_level() -> Error :
	if _data.upgrade_01_level >= _max_level : return FAILED
	
	if ManagerSilver.ref.spend_silver(get_cost()) != OK : return FAILED
	
	_data.upgrade_01_level += 1
	leveled_up.emit()
	
	return OK 
