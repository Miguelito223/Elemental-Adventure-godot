extends CanvasLayer

func _on_button_fire_pressed() -> void:
	GameController.character = "fire"
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")


func _on_button_water_pressed() -> void:
	GameController.character = "water"
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")


func _on_button_air_pressed() -> void:
	GameController.character = "air"
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")


func _on_button_earth_pressed() -> void:
	GameController.character = "earth"
	get_tree().change_scene_to_file("res://Scenes/level_1.tscn")
