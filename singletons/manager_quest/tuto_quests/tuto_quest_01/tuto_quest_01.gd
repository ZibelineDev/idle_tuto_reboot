class_name TutoQuest01
extends Node


signal completed


var _completion_cost : int = 250 


func get_button_text() -> String : 
	if is_completed() : return "Completed"
	return "Purchase\n%s : Silver" %_completion_cost


func get_description() -> String : 
	return "[center]There is an old lumbering camp no one is using.\
	\nThe owner is willing to let it go for a very cheap amount of Silver.[/center]"


func get_title() -> String :
	var text : String = "Acquiring the Old Lumbering Camp"
	
	if is_completed() : text += " (Completed)"
	
	return text


func is_completed() -> bool : 
	return Game.ref.data.progression.tuto_quest_01_completed


func purchase_completion() -> Error : 
	if is_completed() : return FAILED
	
	if ManagerSilver.ref.spend_silver(_completion_cost) != OK : return FAILED
	
	Game.ref.data.progression.tuto_quest_01_completed = true
	completed.emit()
	
	return OK 
