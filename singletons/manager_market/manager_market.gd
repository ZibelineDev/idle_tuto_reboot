class_name ManagerMarket
extends Node


#region Singleton
static var ref : ManagerMarket

func _init() -> void :
	if not ref : ref = self
	else : queue_free()
#endregion


signal market_updated


@export var _timer : Timer 


func _ready() -> void :
	_timer.timeout.connect(_on_timer_timeout)


func get_log() -> MarketLog : 
	return $MarketLog


func get_timer() -> Timer : 
	return _timer


func _on_timer_timeout() -> void : 
	market_updated.emit()
