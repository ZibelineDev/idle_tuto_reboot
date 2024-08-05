class_name Data
extends Resource

@export var silver : int = 0
@export var logs : int = 0

@export var generator_silver : DataGeneratorSilver = DataGeneratorSilver.new()
@export var generator_log : DataGeneratorLog = DataGeneratorLog.new()

@export var progression : DataProgression = DataProgression.new()

@export var settings : DataSettings = DataSettings.new()
