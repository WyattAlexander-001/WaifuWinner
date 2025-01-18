extends CharacterBody2D

@export var movement_speed = 100.0
@export var hp = 100
@onready var sprite: Sprite2D = $Sprite2D
@onready var walk_timer: Timer = $walk_timer

# Attacks
var ice_spear = preload("res://player/attack/ice_spear.tscn")

# Attack Nodes:
@onready var ice_spear_timer = get_node("%IceSpearTimer")
@onready var ice_spear_attack_timer = get_node("%IceSpearAttackTimer")

# IceSpear
var ice_spear_ammo = 0
var ice_spear_base_ammo = 3
var ice_spear_attack_speed = 1.5
var ice_spear_level = 1

# Enemy Related
var enemy_close = []


func _ready():
	attack()

func _physics_process(delta: float) -> void:
	movement()
	
func movement():
	#print('movement() called')
	var x_movement = Input.get_action_strength('right') - Input.get_action_strength('left')
	var y_movement = Input.get_action_strength('down') - Input.get_action_strength('up')
	var movement = Vector2(x_movement, y_movement)
	
	# flip player orientation
	if movement.x > 0:
		sprite.flip_h = true
	elif movement.x < 0:
		sprite.flip_h = false
	
	if movement != Vector2.ZERO:
		if walk_timer.is_stopped():
			if sprite.frame >= sprite.hframes -1:
				sprite.frame = 0
			else:
				sprite.frame += 1
			walk_timer.start()
	velocity = movement.normalized()*movement_speed
	move_and_slide()
	
	
	
func _on_hurt_box_hurt(damage: Variant) -> void:
	hp -= damage
	print("Player HP Current Value: " + str(hp))
	
func attack():
	if ice_spear_level > 0:
		ice_spear_timer.wait_time = ice_spear_attack_speed
		if ice_spear_timer.is_stopped():
			ice_spear_timer.start()

func _on_ice_spear_timer_timeout() -> void:
	ice_spear_ammo += ice_spear_base_ammo
	ice_spear_attack_timer.start()

func _on_ice_spear_attack_timer_timeout() -> void:
	if ice_spear_ammo > 0:
		var ice_spear_attack = ice_spear.instantiate()
		ice_spear_attack.position = position
		ice_spear_attack.target = get_random_target()
		ice_spear_attack.level = ice_spear_level
		add_child(ice_spear_attack)
		ice_spear_ammo -= 1
		if ice_spear_ammo > 0:
			ice_spear_attack_timer.start()
		else:
			ice_spear_attack_timer.stop()
		
func get_random_target():
	if enemy_close.size() > 0:
		return enemy_close.pick_random().global_position
	else:
		return Vector2.UP


func _on_enemy_detection_area_body_entered(body: Node2D) -> void:
	if not enemy_close.has(body):
		enemy_close.append(body)


func _on_enemy_detection_area_body_exited(body: Node2D) -> void:
	if enemy_close.has(body):
		enemy_close.erase(body)
