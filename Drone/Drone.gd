extends KinematicBody

var radious = 50
var angle = 0
export var height = 20
export var speed = 5 

var health = 100


func _ready():
	randomize()
	angle = randf() * 2 * PI
	new_position(angle)
	
	

func new_position(a):
	var pos = Vector3(0,height,0)
	pos.x = radious * cos(a)
	pos.z = radious * sin(a)
	look_at(pos,Vector3(0,1,0))
	$Tween.interpolate_property(self, "global_transform:origin", global_transform.origin, pos, speed, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	$Tween.start()

func die():
	health -= 10
	if health <= 0:
		Global.update_score(100)
		queue_free()
	
func _on_Tween_tween_all_completed():
	angle += PI/2 + (randf() * (PI/2))
	angle = wrapf(angle, 0, 2*PI)
	new_position(angle)


func _on_Area_body_entered(body):
	body.damage()
