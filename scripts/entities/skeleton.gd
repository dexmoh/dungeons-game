extends CharacterBody2D

@export var movement_speed: float = 80.0

var target: Node2D

@onready var nav_agent: NavigationAgent2D = $NavigationAgent2D
@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	target = get_tree().get_first_node_in_group("player")
	nav_agent.target_position = target.global_position

func _physics_process(_delta: float) -> void:
	if !nav_agent.is_target_reached():
		var nav_point_dir := to_local(nav_agent.get_next_path_position()).normalized()
		velocity = nav_point_dir * movement_speed
		
		anim_sprite.play("walk")

		if nav_point_dir.x > 0:
			anim_sprite.flip_h = false
		else:
			anim_sprite.flip_h = true

		move_and_slide()

func _on_timer_timeout() -> void:
	if target:
		nav_agent.target_position = target.global_position

func _on_navigation_finished() -> void:
	if target:
		nav_agent.target_position = target.global_position
		$Timer.start()
