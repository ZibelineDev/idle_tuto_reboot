class_name SilverGeneratorUpgrade02
extends Node


signal leveled_up


var _cost : Array[int] = [250, 1000, 5000]
var _bonus : Array[float] = [-0.1, -0.25, -0.5]

var _level : int = 0
var _max_level : int = 3


func get_title() -> String : 
	var text : String = "Networking"
	
	if not _level : return text
	
	text += " (%s)" %_level
	
	return text


func get_description() -> String : 
	return "A few connections will help you find clients faster."


func get_cost() -> int :
	if _level < 0 or _level >= _max_level : return -1
	
	return _cost[int(_level)]


func get_level() -> int :
	return _level


func get_bonus() -> float : 
	if _level <= 0 or _level > _max_level : return 0.0
	
	return _bonus[int(_level - 1)]


func purchase_level() -> Error :
	if _level >= _max_level : return FAILED
	
	if ManagerSilver.ref.spend_silver(get_cost()) != OK : return FAILED
	
	_level += 1
	leveled_up.emit()
	
	return OK 