class_name StateMachine
extends Node

@export var initial_state: State

var current_state: State
var states: Dictionary[String, State] = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
	
	if initial_state:
		current_state = initial_state
		current_state.enter()
	else:
		push_warning("Warning: State machine doesn't have a defined initial state.")

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func change_state(new_state_name: String):
	if current_state:
		current_state.exit()
	
	current_state = states[new_state_name.to_lower()]
	current_state.enter()
