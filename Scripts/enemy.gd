extends CharacterBody2D

var health = 10
var damagecount = 0

@export var move_speed := 50
@export var direction = Vector2.LEFT

@onready var animator = $AnimatedSprite2D
@onready var left_floor_check = $left_floor
@onready var left_wall_check = $left_wall

@onready var right_floor_check = $right_floor
@onready var right_wall_check = $right_wall

func  _physics_process(delta: float) -> void:
	# Movimiento horizontal
	velocity.x = direction.x * move_speed
	
	# Gravedad
	if not is_on_floor():
		velocity.y += 400 * delta
	else:
		velocity.y = 0
	
	print("Left floor: ", left_floor_check.is_colliding(), " | Right floor: ", right_floor_check.is_colliding())
	print("Left wall: ", left_wall_check.is_colliding(), " | Right wall: ", right_wall_check.is_colliding())

	# Si el raycast no detecta suelo → girar
	# Detectar borde o pared para girar
	if (not left_floor_check.is_colliding() or left_wall_check.is_colliding()):
		flip_direction()
	elif (not right_floor_check.is_colliding() or right_wall_check.is_colliding()):
		flip_direction()
	
	move_and_slide()
	
func flip_direction():
	direction *= -1
	scale.x *= -1

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
