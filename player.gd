extends CharacterBody2D

const GRAVITY = 2940

@export var speed = 400.0
@export var gravity = 0 
@export var jump = 800.0
@export var terminal = 1000

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		if Input.is_action_pressed("jump"):
			gravity = GRAVITY / 3
		else:
			gravity = GRAVITY
		velocity.y += gravity * delta
			
	# Terminal Velocity
	if velocity.y > terminal:
		velocity.y = terminal
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump

	#Left and right movement
	var direction := Input.get_axis("move_left", "move_right")
	if direction:
		velocity.x = direction * speed
		$AnimatedSprite2D.play()
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		$AnimatedSprite2D.stop()
	

	
	move_and_slide()
	
	if velocity.y != 0 and !is_on_floor():
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
	elif velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_v = false
		$AnimatedSprite2D.flip_h = velocity.x < 0
	
	if is_on_floor():
		$AnimatedSprite2D.flip_v = false
	
	#print(velocity)
		
		
	
		
	
		
	
