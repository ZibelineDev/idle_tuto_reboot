class_name Game
extends Node

static var ref : Game

func _init() -> void :
	if not ref : ref = self
	else : queue_free()


var data : Data

@onready var _save_timer : Timer = $SaveTimer


func _enter_tree() -> void :
	data = Data.new()
	ManagerSave.load_data()


func _ready() -> void :
	_save_timer.timeout.connect(_on_save_timer_tiemout)


func _on_save_timer_tiemout() -> void : 
	ManagerSave.save_data()
