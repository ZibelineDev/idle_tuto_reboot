class_name GeneratorSilverUpgrade02
extends Node


signal leveled_up


var _cost : Array[int] = [250, 1000, 5000]
var _bonus : Array[float] = [-0.1, -0.25, -0.5]

var _max_level : int = 3

@onready var data : DataGeneratorSilver = Game.ref.data.generator_silver


func get_title() -> String : 
	var text : String = "Networking"
	
	if not data.upgrade_02_level : return text
	
	text += " (%s)" %data.upgrade_02_level
	
	return text


func get_description() -> String : 
	return "A few connections will help you find clients faster."


func get_cost() -> int :
	if data.upgrade_02_level < 0 or data.upgrade_02_level >= _max_level : return -1
	
	return _cost[int(data.upgrade_02_level)]


func get_level() -> int :
	return data.upgrade_02_level


func get_bonus() -> float : 
	if data.upgrade_02_level <= 0 or data.upgrade_02_level > _max_level : return 0.0
	
	return _bonus[int(data.upgrade_02_level - 1)]


func purchase_level() -> Error :
	if data.upgrade_02_level >= _max_level : return FAILED
	
	if ManagerSilver.ref.spend_silver(get_cost()) != OK : return FAILED
	
	data.upgrade_02_level += 1
	leveled_up.emit()
	
	return OK 
