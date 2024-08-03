class_name SilverGenerator
extends Node

static var ref : SilverGenerator

func _init() -> void :
	if not ref : ref = self
	else : queue_free()


signal generated_silver
signal generator_started
signal generator_stopped


var _base_generated_silver_per_tick : Vector2i = Vector2i(10, 25)
var _generated_silver_per_tick : Vector2i
var _tick_duration : float = 2.5

@onready var _timer : Timer = get_node("Timer")
@onready var _upgrade_01 : SilverGeneratorUpgrade01 = get_node("Upgrade01")


func _ready() -> void :
	_timer.wait_time = _tick_duration
	_timer.timeout.connect(_on_timer_timeout)
	_upgrade_01.leveled_up.connect(_on_upgrade_01_leveled_up)
	_calculate_generated_silver_per_tick()


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


func get_upgrade_01() -> SilverGeneratorUpgrade01 : 
	return _upgrade_01


func _generate_silver() -> void :
	var roll : int = randi_range(_generated_silver_per_tick.x, _generated_silver_per_tick.y)
	
	ManagerSilver.ref.create_silver(roll)
	print("Silver Generated : %s" %roll)
	
	generated_silver.emit()


func _calculate_generated_silver_per_tick() -> void : 
	_generated_silver_per_tick = _base_generated_silver_per_tick + _upgrade_01.get_bonus()


func _on_timer_timeout() -> void :
	_generate_silver()


func _on_upgrade_01_leveled_up() -> void : 
	_calculate_generated_silver_per_tick()
