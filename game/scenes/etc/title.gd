extends Control


func _ready():
	randomize()
	for _i in $Categories.get_children ():
		_i.rect_min_size  = Vector2(get_viewport().size.x / 5,  get_viewport().size.y / 2)
		



	
