class_name ManagerSilver
extends Node

static var ref : ManagerSilver

func _init() -> void :
	if not ref : ref = self
	else : queue_free()


signal silver_updated
signal silver_created(quantity : int)
signal silver_spent(quantity : int)


var _silver : int = 0


func get_silver() -> int :
	return _silver


func create_silver(quantity : int) -> void : 
	if quantity <= 0 : return
	
	_silver += quantity
	
	silver_created.emit(quantity)
	silver_updated.emit()


func can_spend(quantity : int) -> bool :
	if quantity < 0 : return false
	
	if quantity > _silver : return false
	
	return true


func spend_silver(quantity : int) -> Error :
	if quantity < 0 : return Error.FAILED
	
	if quantity > _silver : return Error.FAILED
	
	_silver -= quantity
	
	silver_spent.emit(quantity)
	silver_updated.emit()
	
	return Error.OK
