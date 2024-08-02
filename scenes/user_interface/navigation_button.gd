extends LinkButton

@export var navigation_index : int = -1


func _ready() -> void :
	pressed.connect(_on_pressed)


func _on_pressed() -> void :
	UserInterface.ref.change_view(navigation_index)
