class_name MarketLog
extends Node


@onready var _silver_value : Vector2i = ManagerLog.ref.get_value()

@onready var _data : DataMarket = Game.ref.data.market


func _ready() -> void :
	_load_data()
	ManagerMarket.ref.get_timer().timeout.connect(_on_market_timer_timeout)


func get_value() -> int :
	return _data.log_value


func get_description() -> String : 
	return "Value Range (%s - %s)" %[_silver_value.x, _silver_value.y]


func _load_data() -> void : 
	if _data.log_value == -1 : 
		var roll : int = randi_range(_silver_value.x, _silver_value.y)
		_data.log_value = roll


func _fluctuate() -> void : 
	var roll : int = randi_range(0, 1)
	if roll : _increase_value()
	else : _decrease_value()


func _increase_value() -> void :
	var fluctuation : int = int(_data.log_value * 0.05)
	
	if fluctuation < 1 : fluctuation = 1
	
	var new_value : int = _data.log_value + fluctuation
	
	if new_value >= _silver_value.y : new_value = _silver_value.y
	
	_data.log_value = new_value


func _decrease_value() -> void : 
	var fluctuation : int = int(_data.log_value * 0.05)
	
	if fluctuation < 1 : fluctuation = 1
	
	var new_value : int = _data.log_value - fluctuation
	
	if new_value <= _silver_value.x : new_value = _silver_value.x
	
	_data.log_value = new_value


func _on_market_timer_timeout() -> void : 
	_fluctuate()
