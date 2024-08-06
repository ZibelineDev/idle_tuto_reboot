class_name ButtonCollapse
extends Button


@export var _target : Control 
@export var _open_by_default : bool = false


func _ready() -> void :
	pressed.connect(_on_pressed)
	text = "+"
	_target.visible = false
	
	if _open_by_default : _toggle_collapse()


func _on_pressed() -> void : 
	_toggle_collapse()


func _toggle_collapse() -> void : 
	if _target.visible :
		text = "+"
		_target.visible = false
	
	else : 
		text = "-"
		_target.visible = true
