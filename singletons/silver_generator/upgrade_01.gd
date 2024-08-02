class_name SilverGeneratorUpgrade01
extends Node


signal leveled_up


var _title : String = "Invest Funds"
var _description : String = "Invest some Silver in the Market.\nIncrease profits."

var _cost : Array[int] = [100, 500, 2500]
var _bonus : Array[Vector2i] = [
	Vector2i(5, 10),
	Vector2i(10, 20),
	Vector2i(25, 75),
]

var _level : int = 0
var _max_level : int = 3


func get_title() -> String :
	return _title


func get_description() -> String : 
	return _description


func get_cost() -> int : 
	if _level >= _max_level : return -1
	
	return _cost[int(_level)]


func get_level() -> int :
	return _level


func get_bonus() -> Vector2i : 
	if _level <= 0 : return Vector2i(0, 0)
	if _level >= _max_level : return _bonus[int(_max_level - 1)] 
	
	return _bonus[int(_level - 1)]


func purchase_level_up() -> Error :
	if _level >= _max_level : return FAILED
	
	if ManagerSilver.ref.spend_silver(get_cost()) != OK : return FAILED
	_level += 1 
	
	leveled_up.emit()
	
	return OK 
