#The state machiine behind player movement
class_name StateMachine
extends Node

signal transitioned(state_name)

@export var initial_state := NodePath("Idle")
@onready var state: State = get_node(initial_state) # current state

#Wait till the player has passed through ready, then set all needed states state machine variable to this instance. Enter initial_state (Currently Idle)
func _ready() -> void:
	await owner.ready
	for child in get_children():
		child.state_machine = self
	state.enter()

#In general, lets states do their state specific behavior
func _unhandled_input(event: InputEvent) -> void:
	state.handle_input(event)

func _process(delta: float) -> void:
	state.update(delta)

func _physics_process(delta: float) -> void:
	state.physics_update(delta)

#Transition to be called from states
func transition_to(target_state: String, data: Dictionary = {}) -> void:
	if not has_node(target_state):
		return
	state.exit()
	state = get_node(target_state)
	state.enter(data)
	emit_signal("transitioned", state.name)
	Globals.debugInst.get_node("Pstate").text = state.name

func current_state() -> String:
	return state.name
