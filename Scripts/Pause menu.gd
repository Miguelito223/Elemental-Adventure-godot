extends CanvasLayer


func _on_save_pressed() -> void:
	var config = ConfigFile.new()
	config.load("user://config.cfg")
	config.save("user://config.cfg")


func _on_reset_player_pressed() -> void:
	get_tree().reload_current_scene()

func _on_return_pressed() -> void:
	visible = !visible


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")
