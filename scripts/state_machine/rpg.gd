#Player Movement State Machine Component
#Entered when player collides with an enemy Area2D
#Exits after enemies are defeated
#Exits into Idle
extends PlayerState

#_msg will contain a dictionary of any information needed
func enter(_msg := {}) -> void:
	print('ENTER RPG ',_msg)
	player.velocity = Vector2.ZERO
	player.get_node("Camera2D").enabled = false

func physics_update(_delta: float) -> void:
	pass
	#TODO Code RPG
	
	#if all enemies dead:
		#player.get_node("Camera2D").visibility = true
		#state_machine.transition_to("Idle")
		#teleport back
