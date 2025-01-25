extends CharacterBody2D

const SPEED = 220.0
const DECELERATION = 130.0
const TURN_DECELERATION = 200.0

var target_velocity := Vector2.ZERO
@onready var magnet: CharacterBody2D = $"../Magnet"

func _physics_process(delta: float) -> void:
	var input_direction := Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)

	if input_direction.length() > 0:
		input_direction = input_direction.normalized()
		
		if velocity.length() > 0:
			target_velocity = input_direction * SPEED
			if velocity.dot(input_direction) < 0:
				velocity = velocity.move_toward(Vector2.ZERO, TURN_DECELERATION * delta)
		else:
			target_velocity = input_direction * SPEED
	else:
		var direction_to_magnet = magnet.position - position
		direction_to_magnet = direction_to_magnet.normalized()
		target_velocity = direction_to_magnet * SPEED
	
	velocity = velocity.move_toward(target_velocity, DECELERATION * delta)

	move_and_slide()
