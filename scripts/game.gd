extends Node

var alltime = 0
var activetime = 0
var SceneLevel=preload("res://scenes/overworld.tscn")

func _ready():
	#globals
	Globals.gameInst = self
	Globals.pauseInst = $Level/PauseLayer
	Globals.hudInst = $Level/HUDLayer
	Globals.debugInst = $Level/HUDLayer/Debug/DebugPanel
	Globals.playerInst = $Player
	Globals.camInst = $Player/Camera2D
	
	#remove player for menu
	remove_child(Globals.playerInst)
	
	# create level
	Globals.levelInst = SceneLevel.instantiate()
	$Level/LevelLayer.add_child(Globals.levelInst)
	
	#read player
	Globals.playerInst.translate(Globals.levelInst.get_node("PlayerSpawn").position)
	$Level/LevelLayer.add_child(Globals.playerInst)
	

	
	# starting level IMPORTANT TODO We do not have triggers for this yet, uncomment when important Brennen or delete if unneeded
	#Globals.levelInst.init_player_triggers()
	#Globals.levelInst.start_level()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("pause"):
		handle_pause()
	
	#add time to totals
	alltime+=delta
	if !(Globals.GamePaused):
		activetime+=delta
	
	Globals.debugInst.get_node("DebugText").text = "Playtime: " + str(alltime) + "\n" + "Activetime:" + str(activetime) + "\n" + "X: " + str(Globals.playerInst.position.x) + "\nY: " + str(Globals.playerInst.position.y) + "\n" 

func handle_pause():
	if Globals.GamePaused:
		Globals.GamePaused = false
		Globals.pauseInst.get_node("PausePanel").visible = false
		get_tree().paused = false
	else:
		Globals.GamePaused = true
		Globals.pauseInst.get_node("PausePanel").visible = true
		get_tree().paused = true
