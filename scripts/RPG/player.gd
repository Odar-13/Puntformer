extends Node2D

signal turn_completed

# Player stats, may need to send these to global at some point
@export var health = 20
@export var mana = 10
@export var attack = 10
@export var defense = 10
@export var speed = 8
@export var moxie = 5

# Including the variables above, these might need to be global
@export var level = 1
@export var experience = 0
@export var experience_needed = 100
@export var money = 0

func do_turn():
	# Unsure for now
	turn_completed.emit()

func calculate_level_up():
	# Some kind of math to determine how much xp is needed per level. Like 1.2x of the previous level?
	pass

func Jump():
	#TODO: Implement the jump action, including the damage calculation and animation. Timing aswell
	pass

func Sword():
	#TODO: Implement sword action, with the timing game of chicken, and animaiton
	pass

func Spell1():
	# Likely will be the fire spell
	#TODO: Implement 
	pass

func Spell2():
	# Likely will be the thorn spell
	#TODO: Implement
	pass

func Spell3():
	# Likely will be the stone wave spell
	#TODO: Implement
	pass

func UseItem(consumable):
	# Consume a consumable
	pass

func Flee():
	# Flee the battke
	pass

func can_level_up():
	#TODO: after adding xp from the battle, check if the player can level up. If false, end battle. If true, level up
	pass

func LevelUp():
	#TODO: Awards general stat increases, begins stat lottery, then ends battle
	pass
