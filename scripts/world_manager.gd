extends Node2D

@export var player_scene: PackedScene
@export var camera: Camera2D

var player: CharacterBody2D

func _ready() -> void:
	# Spawn the player.
	player = player_scene.instantiate()

	# Setup player specific variables
	player.interaction_square_sprite = $InteractionSquareSprite
	player.interaction_label = $InteractionSquareSprite/InteractionLabel

	add_child(player)

	# Focus the camera on the player.
	camera.focus = player
