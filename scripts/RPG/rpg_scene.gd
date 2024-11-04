extends Node2D

func _ready():
	#TODO: ONCE RECEIVE THE DICTIONARY FROM STATE TRANSITION, LOAD BACKGROUND
	#_set_background(dictionary whatever)
	
	$Player.position = $"BattleHandler/2D Markers/PlayerSpawn".position
	
	var temp_enemy = load("res://scenes/RPG/enemy.tscn") as PackedScene
	
	#TODO: SWAP OUT THE TEMP ENEMY FOR THE KIND OF ENEMY CONTACTED
	var battle_enemies = _generate_enemy_array(temp_enemy)
	_place_enemies(battle_enemies)

# Give the function the value of the "area" key in the dictionary, sets the appropriate background 
func _set_background(area: String):
	var background = get_node("Background")
	if area == "dungeon":
		#TODO: CREATE DUNGEON BACKGROUND, AND ADD PATH
		var battle_scene_background = ""
		background.change_background(battle_scene_background)
	elif area == "forest":
		#TODO: CREATE FOREST BACKGROUND, AND ADD PATH
		var battle_scene_background = ""
		background.change_background(battle_scene_background)
	elif area == "mountain":
		#TODO: CREATE MOUNTAIN BACKGROUND, AND ADD PATH
		var battle_scene_background = ""
		background.change_background(battle_scene_background)
	else:
		var battle_scene_background = "res://art/placeholder rpg.jpg"
		background.change_background(battle_scene_background)

# Makes the addition of enemies in the _egenrate_enemy_array function alot briefer
func add_enemy(enemy_array, enemy_to_add):
	var temp_enemy = enemy_to_add.instantiate()
	add_child(temp_enemy)
	enemy_array.append(temp_enemy)

# This array will have to be slowly filled out as more enemies are created
# Given a specific enemy, generates a random array of enemies to fight with 
# This is just going to have to be a very long function when completed
func _generate_enemy_array(contacted_enemy: PackedScene):
	# Create an empty array, fill with a random group of enemies based on contact. Return array
	if contacted_enemy == null:
		print("Enemy is NULL")
		return
	
	if contacted_enemy is not PackedScene:
		print("Enemy isnt a packed scene")
		return
	
	var enemies = []
	var action = randi() % 3 # choose a random number to determine enemies generated
	var initialized_enemy = contacted_enemy.instantiate()
	match initialized_enemy.enemy_name:
		_:
			var EnemyTemplate = load("res://scenes/RPG/enemy.tscn")
			match action:
				0:
					add_enemy(enemies, EnemyTemplate)
					print("Added one enemy!")
				1:
					add_enemy(enemies, EnemyTemplate)
					add_enemy(enemies, EnemyTemplate)
					print("Added two enemies!")
				2:
					add_enemy(enemies, EnemyTemplate)
					add_enemy(enemies, EnemyTemplate)
					add_enemy(enemies, EnemyTemplate)
					print("Added three enemies!")
	#print(enemies)
	return enemies

# Given an array of enemies, place them in the world
func _place_enemies(array_of_enemies: Array):
	if len(array_of_enemies) == 1:
		array_of_enemies[0].position = $"BattleHandler/2D Markers/1Enemy1Spawn".position
	elif len(array_of_enemies) == 2:
		array_of_enemies[0].position = $"BattleHandler/2D Markers/2Enemy1Spawn".position
		array_of_enemies[1].position = $"BattleHandler/2D Markers/2Enemy2Spawn".position
	elif len(array_of_enemies) == 3:
		array_of_enemies[0].position = $"BattleHandler/2D Markers/3Enemy1Spawn".position
		array_of_enemies[1].position = $"BattleHandler/2D Markers/3Enemy2Spawn".position
		array_of_enemies[2].position = $"BattleHandler/2D Markers/3Enemy3Spawn".position
	elif len(array_of_enemies) == 4:
		array_of_enemies[0].position = $"BattleHandler/2D Markers/4Enemy1Spawn".position
		array_of_enemies[1].position = $"BattleHandler/2D Markers/4Enemy2Spawn".position
		array_of_enemies[2].position = $"BattleHandler/2D Markers/4Enemy3Spawn".position
		array_of_enemies[3].position = $"BattleHandler/2D Markers/4Enemy4Spawn".position
	else:
		print("Length of enemy array out of bounds. HOW?")

#Unsure what I want yet, so heres some planning
"""

This will control the set up of the battle scene. Not necessarily the flow

Given the area the combat occurs in, the type of enemy encountered, and how theyre interacted with 

Area - Will set the apprpriate background depending on area
Type - Atleast one of the encountered enemy appears in the fight, maybe this should
	   be controlled on top by having default enemy layouts (Like touches spider, so either use
	   2 spiders, 3 spiders, or 2 spiders and a mimic)
Interaction - Player can start with advanatge either jump or sword, neutral, or disadvatange, where they trip

Unsure if this should be handled here, or in the battlehandler

Also controlled is, whether boss fight or normal fight, specific music on each. Boss disables fleeing. 

"""
