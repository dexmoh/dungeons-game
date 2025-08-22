extends Node2D

@onready var weapon_sprite: Sprite2D = $Pivot/Sprite
@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var hitbox: Area2D = $Pivot/Sprite/HitBox
@onready var swing_sound_1: AudioStreamPlayer2D = $Pivot/Sprite/SwingSound1
@onready var swing_sound_2: AudioStreamPlayer2D = $Pivot/Sprite/SwingSound2

func _ready() -> void:
	weapon_sprite.hide()
	hitbox.monitoring = false

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("attack") and anim_player.current_animation != "attack":
		look_at(get_global_mouse_position())
		weapon_sprite.show()
		hitbox.monitoring = true
		anim_player.play("attack")

		# We play the swing sound.
		var next_sound: AudioStreamPlayer2D = [swing_sound_1, swing_sound_2].pick_random()
		next_sound.pitch_scale = randf_range(0.6, 1.4)
		next_sound.play()

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "attack":
		weapon_sprite.hide()
		hitbox.monitoring = false

func _on_hit_box_area_entered(area: Area2D) -> void:
	if area is HealthComponent:
		area.damage(randi_range(10, 40))
