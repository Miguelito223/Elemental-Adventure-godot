extends Node2D

@onready var destrolledeearth = $ParallaxBackground
@onready var lava = $ParallaxBackground2
@onready var desert = $ParallaxBackground3

func _process(delta: float) -> void:
	if GameController.level > 1:
		lava.visible = false
		desert.visible = false
		destrolledeearth.visible = true
	else: 
		lava.visible = false
		desert.visible = false
		destrolledeearth.visible = false
