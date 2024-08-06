class_name ManagerPlank
extends Node


#region Singleton
static var ref : ManagerPlank

func _init() -> void :
	if not ref : ref = self
	else : queue_free()
#endregion


signal plank_updated
signal plank_created(quantity : int)
signal plank_spent(quantity : int)


var _silver_value : Vector2i = Vector2i(25, 100)

@onready var data : DataResource = Game.ref.data.resources


func get_plank() -> int : 
	return data.planks


func get_value() -> Vector2i : 
	return _silver_value


func create_plank(quantity : int) -> Error : 
	if quantity <= 0 : return FAILED
	
	data.planks += quantity
	plank_updated.emit()
	plank_created.emit(quantity)
	
	return OK


func can_spend(quantity : int) -> bool : 
	if quantity < 0 or quantity > data.planks : return false
	
	return true


func spend_plank(quantity : int) -> Error :
	if quantity < 0 or quantity > data.planks : return FAILED
	
	data.planks -= quantity
	plank_updated.emit()
	plank_spent.emit(quantity)
	
	return OK


func sell_plank(quantity : int) -> Error : 
	if get_plank() <= 0 : return FAILED
	
	var _market_data : DataMarket = Game.ref.data.market
	
	if quantity > get_plank() : quantity = get_plank()
	
	data.planks -= quantity
	ManagerSilver.ref.create_silver(quantity * _market_data.plank_value)
	plank_updated.emit()
	
	return OK 


func sell_all() -> Error : 
	return sell_plank(get_plank())
