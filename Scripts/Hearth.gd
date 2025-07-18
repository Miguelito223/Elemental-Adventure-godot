extends RigidBody2D

var rng = RandomNumberGenerator.new()
var collected = false

func _on_area_2d_body_entered(body:Node2D):
	if body.is_in_group("player"):
		GameController.get
	
