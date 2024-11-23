extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -250.0

@onready var sprite: Sprite2D = $Sprite2D
@onready var animation_player: AnimationPlayer = $Sprite2D/AnimationPlayer

var can_doublejump = true

func _physics_process(delta: float) -> void:
	
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		can_doublejump = true

	# Handle jump.
	if Input.is_action_just_pressed("jump"):
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			print("First Jump!")
		elif can_doublejump and not is_on_floor():
			can_doublejump = false
			velocity.y = JUMP_VELOCITY
			print("Second Jump!")
	
	# Get the direction (-1 , 0 , 1) (left, idle, right)
	var direction := Input.get_axis("move_left", "move_right")
	
	if direction < 0:
		sprite.flip_h = true
	elif direction > 0:
		sprite.flip_h = false
	
	# Play animation
	if direction == 0:
		animation_player.play("idle")
	else:
		animation_player.play("walk")
	
		
	# Handle Movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
