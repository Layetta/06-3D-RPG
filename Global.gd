extends Node

func _ready():
	OS.window_position = Vector2(100,100)

func _input(_event):
	if Input.is_action_just_pressed("Quit"):
		get_tree().quit()
