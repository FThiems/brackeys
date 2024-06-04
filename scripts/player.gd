extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0
@export var alive = true

@onready var animated_sprite_2d = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func is_alive():
	print(alive)
	return alive

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if direction > 0:
			animated_sprite_2d.flip_h = false
		else:
			animated_sprite_2d.flip_h = true
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	#Play animations
	if is_on_floor() and is_alive():
		if direction:
			animated_sprite_2d.play("run")
		else:
			animated_sprite_2d.play("idle")
	elif is_alive(): 
		animated_sprite_2d.play("jump")

	move_and_slide()
