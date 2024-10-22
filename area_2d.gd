extends Area2D

# Unsure how I want to do the code for the enemy, so here is a placeholder so I have an idea
"""

# Enemy Stats for the default
Name - Defines the enemy
Enemy type - Only important for player attack type (Spiked, flying, on fire) Can only be one
Depending on time, it might be nice if a stronger, mid boss enemy could take over a fight
this is VERY time dependent. Otherwise just copy and paste the standard template

HP - Reaches 0, enemy dies and rewards xp, money, and maybe loot
Defense - Reduces damage taken
Speed - Controls turn order

XP - Gives XP to player upon player victory
Money - Gives Money to player upon player victory
Items - Either gives nothing (most of the time), a consumable (ocassionaly), or gear (rarely).
# Probably in battle handler, only reward loot upon battle victory (not failure or fleeing)

Enemy sprite
Enemy attacks (2, with variation on each)
Enemy animations (for idle, moving, and attacking)
Enemy being attacked would be some king of damaged sprite (wide eyed, maybed squashed for jump)

Also need to put enemy in the proper location, This will likely be done in BattleHandler by checking the amount
of enemies, then placing them at the propery 2dmarker

"""
