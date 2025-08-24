extends ProgressBar

@export var health_component: HealthComponent

@onready var timer: Timer = $Timer

func _ready() -> void:
	if !health_component:
		push_warning("Warning: Health indicator wasn't given a health component to listen to!")
		queue_free()
		return
	
	hide()
	value = (float(health_component.current_health) / float(health_component.max_health)) * 100.0

	health_component.damaged.connect(on_damaged)
	timer.timeout.connect(on_timeout)

func on_damaged(_damage_received, current_health):
	value = (float(current_health) / float(health_component.max_health)) * 100.0
	timer.start()
	show()

func on_timeout():
	hide()
