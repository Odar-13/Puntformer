#General Player Script

class_name Player
extends CharacterBody2D
#Local Variables
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

var destination = ""
var door_to = ""
var last_facing := 1

var knockback := Vector2.ZERO
var staggerTween

var attacking : bool = false
#disabled for rpg and other instances
var can_attack : bool = true

@onready var regular_hitbox = $CollisionShape2D
@onready var slide_hitbox = $SlideCollision

#@onready var sound_jump = $SoundJump
#@onready var sound_hit = $SoundHit
#Initialize finite state machine
@onready var fsm := $StateMachine

#Connecting Signals
func _ready() -> void:
	$SwordArea/SwordCollision.disabled = true
	get_node("SwordArea/AnimatedAttack").visible = false
	get_node("PlayerStats").health_depleted.connect(dead)
	get_node("PlayerStats").health_changed.connect(health_changes)

#See if we're facing right or left
func check_facing(new_facing):
	var dir = sign(new_facing.x)
	if (dir != 0 && dir != last_facing):
		last_facing = dir
		scale.x = -1

#To allow controller input, this weighs our input to make sure we know which direction to move
func calculate_input_direction() -> Vector2:
	if !$PlayerStats.input_locked:
		return Vector2(Input.get_action_strength("move_right") - Input.get_action_strength("move_left"), Input.get_action_strength("down") - Input.get_action_strength("jump")).normalized()
	return Vector2.ZERO

#Handles Debug Menu, specifically the Player State panel for testing purposes
func _on_StateMachine_transition(current_state):
	Globals.debugInst.get_node("debugPanel/PState").text = String(current_state)

#During the general runtime, handle uses and if we're not in rpg, allow camera control
func _physics_process(_delta: float) -> void:
	if $StateMachine.state != get_node("StateMachine/RPG"):
		handle_camera()
	handle_use_actions()
	if Input.is_action_just_pressed("attack") and can_attack == true:
		Attack()

#Allows zoomin and zoomout of camera to a certain minumum and maximum level
func handle_camera():
	if Input.is_action_just_released("zoomin"):
		if Globals.camInst.zoom.x >= camZoomMin:
			Globals.camInst.zoom.x -= camZoomSpeed
			Globals.camInst.zoom.y -= camZoomSpeed
	elif Input.is_action_just_released("zoomout"):
		if Globals.camInst.zoom.x <= camZoomMax:
				Globals.camInst.zoom.x += camZoomSpeed
				Globals.camInst.zoom.y += camZoomSpeed

#This variable and three functions are to handle player uses, such as choosing to go through a door
#Set the toggle on area entered, and clear it on area exited
#Allows for the same use button to have many uses depending on what Area2D you're in
var current_toggle = null

func set_current_toggle(s):
	current_toggle = s
func clear_current_toggle():
	current_toggle = null

func handle_use_actions():
	if Input.is_action_just_released("use"):
		if current_toggle != null:
			if current_toggle == "Toggle":
				current_toggle.flip_toggle()
			elif current_toggle == "Prompt":
				current_toggle.ExecutePrompt()
			elif current_toggle == "Portal":
				current_toggle.Teleport()
			elif current_toggle == "Door":
				if fsm.current_state() == "Slide":
					fsm.transition_to("Idle")
				get_tree().paused = true
				await get_tree().create_timer(1.0).timeout
				get_tree().paused = false
				Globals.gameInst.transition_to_scene(destination, door_to)
				print("scene transition")

#When the players health is depleted, this runs
func dead():
	set_process_input(false)
	set_physics_process(false)
	Globals.hudInst.get_node("UI/Panels/GameOverPanel").visible = true
	Globals.GamePaused = true
	get_tree().paused = true
	
func Attack():
	print("Attacking")
	attacking = true
	get_node("SwordArea/AnimatedAttack").visible = true
	get_node("SwordArea/AnimatedAttack").play("attack")
	$SwordArea/SwordCollision.disabled = false
	pass
	
#When the health changes, update the HealthPanel
func health_changes(old_value, new_value):
	Globals.hudInst.get_node("HealthPanel/Health").text = str($PlayerStats.health)

#Code for taking damage
func take_damage(damage):
	$PlayerStats.take_damage(damage)
	
	$AnimatedSprite2D/SpriteDmg.visible = true
	$AnimatedSprite2D/SpriteDmg/Timer.start()
	#sound_hit.play()

#Return player to normal sprite after taking damage
func _on_timer_timeout():
	$AnimatedSprite2D/SpriteDmg.visible = false
	pass

#What to do when entering an area
func _on_hazard_detector_area_entered(body):
	print("Something")
	print(body.name)
	if body.name == "HazardArea":
		respawn()
	elif body.name == "Door2D" :
		set_current_toggle("Door")
	elif body.name == "EnemyArea2D1":
		Globals.gameInst	.transition_to_scene("RPG")
		fsm.transition_to("RPG")

#Respawns player
func respawn():
	Globals.playerInst.position = Globals.levelInst.get_node("PlayerSpawn").position

#Reloads area and unpauses game on restart pressed on game over menu
func _on_restart_pressed() -> void:
	set_process_input(true)
	set_physics_process(true)
	Globals.GamePaused = false
	get_tree().paused = false
	get_tree().reload_current_scene()

func _on_animated_attack_animation_finished() -> void:
	attacking = false
	get_node("SwordArea/AnimatedAttack").visible = false
	$SwordArea/SwordCollision.disabled = true

func _on_sword_area_area_entered(area: Area2D) -> void:
	if area.name == "EnemyArea2D1" and attacking == true:
		$SwordArea/AnimatedAttack.stop()
		get_node("SwordArea/AnimatedAttack").visible = false
		can_attack = false
		attacking = false
		Globals.gameInst	.transition_to_scene("RPG")
		fsm.transition_to("RPG")
