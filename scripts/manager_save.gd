class_name ManagerSave


const SAVE_PATH : String = "user://save.tres"
const SHOULD_SAVE : bool = true
const SHOULD_LOAD : bool = true


static func save_data() -> void : 
	if not SHOULD_SAVE : return
	ResourceSaver.save(Game.ref.data, SAVE_PATH)


static func load_data() -> void : 
	if not SHOULD_LOAD : return
	if not ResourceLoader.exists(SAVE_PATH) : return
	Game.ref.data = load(SAVE_PATH)
