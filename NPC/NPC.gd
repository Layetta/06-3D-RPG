extends KinematicBody

onready var Dialogue = get_node("/root/Game/UI/Dialogue")

var dialogue = [
	"Looks like we have another lamb to the slaughter heh heh. (Press E to continue)"
	,"I have a lot of money riding on your death. So, don't get any ideas on winning this game."
	,"I'll lose my bet if you stay alive by destroying all the targets and that drone."
	,"You better end up dead if you know what's good for you. (Timer starts once you press E)"
]

func _ready():
	$AnimationPlayer.play("Idle")
	Dialogue.connect("finished_dialogue", self, "finished")




func _on_Area_body_entered(_body):
	Dialogue.start_dialogue(dialogue)


func _on_Area_body_exited(_body):
	Dialogue.hide_dialogue()
	#Dialogue.hide_dialogue(dialogue)


func finished():
	get_node("/root/Game/Target_container").show()
	Global.timer = 120
	Global.update_time()
	get_node("/root/Game/UI/Timer").start()
