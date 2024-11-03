extends Node

# Typed as int because only ints should be here
var battlers = []
var current_turn_count = 0

# TEMP VARIABLES TO LET LOGIC FLOW
#TODO: COMPARE PLAYER AND ENEMY SPEED
func _define_turn_order(battle_actors):
	battle_actors.sort_custom(sort_battlers)

func _do_round(array):
	for battler in array:
		var current_battler = array.pop()
		current_battler.do_turn()

static func sort_battlers(a, b) -> bool:
	return b.speed - a.speed
#TODO: CREATE TURN ORDER ARRAY
#TODO: POP ARRAY AND LET THE CONSTITUENT ACT
#TODO: RECEIVE SIGNAL FROM FINISHED ACTION TO POP NEXT ENTITY
#TODO: WHEN ARRAY EMPTY, REFILL ARRAY
#TODO: WHEN ARRAY EMPTY, PROPERLY DELETE ENEMIES
