extends TextureProgressBar


func _process(_delta: float) -> void :
	value = GeneratorPlank.ref.get_progress()
