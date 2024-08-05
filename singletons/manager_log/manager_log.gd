class_name ManagerLog
extends Node

static var ref : ManagerLog

func _init() -> void :
	if not ref : ref = self
	else : queue_free()


signal log_updated
signal log_created(quantity : int)
signal log_spent(quantity : int)


@onready var data : Data = Game.ref.data


func get_log() -> int : 
	return data.logs


func create_log(quantity : int) -> Error : 
	if quantity <= 0 : return FAILED
	
	data.logs += quantity
	log_updated.emit()
	log_created.emit(quantity)
	
	return OK


func can_spend(quantity : int) -> bool : 
	if quantity < 0 or quantity > data.logs : return false
	
	return true


func spend_log(quantity : int) -> Error :
	if quantity < 0 or quantity > data.logs : return FAILED
	
	data.logs -= quantity
	log_updated.emit()
	log_spent.emit(quantity)
	
	return OK
