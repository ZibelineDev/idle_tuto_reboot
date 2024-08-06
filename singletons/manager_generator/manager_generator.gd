class_name ManagerGenerator
extends Node


#region Singleton Region
static var ref : ManagerGenerator

func _init() -> void :
	if not ref : ref = self 
	else : queue_free()
#endregion


enum Generators {
	SIVLER,
	LOG,
}


var _generator_limit : int = 1
var _active_generators : Array[Generator]

@onready var _progression : DataProgression = Game.ref.data.progression


func _ready() -> void :
	_calculate_generator_limit()
	
	if not _progression.tuto_quest_02_completed : 
		ManagerQuest.ref.get_tuto_quest_02().completed.connect(_on_tuto_quest_02_completed)


func start_generator(generator : Generator) -> Error :
	if generator_limit_reached() : return FAILED
	
	_active_generators.append(generator)
	
	return OK 


func stop_generator(generator : Generator) -> Error : 
	_active_generators.erase(generator)
	return OK 


func generator_limit_reached() -> bool : 
	if _active_generators.size() >= _generator_limit : return true
	else : return false


func get_generator_silver() -> GeneratorSilver :
	return $GeneratorSilver


func get_generator_log() -> GeneratorLog : 
	return $GeneratorLog


func _calculate_generator_limit() -> void : 
	var new_limit : int = 1 
	if _progression.tuto_quest_02_completed : new_limit += 1 
	
	_generator_limit = new_limit


func _on_tuto_quest_02_completed() -> void :
	_calculate_generator_limit()
	ManagerQuest.ref.get_tuto_quest_02().completed.disconnect(_on_tuto_quest_02_completed)
