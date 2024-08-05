class_name Data
extends Resource

@export var silver : int
@export var logs : int

@export var generator_silver : DataGeneratorSilver
@export var progression : DataProgression


func _init() -> void :
	silver = 0 
	logs = 0
	
	generator_silver = DataGeneratorSilver.new()
	progression = DataProgression.new()
