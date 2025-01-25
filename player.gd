extends CharacterBody2D

const SPEED = 270.0
const DECELERATION = 75.0
const TURN_DECELERATION = 200.0

func _physics_process(delta: float) -> void:
	var input_direction := Vector2(
		Input.get_axis("ui_left", "ui_right"),
		Input.get_axis("ui_up", "ui_down")
	)

	if input_direction.length() > 0:
		input_direction = input_direction.normalized()

		if velocity.dot(input_direction) < 0:
			velocity = velocity.move_toward(Vector2.ZERO, TURN_DECELERATION * delta)
		else:
			velocity = input_direction * SPEED
	else:
		velocity = velocity.move_toward(Vector2.ZERO, DECELERATION * delta)

	move_and_slide()
