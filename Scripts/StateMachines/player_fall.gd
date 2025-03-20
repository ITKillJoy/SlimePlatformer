extends State

@export var idle_state: State
@export var move_state: State
@export var wall_jump_left_state: State
@export var wall_jump_right_state: State

func enter() -> void:
	super()

func process_input(event: InputEvent) -> State:
	if Input.is_action_just_pressed("Jump") and parent.is_on_wall():
		#on get_wall Normal (1.0, 0.0) is for the right side of wall and (-1.0, 0.0) os for left side of the wall
		var wallDirection=parent.get_wall_normal().x
		var lastWallDirection = parent.getLastWallSide()
		print("hit space while falling ", wallDirection," ", lastWallDirection)
		
		if(wallDirection > 0 && lastWallDirection < 1):
			parent.setLastWallSide(wallDirection)
			return wall_jump_right_state
		elif(wallDirection < 0 && lastWallDirection > -1):
			parent.setLastWallSide(wallDirection)
			return wall_jump_left_state
	
	return null

func process_physics(delta: float) -> State:
	parent.velocity.y += gravity * delta

	var movement = Input.get_axis('Left', 'Right') * move_speed
	
	if movement != 0:
		parent.animations.flip_h = movement < 0
	parent.velocity.x = movement
	parent.move_and_slide()
	
	if parent.is_on_floor():
		parent.resetLastWallSide()
		if movement != 0:
			return move_state
		return idle_state
	return null
