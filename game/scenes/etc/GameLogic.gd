extends Control
export (int) var second = 0
var dsec = 0

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _physic_process(delta):
	if second > 0 and dsec <=0:
		second -= 1
		dsec = 10
	$GameText.text = str(second)


func _on_Timer_timeout():
	dsec -=1
