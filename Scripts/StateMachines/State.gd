class_name State
extends Node

@export
var animation_name: String

@export var move_speed: float = 300
@export var jump_speed: float = 500
@export var side_jump_speed: float = 300

var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")

var parent: Player

func enter() -> void:
	parent.animations.play(animation_name)

func exit() -> void:
	pass

func process_input(event: InputEvent) -> State:
	return null

func process_frame(delta: float) -> State:
	return null

func process_physics(delta: float) -> State:
	return null
