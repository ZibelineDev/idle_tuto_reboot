extends Button

const GENERATOR_ON_TEXT : String = "Generator : On"
const GENERATOR_OFF_TEXT : String = "Generator : Off"


func _ready() -> void :
	pressed.connect(_on_pressed)
	SilverGenerator.ref.generator_started.connect(_on_generator_started)
	SilverGenerator.ref.generator_stopped.connect(_on_generator_stopped)
	
	_update_text()


func _update_text() -> void :
	if SilverGenerator.ref.is_active() : text = GENERATOR_ON_TEXT
	else : text = GENERATOR_OFF_TEXT


func _on_pressed() -> void :
	SilverGenerator.ref.toggle()


func _on_generator_started() -> void :
	text = GENERATOR_ON_TEXT


func _on_generator_stopped() -> void :
	text = GENERATOR_OFF_TEXT
