extends Node2D

func _ready():
	#TODO: ONCE RECEIVE THE DICTIONARY FROM STATE TRANSITION, LOAD BACKGROUND
	#_set_background(dictionary whatever)
	pass

# Give the function the value of the "area" key in the dictionary, sets the appropriate background 
func _set_background(area: String):
	var background = get_node("Background")
	if area == "dungeon":
		#TODO: CREATE DUNGEON BACKGROUND
		var battle_scene_background = ""
		background.change_background(battle_scene_background)
	elif area == "forest":
		#TODO: CREATE FOREST BACKGROUND
		var battle_scene_background = ""
		background.change_background(battle_scene_background)
	elif area == "mountain":
		#TODO: CREATE MOUNTAIN BACKGROUND
		var battle_scene_background = ""
		background.change_background(battle_scene_background)
	else:
		var battle_scene_background = "res://art/placeholder rpg.jpg"
		background.change_background(battle_scene_background)

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
