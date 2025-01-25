extends Node2D

var timer : float = 0.0
var interval_asteroids_spawning = 1.0
const ASTEROID_SCENE = preload("res://asteroid.tscn")
const SPAWN_AREA_SIZE = Vector2(1920, 1080)
var asteroid_movement_direction = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized()

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	timer += delta
	if timer >= interval_asteroids_spawning:
		spawn_asteroid(ASTEROID_SCENE, SPAWN_AREA_SIZE)
		timer = 0.0	
	
func move_random_direction(object: CharacterBody2D, speed: float, direction: Vector2) -> void:
	object.velocity = direction * speed
	object.move_and_slide()

var asteroid_scene: PackedScene
var spawn_area_size: Vector2

func spawn_asteroid(scene: PackedScene, area_size: Vector2) -> void:
	var asteroid_instance = scene.instantiate() as CharacterBody2D
	
	var random_position = Vector2(
		randf() * area_size.x,
		randf() * area_size.y
	)

	asteroid_instance.position = random_position
	add_child(asteroid_instance)

	var asteroid_movement_direction = Vector2(randf() * 2 - 1, randf() * 2 - 1).normalized()
	asteroid_instance.velocity = asteroid_movement_direction * 150
