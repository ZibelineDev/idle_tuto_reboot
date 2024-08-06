@tool
class_name LinkNavigation
extends HBoxContainer


@export var link_text : String 
@export var texture : Texture2D
@export var tab_id : int 


func _ready() -> void :
	($TextureRect as TextureRect).texture = texture
	($LinkButton as LinkButton).text = link_text
	($LinkButton as LinkButton).pressed.connect(_on_link_button_pressed)


func _on_link_button_pressed() -> void : 
	UserInterface.ref.change_view(tab_id)
