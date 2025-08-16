extends CharacterBody2D

@export var movement_speed: float = 100
@export var interaction_distance_radius: float = 32

var interaction_point_query: PhysicsPointQueryParameters2D
var tile_size: Vector2
var interaction_square_sprite: Sprite2D
var interaction_label: Label

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite

func _ready() -> void:
	interaction_point_query = PhysicsPointQueryParameters2D.new()
	interaction_point_query.collide_with_areas = true
	interaction_point_query.collide_with_bodies = true
	interaction_point_query.collision_mask = 0b10

	tile_size = ProjectSettings.get_setting("global/tile_size")

func _physics_process(_delta: float) -> void:
	# Move player.
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	velocity = input_dir * movement_speed
	
	# Animate directional player movement.
	if input_dir == Vector2.ZERO:
		if anim_sprite.animation.begins_with("walk"):
			# Idle animation.
			var anim_dir = anim_sprite.animation.split("_")[1]
			anim_sprite.play("idle_" + anim_dir)
	else:
		# Movement animation.
		if abs(input_dir.x) > abs(input_dir.y):
			if input_dir.x > 0:
				anim_sprite.flip_h = false
				anim_sprite.play("walk_side")
			else:
				anim_sprite.flip_h = true
				anim_sprite.play("walk_side")
		else:
			if input_dir.y > 0:
				anim_sprite.play("walk_down")
			else:
				anim_sprite.play("walk_up")

	# Interactions.
	var mouse_pos: Vector2 = get_global_mouse_position()
	var distance_to_mouse: float = global_position.distance_to(mouse_pos)

	interaction_square_sprite.hide()

	# Check for interactions.
	if distance_to_mouse <= interaction_distance_radius:
		var space_state = get_world_2d().direct_space_state
		interaction_point_query.position = mouse_pos
		var results = space_state.intersect_point(interaction_point_query)

		for result in results:
			if result.collider is Interactable and result.collider.is_active:
				interaction_square_sprite.global_position = (mouse_pos / tile_size).floor() * tile_size
				interaction_square_sprite.show()
				result.collider.on_focus(self)
				interaction_label.text = "[E] " + result.collider.label_text

				if Input.is_action_just_pressed("interact"):
					result.collider.interact(self)
				break

	move_and_slide()
