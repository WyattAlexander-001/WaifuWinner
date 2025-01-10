extends CharacterBody2D

var movement_speed = 500.0

func _physics_process(delta: float) -> void:
	movement()
	
func movement():
	#print('movement() called')
	var x_movement = Input.get_action_strength('right') - Input.get_action_strength('left')
	var y_movement = Input.get_action_strength('down') - Input.get_action_strength('up')
	var movement = Vector2(x_movement, y_movement)
	velocity = movement.normalized()*movement_speed
	move_and_slide()
	
	
