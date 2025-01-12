extends CharacterBody2D

var enemyName = "Kobold"
@export var movement_speed = 20.0
@export var hp = 10.0
@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Go find the player node in the scene
@onready var player = get_tree().get_first_node_in_group("player")

func _ready():
	animation_player.play("walk")

func _physics_process(_delta):
	move_to_player()

	
func move_to_player():
		# Get direction of player and move towards them
	var direction = global_position.direction_to(player.global_position)
	velocity = direction * movement_speed
	move_and_slide()
	
	if direction.x > 0.1:
		sprite.flip_h = true
	elif direction.x < -0.1:
		sprite.flip_h = false


func _on_hurt_box_hurt(damage: Variant) -> void:
	hp -= damage
	print(enemyName + " Current Value: " + str(hp))
	if hp <= 0:
		queue_free()
	
