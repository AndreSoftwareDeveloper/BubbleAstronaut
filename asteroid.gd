extends Area2D

const SPEED = 300.0
var always_move_left := true

@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D

func _on_body_entered(body):
	print("body entered")
	if body.is_in_group("player"):
		queue_free()

func _physics_process(delta: float) -> void:
	position.x -= SPEED * delta
