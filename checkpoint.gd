extends Node2D

@onready var OnCheckpoint = $checkpointArea/OnCheckpoint
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$checkpointArea/OnCheckpoint.visible = false




func _on_checkpoint_area_body_entered(body: Node2D) -> void:
	$checkpointArea/OnCheckpoint.visible = true
	if body.name == "Player":
		Globals.levelInst.get_node("PlayerSpawn").position = position
	
	
