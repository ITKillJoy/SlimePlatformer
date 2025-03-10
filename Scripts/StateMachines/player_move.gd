extends State

@export var jump_state: State
@export var idle_state: State
@export var fall_state: State

func enter() -> void:
	super()

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed('Jump') and parent.is_on_floor():
		return jump_state
	return null
	
func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta
	
	var movement = Input.get_axis('Left', 'Right') * move_speed
	
	if movement == 0 and !(Input.is_action_pressed("Left") or Input.is_action_pressed("Right")):
		return idle_state
	
	parent.animations.flip_h = movement < 0
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if !parent.is_on_floor():
		return fall_state
	
	return null
