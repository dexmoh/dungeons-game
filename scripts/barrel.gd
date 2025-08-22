extends StaticBody2D

@onready var hit_sound: AudioStreamPlayer2D = $HitSound

func _on_health_component_damaged(_damage_received: int, _current_health: int) -> void:
	hit_sound.pitch_scale = randf_range(0.6, 1.4)
	hit_sound.play()

func _on_health_component_died() -> void:
	$Sprite2D.hide()
	collision_layer = 0
	collision_mask = 0

	var particles := $DestructionParticles as CPUParticles2D
	particles.emitting = true
	await particles.finished

	queue_free()
