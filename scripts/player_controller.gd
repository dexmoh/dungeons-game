extends CharacterBody2D

@export var movement_speed: float = 100

@onready var anim_sprite: AnimatedSprite2D = $AnimatedSprite

func _physics_process(_delta: float) -> void:
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	velocity = input_dir * movement_speed
	
	move_and_slide()
