extends Button

const GENERATOR_ON_TEXT : String = "On"
const GENERATOR_OFF_TEXT : String = "Off"


func _ready() -> void :
	pressed.connect(_on_pressed)
	GeneratorSilver.ref.generator_started.connect(_on_generator_started)
	GeneratorSilver.ref.generator_stopped.connect(_on_generator_stopped)
	
	_update_text()


func _update_text() -> void :
	if GeneratorSilver.ref.is_active() : text = GENERATOR_ON_TEXT
	else : text = GENERATOR_OFF_TEXT


func _on_pressed() -> void :
	GeneratorSilver.ref.toggle()


func _on_generator_started() -> void :
	text = GENERATOR_ON_TEXT


func _on_generator_stopped() -> void :
	text = GENERATOR_OFF_TEXT
