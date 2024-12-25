extends CharacterBody2D

const SPEED = 140.0
const JUMP_VELOCITY = -525.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var isLeft = false

func _physics_process(delta):
	if abs(velocity.x) > 1:
		$AnimatedSprite2D.animation = "running"
	else:
		$AnimatedSprite2D.animation = "idle"
	
	if not is_on_floor():
		velocity.y += gravity * delta
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		$AnimatedSprite2D.animation = "jumping"
	
	if Input.is_action_pressed("left"):
		isLeft = true
	elif Input.is_action_pressed("right"):
		isLeft = false
	
	var direction = Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, 10)

	move_and_slide()
	
	$AnimatedSprite2D.flip_h = isLeft
