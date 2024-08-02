extends PanelContainer


@onready var _collapse_container : Control = get_node("%CollapseContainer")
@onready var _collapse_button : Button = get_node("%CollapseButton")


func _ready() -> void :
	_collapse_button.pressed.connect(_on_collapse_button_pressed)
	
	_collapse_button.text = "+"
	_collapse_container.visible = false


func _on_collapse_button_pressed() -> void :
	_toggle_collapse()


func _toggle_collapse() -> void : 
	if _collapse_container.visible :
		_collapse_button.text = "+"
		_collapse_container.visible = false
	
	else : 
		_collapse_button.text = "-"
		_collapse_container.visible = true
