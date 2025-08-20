extends Node

@export var default_level_scene: PackedScene
@export var player_scene: PackedScene
@export var camera: Camera2D

var current_level: Node
var player: CharacterBody2D

func _ready() -> void:
	# Instantiate default level.
	current_level = default_level_scene.instantiate()
	add_child(current_level)

	# Spawn the player.
	player = player_scene.instantiate()

	# Setup player specific variables
	player.interaction_square_sprite = $InteractionSquareSprite
	player.interaction_label = $InteractionSquareSprite/InteractionLabel

	add_child(player)

	# Spawn the player.
	var spawn_marker: Node2D = get_tree().get_first_node_in_group("spawn_marker")
	player.global_position = spawn_marker.global_position

	# Focus the camera on the player.
	camera.focus = player
	camera.global_position = player.global_position
