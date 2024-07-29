class_name SilverGenerator
extends Node

static var ref : SilverGenerator

func _init() -> void :
	if not ref : ref = self
	else : queue_free()


signal generated_silver
signal generator_started
signal generator_stopped


var _generated_silver_per_tick : int = 1
var _tick_duration : float = 1.0

@onready var _timer : Timer = get_node("Timer")


func _ready() -> void :
	_timer.wait_time = _tick_duration
	_timer.timeout.connect(_on_timer_timeout)


func start() -> void : 
	_timer.start()
	generator_started.emit()


func stop() -> void : 
	_timer.stop()
	generator_stopped.emit()


func is_active() -> bool :
	return not _timer.is_stopped()


func toggle() -> void : 
	if is_active() : stop()
	else : start()


func _generate_silver() -> void :
	ManagerSilver.ref.create_silver(_generated_silver_per_tick)
	
	generated_silver.emit()


func _on_timer_timeout() -> void :
	_generate_silver()
