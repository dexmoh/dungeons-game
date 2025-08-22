class_name  HealthComponent
extends Area2D

signal damaged(damage_received: int, current_health: int)
signal died

@export var max_health: int = 100
@export var invincible: bool = false

@export_group("Flash")
@export var flash_enabled: bool = true
@export var flash_length: float = 0.3
@export var sprite: CanvasItem
@export var flash_color: Color = Color(1, 0, 0, 1)

var is_dead: bool = false

@onready var current_health: int = max_health
@onready var timer: Timer = $Timer

func _ready() -> void:
	monitoring = false

	timer.one_shot = true
	timer.wait_time = flash_length
	timer.timeout.connect(_on_timer_timeout)

	if !sprite:
		flash_enabled = false

func damage(amount: int) -> int:
	if is_dead:
		return current_health
	
	# Flash the sprite, if there's a flash componnent connected.
	if flash_enabled:
		timer.start()
		sprite.modulate = flash_color

	if invincible:
		damaged.emit(0, current_health)
	
	current_health -= amount
	damaged.emit(amount, current_health)

	if current_health <= 0:
		is_dead = true
		died.emit()
	
	return current_health

func _on_timer_timeout():
	sprite.modulate = Color(1, 1, 1, 1)
