#Decrepit stagger state
extends PlayerState


# Called when the node enters the scene tree for the first time.
func enter(_msg := {}) -> void:
	print('ENTER STAGGER ',player.velocity,_msg)


func physics_update(_delta: float) -> void:
	player.get_node("AnimatedSprite2D").frame=0
	player.get_node("AnimatedSprite2D").stop()
	
	var stagger_dir_x = 1
	var stagger_dir_y = 1
	if player.velocity.x < 0:
		stagger_dir_x = -1
	var staggerVelocity = Vector2(-500 * stagger_dir_x, -70 * stagger_dir_y)
	
	player.velocity = Vector2.ZERO
	player.knockback = staggerVelocity
	player.move_and_slide()
	
	var iframe_time = player.get_node("AnimatedSprite2D/SpriteDmg/Timer").wait_time
	print(iframe_time)
	player.get_node("PlayerStats").set_invunerable_for_seconds(iframe_time, true)
	
	player.staggerTween = get_tree().create_tween()
	player.staggerTween.parallel().tween_property(player, "knockback",Vector2.ZERO, iframe_time)
	state_machine.transition_to("Air")
