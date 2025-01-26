extends Area2D


@onready var sound_player: AudioStreamPlayer = $SoundPlayer
@onready var main_script = get_node("/root/Main")

const SPEED = 200.0

func _physics_process(delta: float) -> void:
	position.x -= SPEED * delta

# When the player collides with the bubble
func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):  # Check if it's the player
		sound_player.play()  # Play sound effect (optional)
		main_script.health += 10;
		queue_free()  # Remove the bubble from the scene
