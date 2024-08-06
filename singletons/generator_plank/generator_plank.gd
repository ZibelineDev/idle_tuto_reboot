class_name GeneratorPlank
extends Generator


#region Singleton
static var ref : GeneratorPlank

func _init() -> void :
	if not ref : ref = self
	else : queue_free()
#endregion


signal generated_plank
signal generator_started
signal generator_stopped


var _log_consumption : int = 15
var _base_generated_plank_per_tick : Vector2i = Vector2i(2, 5)
var _generated_plank_per_tick : Vector2i

var _base_tick_duration : float = 30
var _tick_duration : float

@onready var _timer : Timer = $Timer

@onready var _settings : DataSettings = Game.ref.data.settings


func _ready() -> void :
	_timer.timeout.connect(_on_timer_timeout)
	_calculate_generated_plank_per_tick()
	_calculate_tick_duration()
	
	if _settings.generator_plank_is_active : 
		start()


func get_progress() -> float : 
	if not is_active() : return 0.0
	
	var progress : float = 1 - (_timer.time_left / _timer.wait_time)
	progress = progress * 100
	
	return progress


func is_active() -> bool :
	return not _timer.is_stopped()


func start() -> void : 
	if is_active() : return
	if ManagerGenerator.ref.start_generator(self) != OK : return
	
	_timer.start()
	_settings.generator_plank_is_active = true
	generator_started.emit()


func stop() -> void : 
	ManagerGenerator.ref.stop_generator(self)
	_timer.stop()
	_settings.generator_plank_is_active = false
	generator_stopped.emit()


func toggle() -> void : 
	if is_active() : stop()
	else : start()


func _calculate_generated_plank_per_tick() -> void :
	_generated_plank_per_tick = _base_generated_plank_per_tick


func _calculate_tick_duration() -> void : 
	_tick_duration = _base_tick_duration
	_timer.wait_time = _tick_duration


func _generate_plank() -> void : 
	if ManagerLog.ref.spend_log(_log_consumption) != OK : return 
	
	var roll : int = randi_range(_generated_plank_per_tick.x, _generated_plank_per_tick.y)
	
	ManagerPlank.ref.create_plank(roll)
	print("Plank Generated : %s" %roll)
	
	generated_plank.emit()


func _on_timer_timeout() -> void : 
	_generate_plank()
