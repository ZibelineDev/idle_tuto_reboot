class_name Data
extends Resource

@export var silver : int

@export var generator_silver : DataGeneratorSilver


func _init() -> void :
	silver = 0 
	
	generator_silver = DataGeneratorSilver.new()
