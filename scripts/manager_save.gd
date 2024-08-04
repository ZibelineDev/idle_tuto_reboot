class_name ManagerSave

const SAVE_PATH : String = "user://save.tres"

static func save_data() -> void : 
	ResourceSaver.save(Game.ref.data, SAVE_PATH)


static func load_data() -> void : 
	if not ResourceLoader.exists(SAVE_PATH) : return
	Game.ref.data = load(SAVE_PATH)
