extends CanvasLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	match OS.get_name():
		"Android", "iOS":
			show()
		_:
			hide()
		
