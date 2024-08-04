class_name SilverGeneratorUpgrade01
extends Node


signal leveled_up


var _cost : Array[int] = [100, 250, 1000]
var _bonus : Array[Vector2i] = [
	Vector2i(2, 5),
	Vector2i(4, 10),
	Vector2i(8, 20),
]

var _level : int = 0
var _max_level : int = 3


func get_title() -> String : 
	return "Investment Fund"


func get_description() -> String : 
	return "Investing your funds with other merchants can allow to increase your profits."


func get_cost() -> int :
	if _level < 0 or _level >= _max_level : return -1
	
	return _cost[int(_level)]


func get_level() -> int :
	return _level


func get_bonus() -> Vector2i : 
	if _level <= 0 or _level > _max_level : return Vector2i(0, 0)
	
	return _bonus[int(_level - 1)]


func purchase_level() -> Error :
	if _level >= _max_level : return FAILED
	
	if ManagerSilver.ref.spend_silver(get_cost()) != OK : return FAILED
	
	_level += 1
	leveled_up.emit()
	
	return OK 
