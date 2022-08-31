extends PanelContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var pad = 50
var num = 0
var current = Vector2(0,0) 

# Called when the node enters the scene tree for the first time.
func _ready():
	for _i in self.get_children ():
		#_i.rect_scale = Vector2(4*get_viewport().size.x / 1280,  4*get_viewport().size.y / 720)
		if _i is Button:
			_i.rect_size  = Vector2(get_viewport().size.x /4,  get_viewport().size.y *.65)
			#_i.rect_global_position = _i.rect_global_position + (self.rect_size - _i.rect_size)/2
			current.x = _i.rect_size.x * num + num * pad
			_i.rect_global_position = current
		#_i.get("custom_fonts/font").set_size(100)
			for text in _i.get_children():
				text.get_font("font", "Label").size =  get_viewport().size.y / 12
				text.rect_size = _i.rect_size *.8
				text.rect_global_position = _i.rect_global_position + (_i.rect_size - text.rect_size)/2
				
		num += 1


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
