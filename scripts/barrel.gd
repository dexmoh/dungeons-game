extends StaticBody2D

func _on_health_component_died() -> void:
	$Sprite2D.hide()
	collision_layer = 0
	collision_mask = 0

	# Rebake the navmesh after we remove the barrel.
	# This is awful, but lets leave it like this until it becomes a problem.
	var navmesh = get_tree().get_first_node_in_group("nav_region")
	if navmesh is NavigationRegion2D:
		navmesh.bake_navigation_polygon()

	var particles := $DestructionParticles as CPUParticles2D
	particles.emitting = true
	await particles.finished

	queue_free()
