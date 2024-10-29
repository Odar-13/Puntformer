extends Node2D


func _ready() -> void:
	$checkpointArea/OnCheckpoint.visible = false

#Sets global player spawn to checkpoint position
func _on_checkpoint_area_body_entered(body: Node2D) -> void:
	$checkpointArea/OnCheckpoint.visible = true
	if body.name == "Player":
		Globals.levelInst.get_node("PlayerSpawn").position = position
	
	
