class_name ManagerLog
extends Node


#region Singleton
static var ref : ManagerLog

func _init() -> void :
	if not ref : ref = self
	else : queue_free()
#endregion


signal log_updated
signal log_created(quantity : int)
signal log_spent(quantity : int)


var _silver_value : Vector2i = Vector2i(2, 10)

@onready var data : Data = Game.ref.data


func get_log() -> int : 
	return data.logs


func get_value() -> Vector2i : 
	return _silver_value


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


func sell_log(quantity : int) -> Error : 
	if get_log() <= 0 : return FAILED
	
	var _market_data : DataMarket = Game.ref.data.market
	
	if quantity > get_log() : quantity = get_log()
	
	data.logs -= quantity
	ManagerSilver.ref.create_silver(quantity * _market_data.log_value)
	log_updated.emit()
	
	return OK 


func sell_all() -> Error : 
	return sell_log(get_log())
