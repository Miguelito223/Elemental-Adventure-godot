extends CharacterBody2D

var health = 10
var damagecount = 0

func damage(damage):
	health -= damage
	
	if health <= 0:
		kill()
	
func kill():
	queue_free()

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("bullet"):
		damage( damagecount )


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		damage( damagecount )
