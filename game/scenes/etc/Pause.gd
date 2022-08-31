extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.rect_size  = Vector2(get_viewport().size.x /13,  get_viewport().size.y/8)
	self.rect_global_position = Vector2(get_viewport().size.x - self.rect_size.x - 25, 50)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
