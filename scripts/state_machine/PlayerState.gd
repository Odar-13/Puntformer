#The Base for all Player States, inherits the State file
class_name PlayerState
extends State

var player: Player

func _ready() -> void:
	await owner.ready	
	player = owner as Player
	assert(player != null)
