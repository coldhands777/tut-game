extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -300.0
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY



	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("move_left", "move_right")
	#flip sprite depending on direction
	if direction > 0:
		animated_sprite.flip_h = 0
	elif direction == -1:
		animated_sprite.flip_h = 1

		
	if is_on_floor() and animated_sprite.animation != "death":
		if direction == 0:
			animated_sprite.animation = "idle"
		else:
			animated_sprite.animation = "run"
	elif !is_on_floor() and animated_sprite.animation != "death":
		animated_sprite.animation = "jump"
		
		
		
	# apply movement
	if direction:
		
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
