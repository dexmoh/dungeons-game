extends Interactable

@export var is_open: bool = false
@export var door_sprite: Sprite2D

@onready var open_sfx: AudioStreamPlayer2D = $DoorOpenAudio
@onready var close_sfx: AudioStreamPlayer2D = $DoorCloseAudio
@onready var vertical_nav_link: NavigationLink2D = $VerticalNavLink
@onready var horizontal_nav_link: NavigationLink2D = $HorizontalNavLink

func _ready() -> void:
	label_text = "Open"

	if is_open:
		# Open the door.
		door_sprite.region_rect.position.x += Globals.tile_size.x
		label_text = "Close"
		set_collision_layer_value(1, false)
	
	horizontal_nav_link.enabled = is_open
	vertical_nav_link.enabled = is_open

func interact(_src: Node2D):
	open_and_close()
	
# Open, or close the door.
func open_and_close():
	if is_open:
		# Close the door.
		is_open = false
		door_sprite.region_rect.position.x -= Globals.tile_size.x
		label_text = "Open"
		close_sfx.play()
		set_collision_layer_value(1, true)
	else:
		# Open the door.
		is_open = true
		door_sprite.region_rect.position.x += Globals.tile_size.x
		label_text = "Close"
		open_sfx.play()
		set_collision_layer_value(1, false)
	
	horizontal_nav_link.enabled = is_open
	vertical_nav_link.enabled = is_open
