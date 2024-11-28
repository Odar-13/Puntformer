extends PlayerState

var attacking : bool = false

func enter(_msg := {}) -> void:
	print('ENTER ATTACK ',player.velocity,_msg)
	attacking = true
	get_node("../../SwordArea/AnimatedAttack").visible = true
	get_node("../../SwordArea/AnimatedAttack").play("attack")
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
		#if Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
			#state_machine.transition_to("Run")
	pass

#func _on_animated_attack_animation_finished() -> void:
	#attacking = false
	#get_node("../../SwordArea/AnimatedAttack").visible = false
	#state_machine.transition_to("Idle")
	
