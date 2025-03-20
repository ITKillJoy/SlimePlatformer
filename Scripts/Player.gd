class_name Player
extends CharacterBody2D

enum WallSide {Left = -1, Right = 1, None=0}


@onready var animations = $PlayerAnimations

@onready var state_machine = $state_machine

@onready var lastWallJumped : WallSide = WallSide.None
# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready() -> void:
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.process_input(event)

func _physics_process(delta: float) -> void:	
	state_machine.process_physics(delta)

func _process(delta: float) -> void:
	state_machine.process_frame(delta)

func getLastWallSide() :
	return lastWallJumped

func resetLastWallSide() -> void:
	lastWallJumped = WallSide.None

func setLastWallSide(side: int) -> void:
	lastWallJumped= side
