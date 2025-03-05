extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var direction 
var isAttacking = 0

@onready var animated_sprite = $AnimatedSprite2D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_axis("Left", "Right")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	selectAnimation()
	
	move_and_slide()


func selectAnimation():
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
	
	if(isAttacking==0):
		if is_on_floor():
				animated_sprite.play("idle")
		else:
			animated_sprite.play("Jump")
			
		if Input.is_action_just_pressed("AttackA"):
			isAttacking=1
			animated_sprite.play("attack_1")
		

func _on_animated_sprite_2d_animation_finished():
	if(animated_sprite.animation == "attack_1"):
		isAttacking=0
