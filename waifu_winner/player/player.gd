extends CharacterBody2D

@export var movement_speed = 100.0
@export var hp = 100
@onready var sprite: Sprite2D = $Sprite2D
@onready var walk_timer: Timer = $walk_timer

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
