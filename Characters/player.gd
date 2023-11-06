extends CharacterBody2D

@export var speed : float = 100

@onready var animation_tree : AnimationTree = $AnimationTree
@onready var state: AnimationNodeStateMachinePlayback = animation_tree.get("parameters/playback")

func _ready():
	animation_tree.active = true

func _physics_process(_delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	update_animation(input_direction)
	velocity = input_direction.normalized() * speed
	move_and_slide()

func update_animation(input: Vector2):
	if input == Vector2.ZERO:
		state.travel("Idle")
	else:
		state.travel("Walk")
		animation_tree.set("parameters/Walk/blend_position", input)
