#Player Movement State Machine Component
#Entered when player hits dash key and they have the dash available
#Exits after DashDuration timer finishes, locking players in a x movement into a boosted single direction, n0 y movement possible, or player collides with enemy
#Exits into Air if in air,  Run if on a floor, or RPG if enemy is touched


extends PlayerState

@onready var dash_cooldown = $DashCooldown
@onready var dash_duration = $DashDuration

var dash_ready: bool = true

func enter(_msg := {}) -> void:
	print('ENTER DASHING ',player.velocity,_msg)
	#player.get_node("AnimatedSprite2D").play("dash")
	perform_dash()
	dash_cooldown.start()
	dash_duration.start()
	
func physics_update(delta: float) -> void:
	var input_direction = player.calculate_input_direction()
	player.check_facing(input_direction)
	player.velocity.x += player.speed * player.boost_speed * delta * input_direction.x
	player.velocity.y = 0
	player.move_and_slide()


#function not used, maybe later
func can_dash() -> bool:
	return dash_ready and player.has_dash
	
func perform_dash() -> void:
	dash_ready = false
	player.has_dash = false
	
	
func reset_dash_on_floor():
	player.has_dash = true

func _on_dash_cooldown_timeout() -> void:
		#print("Cooldown timer stopped")
		reset_dash_on_floor()
		dash_ready = true

func _on_dash_duration_timeout() -> void:
	#print("Duration timer stopped")
	if !player.is_on_floor():
		state_machine.transition_to("Air")
	else: 
		state_machine.transition_to("Run")
