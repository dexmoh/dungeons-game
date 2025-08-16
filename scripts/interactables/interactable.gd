class_name Interactable
extends CollisionObject2D

@export var label_text: String = "Interact"
@export var is_active: bool = true

# Called when the player is hovering over the object.
func on_focus(_src: Node2D):
	pass

# Called when the player tries to interact with the object.
func interact(_src: Node2D):
	pass
