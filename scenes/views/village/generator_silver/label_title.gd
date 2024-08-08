extends Label


func _ready() -> void :
	_update_text()
	ManagerSkill.ref.leveled_up.connect(_on_skill_leveled_up)


func _update_text() -> void : 
	text = "Trading Common Goods [%s]" %ManagerSkill.ref.get_level(ManagerSkill.Skills.TRADING)


func _on_skill_leveled_up(skill : ManagerSkill.Skills) -> void : 
	if skill == ManagerSkill.Skills.TRADING : _update_text()
