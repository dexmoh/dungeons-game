# Health component used to manage entity's health and handle damage.

class_name  HealthComponent
extends Area2D

signal damaged(damage_received: int, current_health: int)
signal died

@export var max_health: int = 100
@export var invincible: bool = false

@export_group("Audio")
@export var audio_enabled: bool = true
@export var hit_sound_stream: AudioStream

@export_group("Flash")
@export var flash_enabled: bool = true
@export var flash_length: float = 0.3
@export var sprite: CanvasItem
@export var flash_color: Color = Color.RED

var is_dead: bool = false

@onready var current_health: int = max_health
@onready var hit_sound: AudioStreamPlayer2D = $HitSound
@onready var timer: Timer = $Timer

func _ready() -> void:
	monitoring = false

	timer.one_shot = true
	timer.wait_time = flash_length
	timer.timeout.connect(_on_timer_timeout)

	if !hit_sound_stream:
		audio_enabled = false
	else:
		hit_sound.stream = hit_sound_stream

	if !sprite:
		flash_enabled = false

func damage(amount: int) -> int:
	if is_dead:
		return current_health
	
	# Play hit sound.
	if audio_enabled:
		hit_sound.pitch_scale = randf_range(0.6, 1.4)
		hit_sound.play()

	# Flash the sprite, if there's a flash componnent connected.
	if flash_enabled:
		timer.start()
		sprite.modulate = flash_color

	if invincible:
		damaged.emit(0, current_health)
	else:
		current_health -= amount
		damaged.emit(amount, current_health)

	if current_health <= 0:
		is_dead = true
		died.emit()
	
	return current_health

func _on_timer_timeout():
	sprite.modulate = Color.WHITE
