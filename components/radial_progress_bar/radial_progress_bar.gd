extends TextureProgressBar


func _process(_delta: float) -> void :
	value = SilverGenerator.ref.get_timer_progression()
