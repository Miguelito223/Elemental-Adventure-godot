extends CharacterBody2D

var health = 3
var speed = 200  # Velocidad horizontal
var jump_force = -400  # Fuerza del salto (valor negativo porque hacia arriba)
var gravity = 900  # Valor positivo, gravedad hacia abajo

var shoot_cooldown = 1.0  # Tiempo entre disparos (en segundos)
var shoot_timer = 0.0     # Contador de tiempo

var damagecount = 1     # Contador de tiempo


@onready var animator = $AnimatedSprite2D
@onready var bulletspawn = $bulletpos/bulletspawn
@onready var bulletpos = $bulletpos
@onready var bulletscene = preload("res://Scenes/bullet.tscn")

@onready var walksounds = $WalkSounds
@onready var shootsounds = $ShootSounds
@onready var jumpsounds = $JumpSounds

@onready var pausemenu = $"Pause menu"

@onready var light = $PointLight2D
@onready var lifes = $Hud/Lifes/Label
@onready var energys = $Hud/Energys/Label
@onready var points = $Hud/Points/Label

func _ready() -> void:
	if GameController.character == "fire":
		light.color = Color.ORANGE
	elif GameController.character == "water":
		light.color = Color.WHITE
	elif GameController.character == "air":
		light.color = Color.WHITE
	elif GameController.character == "earth":
		light.color = Color.WHITE
	
func _process(delta: float) -> void:
	lifes.text = "Lifes: " + str(health)
	energys.text = "Energys: " + str(GameController.energys)
	points.text = "Points: " + str(GameController.points)

func _physics_process(delta):
	# Aplicar gravedad
	velocity.y += gravity * delta

	# Movimiento lateral
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down").x
	velocity.x = direction * speed

	# Voltear sprite
	animator.flip_h = direction < 0
	
	if direction != 0 and is_on_floor():
		if !walksounds.playing:
			walksounds.play()
	else:
		if walksounds.playing:
			walksounds.stop()

	# Saltar (solo si está en el suelo)
	if Input.is_key_pressed(KEY_SPACE) and is_on_floor():
		velocity.y = jump_force
		jumpsounds.play()
		
	shoot_timer -= delta  # Reducir el tiempo restante
	
	var mouse_pos = get_global_mouse_position()
	var direction_to_mouse = (mouse_pos - global_position).normalized()
	var radius = 20.0  # puedes ajustar esto a tu gusto
	bulletpos.global_position = global_position + direction_to_mouse * radius
	bulletpos.look_at(mouse_pos)

	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and shoot_timer <= 0:
		shoot(direction_to_mouse)
		shoot_timer = shoot_cooldown  # Reiniciar el tiempo entre disparos




	# ANIMACIONES según estado
	if !is_on_floor():
		if velocity.y < 0:
			animator.play("%s jump" % [GameController.character])  # Subiendo
		else:
			animator.play("%s fall" % [GameController.character])  # Bajando
	elif direction != 0:
		animator.play("%s walk" % [GameController.character])     # Caminando en suelo
	else:
		animator.play("%s idle" % [GameController.character])     # Quieto en suelo

	move_and_slide()

# Función para recibir daño
func damage(damage):
	health -= damage
	
	if health <= 0:
		game_over()
		
func healting(count):
	health += count
		
func shoot(direction):
	shootsounds.play()
	
	var bullet = bulletscene.instantiate()
	bullet.global_position = bulletspawn.global_position
	bullet.direction = direction
	
	
	if GameController.character == "fire":
		bullet.modulate = Color.ORANGE
		bullet.get_node("PointLight2D").enabled = true
		bullet.get_node("PointLight2D").color = Color.ORANGE
	elif GameController.character == "water":
		bullet.modulate = Color.BLUE
		bullet.get_node("PointLight2D").enabled = false
	elif GameController.character == "air":
		bullet.modulate = Color.DIM_GRAY
		bullet.get_node("PointLight2D").enabled = false
	elif GameController.character == "earth":
		bullet.modulate = Color.SADDLE_BROWN
		bullet.get_node("PointLight2D").enabled = false
		
		
	
	get_parent().add_child(bullet)
	
func game_over():
	get_tree().reload_current_scene()

func _on_texture_button_pressed() -> void:
	pausemenu.visible = !pausemenu.visible
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("bullet"):
		damage(damagecount)
	

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		damage(damagecount)
	elif body.is_in_group("water"):
		damage(3)
