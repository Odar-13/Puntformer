extends PlayerState

# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	print('ENTER AIR ',player.velocity,_msg)
	if _msg.has("do_jump"):
		player.velocity.y = -player.jump_impulse
		#player.sound_jump.play

func physics_update(delta: float) -> void:
	var input_direction = player.calculate_input_direction()
	player.check_facing(input_direction)
	
	var input_direction_x: float = input_direction.x
	player.get_node("AnimatedSprite2D").play("jump")
	#Later have fall animation
	if player.velocity.y > 0:
		player.get_node("AnimatedSprite2D").flip_v = true

	
	var spd = player.speed
	
	if Input.is_action_pressed("dash") and player.has_dash:
		state_machine.transition_to("Dashing")
	
	player.velocity.x = spd * input_direction_x
	player.velocity.y += player.gravity * delta
	
	player.velocity = player.velocity + Vector2.UP
	player.velocity += player.knockback
	player.move_and_slide()
	
	if player.is_on_floor():
		player.get_node("AnimatedSprite2D").flip_v = false
		if is_equal_approx(player.velocity.x, 0.0):
			state_machine.transition_to("Idle")
		else:
			state_machine.transition_to("Run")
