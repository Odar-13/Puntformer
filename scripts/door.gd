extends Node2D

@export var destination_tag : String
@export var door_to : String
var current_toggle = null

func _on_door_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.destination = destination_tag
		body.door_to = door_to

func _on_door_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		body.current_toggle = null
