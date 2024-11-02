extends Node

# Typed as int because only ints should be here
var turn_order:Array[int] = []
var current_turn_count = 0

# TEMP VARIABLES TO LET LOGIC FLOW
#TODO: COMPARE PLAYER AND ENEMY SPEED
func _define_turn_order(array):
	array.sort()
	array.reverse()
	
#TODO: CREATE TURN ORDER ARRAY
#TODO: POP ARRAY AND LET THE CONSTITUENT ACT
#TODO: RECEIVE SIGNAL FROM FINISHED ACTION TO POP NEXT ENTITY
#TODO: WHEN ARRAY EMPTY, REFILL ARRAY
#TODO: WHEN ARRAY EMPTY, PROPERLY DELETE ENEMIES

	
func _sort_by_speed(a, b):
	return a.speed() > b.speed()
