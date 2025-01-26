extends Node2D


@onready var background1: Sprite2D = $Background1
@onready var background2: Sprite2D = $Background2
@onready var player = get_node("/root/Player")

var asteroid_timer : float = 0.0
var ufo_timer : float = 0.0
var cloud_timer : float = 0.0
var bubble_timer : float = 0.0

var interval_asteroids_spawning = 1.0
var interval_ufo_spawning = 10.0
var interval_cloud_spawning = 17.0
var interval_bubble_spawning = null

const ASTEROID_SCENE = preload("res:///scenes/asteroid.tscn")
const UFO_SCENE = preload("res://scenes/magnet_ufo.tscn")
const BLOWER_SCENE = preload("res://scenes/blower.tscn")
const BUBBLE_SCENE = preload("res://scenes/bubbles.tscn")
const SPAWN_AREA_SIZE = Vector2(1920, 1080)

@export var ufo_instance: Area2D
@export var blower_instance: Area2D
@export var health = 100

var background_speed = 200.0

@onready var my_label: Label = $Label
	
func _ready():
	if not background1 or not background2:
		print("Backgrounds not found or invalid!")
	else:
		print("Backgrounds found and ready.")

func _process(delta: float) -> void:
	my_label.text = "HEALTH: %d" % health
	asteroid_timer += delta
	ufo_timer += delta
	cloud_timer += delta
	bubble_timer += delta
	interval_bubble_spawning = randf_range(8.0, 20.0)
	
	if background1 and background2:
		move_backgrounds(delta)
	
	if asteroid_timer >= interval_asteroids_spawning:
		spawn_object(ASTEROID_SCENE, SPAWN_AREA_SIZE)
		asteroid_timer = 0.0
	if ufo_timer >= interval_ufo_spawning:
		spawn_object(UFO_SCENE, SPAWN_AREA_SIZE)
		ufo_timer = 0.0
	if cloud_timer >= interval_cloud_spawning:
		spawn_object(BLOWER_SCENE, SPAWN_AREA_SIZE)
		cloud_timer = 0.0
	if bubble_timer >= interval_bubble_spawning:
		spawn_object(BUBBLE_SCENE, SPAWN_AREA_SIZE)
		bubble_timer = 0.0
	
func move_backgrounds(delta: float) -> void:
	background1.position.x -= background_speed * delta
	background2.position.x -= background_speed * delta
	
	if background1.position.x <= -background1.texture.get_size().x:
		background1.position.x = background2.position.x + background2.texture.get_size().x
	
	if background2.position.x <= -background2.texture.get_size().x:
		background2.position.x = background1.position.x + background1.texture.get_size().x

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
