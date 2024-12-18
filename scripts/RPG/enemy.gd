extends Node2D

class_name Enemy

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
var enemy_type = Enemy_Type.NORMAL

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
	print(enemy_name + " used attack one")
	pass
	
func Attack2():
	# Conduct attack, play appropriate animation
	print(enemy_name + " used attack two")
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
		print("Got the " + gear_item)
		pass
	elif chance <= 21:
		# TODO: ADD CONSUMABLE ITEM TO REWARDS POOL
		print("Got a " + consumable_item)
		pass
	else:
		# Shouldnt drop any item
		print("Got nothing!")
		pass
		
	# TODO: ADD XP AND MONEY TO REWARDS
	# TODO: Add all these rewards to a total rewards array for the fight, only awarded on victory
