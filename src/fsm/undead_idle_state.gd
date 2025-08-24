# The undead will stand in place for a bit and ocassionally decide to wander
# around. While idling and wandering around the undead checks its surroundings
# for any enemy entities and attacks them.

extends State

@export var idle_time: float = 3.0
@export var anim_sprite: AnimatedSprite2D

func enter():
	anim_sprite.play("idle")
	
	var timer := Timer.new()
	timer.wait_time = idle_time

	add_child(timer)
	timer.start()

	timer.timeout.connect(
		func():
			if randi() % 2 == 0:
				timer.queue_free()
				state_machine.change_state("UndeadWanderState")
	)
