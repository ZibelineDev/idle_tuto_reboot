class_name AdvancedTimer
extends Node


signal timeout

@export var autostart : bool = false
@export var oneshot : bool = false
@export var speed : float = 1.0

@export var wait_time : float = 1.0:
	set(value):
		var should_restart : bool = false
		if not _is_stopped:
			should_restart = true
		stop()
		wait_time = value
		if should_restart:
			start()

var _is_stopped :bool = true:
	set(value):
		pass

var time_left : float


var paused : bool = false
var _excess : float = 0.0


func _ready() -> void:
	if autostart:
		start()


func _process(delta: float) -> void:
	if is_stopped or paused:
		return
	
	var elapsed_time : float  = delta * speed
	
	if elapsed_time > time_left:
		_excess += elapsed_time - time_left
		time_left = 0.0
	
	else:
		time_left -= elapsed_time
	
	if time_left == 0.0:
		_timeout()


func start() -> void:
	time_left = wait_time
	_is_stopped =false


func stop() -> void:
	_is_stopped = true


func is_stopped() -> bool:
	return _is_stopped


func _timeout() -> void:
	timeout.emit()
	_excess_dump()


func _excess_dump() -> void:
	time_left = wait_time
	
	while _excess > time_left:
		_excess -= time_left
		timeout.emit()
		time_left = wait_time
	
	time_left -= _excess
	_excess = 0
	
	if oneshot:
		stop()


func generate_access(time : float) -> void:
	_excess += time
	_excess_dump()
