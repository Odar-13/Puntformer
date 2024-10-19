class_name Player
extends CharacterBody2D

@export var has_dash = false
@export var dash_ready: bool = true

@export var camZoomMin := 0.5
@export var camZoomMax := 2.0
@export var camZoomSpeed := 0.1

@export var speed := 400.0
@export var gravity := 3500.0
@export var jump_impulse := 1200.0
@export var friction := 0.99
@export var acceleration := 0.1
@export var boost_speed := 40.0

var last_facing := 1

var knockback := Vector2.ZERO
var staggerTween

#@onready var sound_jump = $SoundJump
#@onready var sound_hit = $SoundHit
#Initialize finite state machine
@onready var fsm := $StateMachine

func _ready() -> void:
	get_node("PlayerStats").health_depleted.connect(dead)
	get_node("PlayerStats").health_changed.connect(health_changes)

func check_facing(new_facing):
	var dir = sign(new_facing.x)
	if (dir != 0 && dir != last_facing):
		last_facing = dir
		scale.x = -1

func calculate_input_direction() -> Vector2:
	if !$PlayerStats.input_locked:
		return Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), Input.get_action_strength("down") - Input.get_action_strength("jump")).normalized()
	return Vector2.ZERO

func _on_StateMachine_transition(current_state):
	Globals.debugInst.get_node("debugPanel/PState").text = String(current_state)

func _physics_process(_delta: float) -> void:
	if $StateMachine.state != get_node("StateMachine/RPG"):
		handle_camera()
	handle_use_actions()

func handle_camera():
	if Input.is_action_just_released("zoomin"):
		if Globals.camInst.zoom.x >= camZoomMin:
			Globals.camInst.zoom.x -= camZoomSpeed
			Globals.camInst.zoom.y -= camZoomSpeed
	elif Input.is_action_just_released("zoomout"):
		if Globals.camInst.zoom.x <= camZoomMax:
				Globals.camInst.zoom.x += camZoomSpeed
				Globals.camInst.zoom.y += camZoomSpeed

var current_toggle = null

func set_current_toggle(s):
	current_toggle = s
func clear_current_toggle():
	current_toggle = null
func handle_use_actions():
	if Input.is_action_just_released("use"):
		if current_toggle != null:
			if current_toggle.get_name() == "Toggle":
				current_toggle.flip_toggle()
			elif current_toggle.get_name() == "Prompt":
				current_toggle.ExecutePrompt()
			elif current_toggle.get_name == "Portal":
				current_toggle.Teleport()

func dead():
	set_process_input(false)
	set_physics_process(false)
	Globals.hudInst.get_node("UI/Panels/GameOverPanel").visible = true
	Globals.GamePaused = true
	get_tree().paused = true
	
func health_changes(old_value, new_value):
	Globals.hudInst.get_node("HealthPanel/Health").text = str($PlayerStats.health)

func take_damage(damage):
	$PlayerStats.take_damage(damage)
	$StateMachine.transition_to("Stagger")
	
	$AnimatedSprite2D/SpriteDmg.visible = true
	$AnimatedSprite2D/SpriteDmg/Timer.start()
	#sound_hit.play()

func _on_timer_timeout():
	$AnimatedSprite2D/SpriteDmg.visible = false
	pass

func _on_hazard_detector_area_entered(body):
	take_damage(5)
	
func _on_restart_pressed() -> void:
	set_process_input(true)
	set_physics_process(true)
	Globals.GamePaused = false
	get_tree().paused = false
	get_tree().reload_current_scene()
	
