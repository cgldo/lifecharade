extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible = false
	self.text = str(Global.time)
	self.rect_size  = Vector2(get_viewport().size.x /4,  get_viewport().size.y/10)
		#_i.rect_global_position = _i.rect_global_position + (self.rect_size - _i.rect_size)/2
	self.get_font('font').size = get_viewport().size.y/11
	#self.rect_global_position = Vector2((get_viewport().size.x - self.rect_size.x )/2 , 0)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
