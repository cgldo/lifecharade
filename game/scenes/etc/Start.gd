extends Timer
signal counted_down(number)
export var _count := 5

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	connect("timeout", self, "_on_timeout")

func _on_timeout() -> void:
	emit_signal("counted_down", _count)
	_count -= 1
	if _count < 0:
		stop()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
