class_name LabelPlank
extends HBoxContainer


func _ready() -> void :
	_uptade_text()
	ManagerPlank.ref.plank_updated.connect(_on_plank_updated)


func _uptade_text() -> void : 
	(%Label as Label).text = "Planks : %s"\
			%StringFormat.thousands_sep(ManagerPlank.ref.get_plank())


func _on_plank_updated() -> void : 
	_uptade_text()
