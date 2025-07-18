extends Node

@onready var musicboss = $Musicboss
@onready var musiclevel = $MusicLevel
@onready var musicmainmenu = $MusicMainMenu

var last_scene_name = ""

func _process(delta: float) -> void:
	var scene = get_tree().current_scene
	if scene == null:
		return
	
	var current_scene_name = scene.name

	if current_scene_name != last_scene_name:
		last_scene_name = current_scene_name
		# Detener todo
		musicboss.stop()
		musiclevel.stop()
		musicmainmenu.stop()
		
		# Reproducir lo que toque
		if current_scene_name.begins_with("level_"):
			musiclevel.play()
		elif current_scene_name == "Chose_Character" or current_scene_name == "Main Menu":
			musicmainmenu.play()
