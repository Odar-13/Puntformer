extends Node2D

# Battle Handler, unsure what I want to go here code wise, just im just gonna write a comment
"""

Places the player and the enemys in the world
	Enemies placed are determined by what enemy was interacted with initially.
Depending on the initial combat, the player may attack or trip

Then, refers to the turn order handler to find the next acting character
Enemies will randomly pull from their attack pool, unless a certain condition is met (boss is below certain HP?)

# NOTE: Player acitons might be handled in a seperate node
Player can select from a variety of options (Uses control nodes, can be controled by keyboard)
	Jump
		Teleports player above enemy, timed jump results in a second jump. Succeeding both is max damage
	Sword (when has)
		A game of chicken, the longer wait = more damage (unless TOO long)
	Magic (when has) (maybe use a special sprite of holding a tome when casting)
		Depends on the magic obtained, one kind per area
		Fire, Fire a few at max strength, then spam
		Shadow? (Swarm of shadow player characters, either sword or jump attacks)
		Thorn Swarm (Uses of thorn chakram, maybe use WASD to attack multiple enemies)
			Chakram ats like a boomerang? Have to catch and them throw. Alternates clockwise and counterclockwise
			Chance to slow enemies, dynamically changes turn order
			
		Stone Wave?
			Use of groundpound to create stone waves. Gets stronger over time.
				Best form has a chance to lower defense, by shattering the ground
			
		
	Consumables (always present, can be empty)
	Flee (shouldnt work during boss)



Enemies must return to their default position after attacking, if attacking requires them to move




Upon each enemy death, add total rewards to a rewards pool string, only give this to player upon victory.
If the player dies, end combat and game over!

If the player receives enough Xp to level up, begin the level up process 
(either handled in RPGScene, or a seperate node)

"""
