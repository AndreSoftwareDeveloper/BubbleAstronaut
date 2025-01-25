extends Node2D

var timer : float = 0.0
var interval_asteroids_spawning = 1.0
const ASTEROID_SCENE = preload("res://asteroid.tscn")
const UFO_SCENE = preload("res://magnet_ufo.tscn")
const BLOWER_SCENE = preload("res://blower.tscn")
const SPAWN_AREA_SIZE = Vector2(1920, 1080)

@export var ufo_instance: Area2D
@export var blower_instance: Area2D

func _process(delta: float) -> void:
	timer += delta
	if timer >= interval_asteroids_spawning:
		spawn_object(ASTEROID_SCENE, SPAWN_AREA_SIZE)
		spawn_object(UFO_SCENE, SPAWN_AREA_SIZE)
		spawn_object(BLOWER_SCENE, SPAWN_AREA_SIZE)
		timer = 0.0
	
func move_random_direction(object: CharacterBody2D, speed: float, direction: Vector2) -> void:
	object.velocity = direction * speed
	object.move_and_slide()

var asteroid_scene: PackedScene
var spawn_area_size: Vector2

func spawn_object(scene: PackedScene, area_size: Vector2) -> void:
	var object_instance = scene.instantiate() as Area2D
	
	var random_position = Vector2(
		area_size.x,
		randf() * area_size.y
	)

	object_instance.position = random_position
	add_child(object_instance)
	
	if scene == UFO_SCENE:
		ufo_instance = object_instance
	if scene == BLOWER_SCENE:
		blower_instance = object_instance
