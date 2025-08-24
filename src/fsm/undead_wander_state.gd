extends State

@export var wander_movement_speed: float = 128.0
@export var wander_radius: float = 200.0
@export var char_body: CharacterBody2D
@export var nav_agent: NavigationAgent2D
@export var anim_sprite: AnimatedSprite2D

func enter():
	# Pick a random, valid location to wander towards.
	var target = char_body.global_position

	for i in range(10):
		var rand_offset := Vector2(
			randf_range(-wander_radius, wander_radius),
			randf_range(-wander_radius, wander_radius)
		)

		var tmp_target = NavigationServer2D.map_get_closest_point(
			nav_agent.get_navigation_map(),
			char_body.global_position + rand_offset
		)

		if tmp_target and tmp_target != Vector2.INF:
			target = tmp_target
			break
	
	nav_agent.target_position = target

	if !nav_agent.is_target_reachable():
		state_machine.change_state("UndeadIdleState")

func physics_update(_delta):
	if nav_agent.is_target_reached():
		state_machine.change_state("UndeadIdleState")
		return

	var nav_point_dir := char_body.to_local(nav_agent.get_next_path_position()).normalized()
	char_body.velocity = nav_point_dir * wander_movement_speed
	
	anim_sprite.play("walk")

	if nav_point_dir.x > 0:
		anim_sprite.flip_h = false
	else:
		anim_sprite.flip_h = true

	char_body.move_and_slide()
