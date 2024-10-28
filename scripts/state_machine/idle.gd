#Player Movement State Machine Component
#Entered when player is not pressing anything and is on the ground, or player collides with enemy
#Exits when any movement button is pressed, into Air if jump, Run if left or right (Currently cannot dash from idle), RPG if enemy is touched

extends PlayerState

func enter(_msg := {}) -> void:
	print('ENTER IDLE ',player.velocity,_msg)
	player.velocity = Vector2.ZERO
	if player.get_node("AnimatedSprite2D").flip_v == true:
		player.get_node("AnimatedSprite2D").flip_v = false

func physics_update(_delta: float) -> void:
	if not player.is_on_floor():
		state_machine.transition_to("Air")
		return
	
	player.get_node("AnimatedSprite2D").play("idle")
	
	if !is_equal_approx(player.velocity.x, 0.0):
		player.velocity = player.velocity + Vector2.UP
		player.move_and_slide()
	else:
		if Input.is_action_just_pressed("jump"):
			state_machine.transition_to("Air", {do_jump = true})
		elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			state_machine.transition_to("Run")
