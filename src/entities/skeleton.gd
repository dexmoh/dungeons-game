extends CharacterBody2D

@export var remains_tscn: PackedScene

func _on_health_component_died() -> void:
	await get_tree().create_timer(0.3).timeout

	if remains_tscn:
		var remains := remains_tscn.instantiate() as Node2D
		add_sibling(remains)

		remains.global_position = global_position.round()

	queue_free()
