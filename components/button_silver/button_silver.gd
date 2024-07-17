extends Button


@export var silver_to_create : int = 10


func _ready() -> void :
	pressed.connect(_on_pressed)
	text = "Create %s Silver" %silver_to_create


func _on_pressed() -> void : 
	ManagerSilver.ref.create_silver(silver_to_create)
