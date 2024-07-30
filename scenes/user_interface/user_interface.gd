class_name UserInterface
extends Control

static var ref : UserInterface

func _init() -> void :
	if not ref : ref = self 
	else : queue_free()


@onready var main_view : TabContainer = get_node("%MainView")


func change_view(i : int) -> Error :
	if i < 0 or i >= main_view.get_tab_count() : return FAILED
	
	main_view.current_tab = i 
	
	return OK
