extends KinematicBody2D

const UP= Vector2(0,-1)
const FLAP=200
const MAXFALLSPEED=200
const GRAVITY=10
var score=0

var motion= Vector2();
var Wall= preload("res://Wallnode.tscn")
func _ready():
	pass # Replace with function body.

func Wall_reset():
	var Wall_instance= Wall.instance()
	Wall_instance.position= Vector2(450,rand_range(-60,60))
	get_parent().call_deferred("add_child",Wall_instance)
func _process(delta):
	motion.y+=GRAVITY
	if motion.y>MAXFALLSPEED:
		motion.y=MAXFALLSPEED
		
	if Input.is_action_just_pressed("FLAP"):
		motion.y=-FLAP

	motion= move_and_slide(motion,UP)
	get_parent().get_parent().get_node("CanvasLayer/RichTextLabel").text= str(score)



func _on_Resetter_body_entered(body):
	if body.name=="Walls":
		body.queue_free()
		Wall_reset()
		
	


func _on_Detect_area_entered(area):
	if area.name=="PointArea":
		score+=1


func _on_Detect_body_entered(body):
	if body.name=="Walls":
		get_tree().reload_current_scene()
	pass # Replace with function body.
