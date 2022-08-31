extends LineEdit


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.virtual_keyboard_enabled = false
	self.text = str(Global.time)
	self.rect_size  = Vector2(get_viewport().size.x /4,  get_viewport().size.y/10)
		#_i.rect_global_position = _i.rect_global_position + (self.rect_size - _i.rect_size)/2
	self.rect_global_position = Vector2((get_viewport().size.x - self.rect_size.x )/2 , 0)
	self.get_font('font').size = get_viewport().size.y/11
	for _i in self.get_node("GridContainer").get_children():
		_i.connect("pressed", self, "_on_button_pressed", [_i])
		_i.set_focus_mode(0)
	$GridContainer.visible = false
	$GridContainer.rect_size  = Vector2(get_viewport().size.x /4,  get_viewport().size.y/2)
	$GridContainer.rect_global_position =  (get_viewport().size - $GridContainer.rect_size )/2
func _on_button_pressed(which : Button):
	var text = self.text
	if which.text == "Del":
		if text.length() > 0:
			text.erase(text.length() - 1, 1)
			self.text = text
	elif which.text == "En":
		$GridContainer.visible = false
	else:
		self.text += which.text
	which.pressed = false
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LineEdit_focus_entered():
	$GridContainer.visible = true
	



#func _on_LineEdit_focus_exited():
	#$GridContainer.visible = false
