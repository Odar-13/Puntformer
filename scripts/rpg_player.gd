extends Node2D

@export var health = 20 # When 0, battle ends. 
@export var mana = 10 # Affects how many spells can be cast
@export var attack = 10 # Affects damage dealt
@export var defense = 10 # Affects damage taken
@export var speed = 8 # Affects turn order
@export var moxie = 5 # Affects critical hit chance

# Including the variables above, these might need to be global
@export var level = 1
@export var experience = 0
@export var experience_needed = 100
@export var money = 0

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
	# Flee the battle
	pass

func can_level_up():
	#TODO: after adding xp from the battle, check if the player can level up. If false, end battle. If true, level up
	pass

func LevelUp():
	#TODO: Awards general stat increases, begins stat lottery, then ends battle
	pass
