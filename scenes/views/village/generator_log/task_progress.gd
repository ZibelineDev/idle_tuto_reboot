extends TextureProgressBar


func _process(_delta: float) -> void :
	value = GeneratorLog.ref.get_progress()
