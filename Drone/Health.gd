extends ProgressBar


func _physics_proccess(_delta):
	value = get_node("/root/Game/Drone_container/Drone").health
