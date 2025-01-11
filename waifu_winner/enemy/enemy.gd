extends CharacterBody2D

@export var movement_speed = 20.0

# Go find the player node in the scene
@onready var player = get_tree().get_first_node_in_group("player")

func _physics_process(_delta):
	move_to_player()

	
func move_to_player():
		# Get direction of player and move towards them
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * movement_speed
	move_and_slide()
