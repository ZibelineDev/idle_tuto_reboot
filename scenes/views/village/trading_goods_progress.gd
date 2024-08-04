extends TextureProgressBar


func _process(_delta: float) -> void :
	value = GeneratorSilver.ref.get_progress()
