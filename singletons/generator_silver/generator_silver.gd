class_name GeneratorSilver
extends Generator

static var ref : GeneratorSilver

func _init() -> void :
	if not ref : ref = self
	else : queue_free()


signal generated_silver
signal generator_started
signal generator_stopped


var _base_generated_silver_per_tick : Vector2i = Vector2i(10, 25)
var _generated_silver_per_tick : Vector2i

var _base_tick_duration : float = 2.5
var _tick_duration : float

@onready var _timer : Timer = get_node("Timer")
@onready var _upgrade_01 : GeneratorSilverUpgrade01 = $Upgrade01
@onready var _upgrade_02 : GeneratorSilverUpgrade02 = $Upgrade02

@onready var _settings : DataSettings = Game.ref.data.settings


func _ready() -> void :
	_timer.timeout.connect(_on_timer_timeout)
	_upgrade_01.leveled_up.connect(_on_upgrade_01_leveled_up)
	_upgrade_02.leveled_up.connect(_on_upgrade_02_leveled_up)
	_calculate_generated_silver_per_tick()
	_calculate_tick_duration()
	
	if _settings.generator_silver_is_active : 
		start()


func start() -> void : 
	if is_active() : return
	if ManagerGenerator.ref.start_generator(self) != OK : return
	
	_timer.start()
	_settings.generator_silver_is_active = true
	generator_started.emit()


func stop() -> void : 
	ManagerGenerator.ref.stop_generator(self)
	_timer.stop()
	_settings.generator_silver_is_active = false
	generator_stopped.emit()


func is_active() -> bool :
	return not _timer.is_stopped()


func toggle() -> void : 
	if is_active() : stop()
	else : start()


func get_upgrade_01() -> GeneratorSilverUpgrade01 : 
	return _upgrade_01


func get_upgrade_02() -> GeneratorSilverUpgrade02 : 
	return _upgrade_02


func get_progress() -> float : 
	if not is_active() : return 0
	
	var progress : float = 1 - (_timer.time_left / _timer.wait_time)
	progress = progress * 100
	
	return progress


func _generate_silver() -> void :
	var roll : int = randi_range(_generated_silver_per_tick.x, _generated_silver_per_tick.y)
	
	ManagerSilver.ref.create_silver(roll)
	ManagerSkill.ref.add_experience(ManagerSkill.Skills.TRADING, 3)
	
	print("+%s Silver" %roll)
	
	generated_silver.emit()


func _calculate_generated_silver_per_tick() -> void : 
	_generated_silver_per_tick = _base_generated_silver_per_tick 
	_generated_silver_per_tick += _upgrade_01.get_bonus()
	_generated_silver_per_tick *= (1 + ManagerSkill.ref.get_bonus(ManagerSkill.Skills.TRADING))


func _calculate_tick_duration() -> void :
	_tick_duration = _base_tick_duration
	_tick_duration += _upgrade_02.get_bonus()
	_timer.wait_time = _tick_duration


func _on_timer_timeout() -> void :
	_generate_silver()


func _on_upgrade_01_leveled_up() -> void : 
	_calculate_generated_silver_per_tick()


func _on_upgrade_02_leveled_up() -> void :
	_calculate_tick_duration()
