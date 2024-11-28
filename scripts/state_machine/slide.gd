extends PlayerState

@onready var dash_cooldown = get_node("../Dashing/DashCooldown")
@onready var slide_duration = $SlideDuration

var slide_ready: bool = true
var slide_speed = 1600
var top_detected = false
var bottom_detected = false

#input needs to be constant or player can't move while sliding
var constant_input = Vector2(0,0)

func enter(_msg := {}) -> void:
	player.get_node("AnimatedSprite2D").position = Vector2(0, 22)
	get_node("../../CollisionShape2D").disabled = true
	get_node("../../SlideArea/SlideHelp").disabled = false
	get_node("../../SlideArea2/SlideHelp2").disabled = false
	get_node("../../SlideCollision").disabled = false
	print(self)
	print('ENTER SLIDE ',player.velocity,_msg)
	player.get_node("AnimatedSprite2D").play("slide")
	perform_slide()
	dash_cooldown.start()
	slide_duration.start()
	constant_input = player.calculate_input_direction()
	
func physics_update(delta: float) -> void:
	player.velocity.x = slide_speed * constant_input.x
	player.move_and_slide()
	print(slide_duration)
	
func perform_slide() -> void:
	slide_ready = false
	player.has_dash = false
	
func reset_dash_on_floor():
	player.has_dash = true

func _on_dash_cooldown_timeout() -> void:
	reset_dash_on_floor()
	slide_ready = true

func _on_slide_duration_timeout() -> void:
	get_node("../../SlideArea/SlideHelp").disabled = true
	get_node("../../SlideArea2/SlideHelp2").disabled = true
	player.get_node("CollisionShape2D").disabled = false
	player.get_node("SlideCollision").disabled = true
	var hurtbox = get_node("../../HazardDetector/PlayerHurtBox")
	var shape = hurtbox.shape
	player.get_node("AnimatedSprite2D").position = player.get_node("AnimatedSprite2D").position - Vector2(0, 22)
	print("Slide Duration timer stopped")
	if get_parent().state== get_parent().get_node("RPG"):
		return
	elif !player.is_on_floor():
		state_machine.transition_to("Air")
	else: 
		state_machine.transition_to("Run")

#Seperate collision shape from HazardDetector as we need a collision shape not touching the ground
func _on_slide_area_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		top_detected = true
	_check_slide_state()

#two seperate bodies are needed to detect if an object is both above and below player
func _on_slide_area_body_exited(body: Node2D) -> void:
	top_detected = false
	_check_slide_state()

func _on_slide_area_2_body_entered(body: Node2D) -> void:
	if body.name != "Player":
		bottom_detected = true
	_check_slide_state()

func _on_slide_area_2_body_exited(body: Node2D) -> void:
	bottom_detected = false
	_check_slide_state()
	
func _check_slide_state() -> void:
	if top_detected == true and bottom_detected == true:
		slide_duration.paused = true
		dash_cooldown.paused = true
	else:
		slide_duration.paused = false
		dash_cooldown.paused = false
		
