# Base class for every state in a state machine.

class_name State
extends Node

@onready var state_machine: StateMachine = get_parent()

func _ready() -> void:
	set_process(false)
	set_physics_process(false)

func enter():
	pass

func exit():
	pass

func update(_delta: float):
	pass

func physics_update(_delta: float):
	pass
