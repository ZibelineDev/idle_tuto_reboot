class_name ManagerQuest
extends Node


#region Singleton
static var ref : ManagerQuest

func _init() -> void :
	if not ref : ref = self
	else : queue_free()
#endregion


func get_tuto_quest_01() -> TutoQuest01 : 
	return $TutoQuest01


func get_tuto_quest_02() -> TutoQuest02 : 
	return $TutoQuest02
