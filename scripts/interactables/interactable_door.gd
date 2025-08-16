extends Interactable

@export var is_open: bool = false

@onready var door_open_sprite: Sprite2D = $DoorOpenSprite
@onready var door_closed_sprite: Sprite2D = $DoorClosedSprite

func _ready() -> void:
	open_and_close()

func interact(_src: Node2D):
	open_and_close()
	
# Open, or close the door.
func open_and_close():
	if is_open:
		# Close the door.
		is_open = false
		door_closed_sprite.show()
		door_open_sprite.hide()
		label_text = "Open"
		set_collision_layer_value(1, true)
	else:
		# Open the door.
		is_open = true
		door_closed_sprite.hide()
		door_open_sprite.show()
		label_text = "Close"
		set_collision_layer_value(1, false)
