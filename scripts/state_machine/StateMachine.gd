class_name StateMachine
extends Node

signal transitioned(state_name)

@export var initial_state := NodePath("Idle")
@onready var state: State = get_node(initial_state) # current state

func _ready() -> void:
	await owner.ready
	for child in get_children():
		child.state_machine = self
	state.enter()

func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)

func _process(delta: float) -> void:
	state.update(delta)

func _physics_process(delta: float) -> void:
	state.physics_update(delta)

func transition_to(target_state: String, data: Dictionary = {}) -> void:
	if not has_node(target_state):
		return
	state.exit()
	state = get_node(target_state)
	state.enter(data)
	emit_signal("transitioned", state.name)
	Globals.debugInst.get_node("Pstate").text = state.name
