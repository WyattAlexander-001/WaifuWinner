extends Area2D

@export var damage = 1.0
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var disable_hitbox_timer: Timer = $disable_hitbox_timer

func tempdisable():
	collision.call_deferred("set", "disabled", true)
	disable_hitbox_timer.start()

func _on_disable_hitbox_timer_timeout() -> void:
	collision.call_deferred("set", "disabled", false)
