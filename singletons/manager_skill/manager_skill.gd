class_name ManagerSkill
extends Node


#region Singleton
static var ref : ManagerSkill

func _init() -> void :
	if not ref : ref = self
	else : queue_free()
#endregion


signal leveled_up(skill : Skills)


enum Skills {
	TRADING,
	LUMBERING,
	PLANK_CRAFT,
}


var _exp_requirements : Array[int] = [
	1, 7, 19, 37, 61, 91, 127, 169, 217, 271, 331, 397, 469, 547, 631, 721, 817, 919, 1027, 1141,\
	1261, 1387, 1519, 1657, 1801
]

@onready var _data : DataSkill = Game.ref.data.skills


func _ready() -> void :
	pass


func get_level(skill : Skills) -> int : 
	var key : String = get_key(skill)
	
	if key == "error" : return -1
	
	return _data.levels[key]


func add_experience(skill : Skills, experience : int) -> Error :
	var key : String = get_key(skill)
	if key == "error" : return FAILED
	
	if get_level(skill) >= _exp_requirements.size() : return FAILED  
	
	_data.exp_requirement[key] -= experience
	
	if _data.exp_requirement[key] <= 0 : _level_up(skill, key)
	
	return OK


func get_key(skill : Skills) -> String : 
	match skill :
		Skills.TRADING :
			return "trading"
		Skills.LUMBERING : 
			return "lumbering"
		Skills.PLANK_CRAFT :
			return "plank_craft"
	
	return "error"


func get_bonus(skill : Skills) -> float : 
	return (get_level(skill) * 2.5 / 100.0)


func _level_up(skill : Skills, key : String) -> void : 
	if get_level(skill) >= _exp_requirements.size() : return 
	
	_data.levels[key] += 1 
	
	if get_level(skill) >= _exp_requirements.size() : return
	
	_data.exp_requirement[key] += _exp_requirements[_data.levels[key]]
	
	leveled_up.emit(skill)
	
	if _data.exp_requirement[key] <= 0 : _level_up(skill, key)
