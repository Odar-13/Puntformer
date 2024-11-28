#Player Movement State Machine Component
#Entered when player moves left or moves right on floor
#Exits after when a movement key is nor onger pressed, or player leaves floor, or player collides with enemy
#Exits into Air if in left floor, or Idle if no movement pressed, RPG if enemy is touched
extends PlayerState

var dash_ready: bool = true

# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	print('ENTER RUN ',player.velocity,_msg)
	if player.get_node("AnimatedSprite2D").flip_v == true:
		player.get_node("AnimatedSprite2D").flip_v = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func physics_update(delta: float) -> void:
	var input_direction = player.calculate_input_direction()
	player.check_facing(input_direction)
	var input_direction_x: float = input_direction.x
	player.get_node("AnimatedSprite2D").play("walk")
	
	var spd = player.speed
	if Input.is_action_pressed("dash") and player.has_dash:
		state_machine.transition_to("Dashing")
	elif Input.is_action_just_pressed("down") and player.has_dash:
		state_machine.transition_to("Slide")
		
	player.velocity.x = spd * input_direction_x
	player.velocity.y += player.gravity * delta

	player.velocity = player.velocity + Vector2.UP
	player.velocity += player.knockback	
	player.move_and_slide()

	if Input.is_action_just_pressed("jump"):
		state_machine.transition_to("Air", {do_jump = true})
	elif is_equal_approx(input_direction_x, 0.0):
		state_machine.transition_to("Idle")
	elif player.velocity.y > 0:
		state_machine.transition_to("Air")
