extends Node2D

enum Enemy_Type {NORMAL, FLYING, SPIKED, FIRE}

@export var enemy_name = "Default"
@export var max_health = 20
@export var health = max_health
@export var defense = 5
@export var speed = 5
@export var xp = 4
@export var money = 8
# TODO: CHANGE TO ACTUAL ITEM
@export var consumable_item = "Algul"
# TODO: CHANGE TO ACTUAL ITEM
@export var gear_item = "The one ring"
@export var item_pool = [consumable_item, gear_item]


func do_turn():
	# Maybe need to check if enemy is dead?
	
	# Get into position to attack
	
	
	var attack_chance = randi() % 2
	if attack_chance == 0:
		Attack1()
	else:
		Attack2()

# Attacks assume the enemy is in position to attack. 
func Attack1():
	# Conduct attack, play appropriate animation
	pass
	
func Attack2():
	# Conduct attack, play appropriate animation
	pass
	


func _take_damage(amount: int):
	health -= amount
	if health <= 0:
		_die()

func _die():
	_generate_loot()
	queue_free()

func _generate_loot():
	var chance = (randi() % 100) + 1
	if chance == 1:
		# TODO: ADD GEAR LOOT ITEM TO REWARDS POOL
		pass
	elif chance <= 21:
		# TODO: ADD CONSUMABLE ITEM TO REWARDS POOL
		pass
	else:
		# Shouldnt drop any item
		pass
		
	# TODO: ADD XP AND MONEY TO REWARDS
	# TODO: Add all these rewards to a total rewards array for the fight, only awarded on victory
