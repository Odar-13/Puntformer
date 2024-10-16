extends PlayerState


func enter(_msg := {}) -> void:
	print('ENTER RPG ',_msg)
	player.velocity = Vector2.ZERO
	player.get_node("Camera2D").visibility = false

func physics_update(_delta: float) -> void:
	pass
	#TODO Code RPG
	
	#if all enemies dead:
		#player.get_node("Camera2D").visibility = true
		#state_machine.transition_to("Idle")
		#teleport back
