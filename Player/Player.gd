extends KinematicBody

onready var Camera = get_node("/root/Game/Player/Pivot/Camera")

var velocity = Vector3()
var gravity = -9.8
var speed = 0.2
var max_speed = 4

var mouse_sensitivity = 0.002


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
func _physics_process(delta):
	velocity.y += gravity * delta 
	var falling = velocity.y
	velocity.y = 0
	
	var desired_velocity = get_input() * speed
	if desired_velocity.length():
		velocity += desired_velocity
	else:
		velocity *= 0.9
	var current_speed = velocity.length()
	velocity = velocity.normalized() * clamp(current_speed,0,max_speed)
	velocity.y = falling
	
	$AnimationTree.set("parameters/Idle_Run/blend_amount", current_speed/max_speed)
	velocity = move_and_slide(velocity,Vector3.UP,true)
	
func _input(event):
	if event is InputEventMouseMotion:
		rotate_y(-event.reletive.x *mouse_sensitivity)
		
		
		
func get_input():
	var input_dir = Vector3()
	if Input.is_action_pressed("Forward"):
		input_dir -= Camera.global_transform.basis.z
	if Input.is_action_pressed("Back"):
		input_dir += Camera.global_transform.basis.z
	if Input.is_action_pressed("Left"):
		input_dir -= Camera.global_transform.basis.z
	if Input.is_action_pressed("Right"):
		input_dir += Camera.global_transform.basis.z
	input_dir = input_dir.normalized()
	return input_dir
