extends PlayerState
var attack_ready: bool = true
	
func enter(_msg := {}) -> void:
	attack_ready = false
	print('ENTER ATTACKING ',player.velocity,_msg)
	Globals.playerInst.get_node("SwordArea/SwordShape2D").disabled = false
	#$Player/SwordArea/SwordShape2D.visible = true
#func physics_update(delta: float) -> void:
	#state_machine.transition_to("Idle")
	
func physics_update(delta: float) -> void:
	state_machine.transition_to("Idle")
	
func _on_sword_area_body_entered(body: Node2D) -> void:
	if body.name == "EnemyArea2D1":
		Globals.gameInst.transition_to_scene("RPG")
		state_machine.transition_to("RPG")


func _on_attack_duration_timeout() -> void:
	Globals.playerInst.get_node("SwordArea/SwordShape2D").disabled = true
	#$Player/SwordArea/SwordShape2D.visible = false
