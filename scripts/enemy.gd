extends Node2D

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



# Attacks assume the enemy is in position to attack. 
func take_turn():
	if health <= 0:
		return # if dead, skip turn
	
	var attack_type = randi() % 2
	if attack_type == 0:
		Attack1()
	else:
		Attack2()

func _take_damage(amount: int):
	health -= amount
	if health <= 0:
		_die()

func _die():
	_generate_loot()
	print(enemy_name + " has died!")
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

func Attack1():
	# Conduct attack, play appropriate animation
	pass
	
func Attack2():
	# Conduct attack, play appropriate animation
	pass
