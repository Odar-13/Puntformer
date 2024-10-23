extends Node

# Typed as int because only ints should be here
var turn_order:Array[int] = []
var current_turn_count = 0

# TEMP VARIABLES TO LET LOGIC FLOW
var player_speed = 10
var enemy1_speed = 5
var enemy2_speed = 10
var enemy3_speed = 15

func _ready():
	turn_order.append_array([player_speed, enemy1_speed, enemy2_speed, enemy3_speed])
	print(turn_order)
	_define_turn_order(turn_order)
	print(turn_order)

func _define_turn_order(array):
	array.sort()
	array.reverse()
