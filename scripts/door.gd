extends Node2D

@export var destination_tag : String
var current_toggle = null

func _on_door_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.destination = destination_tag	


func _on_door_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		body.current_toggle = null
