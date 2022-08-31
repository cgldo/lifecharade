extends Control


export (String, FILE, "*.tscn,*.scn,*.res") var scene_to_load := ""
export var transition_speed_seconds := -1.0
export var fade_sound := false



var pad = 50
var num = 0
var current = Vector2(0, 0) 
func _ready():
	randomize()
	current.y = (get_viewport().size.y - get_viewport().size.y *.65)/2
	VisualServer.set_default_clear_color( Color("F9F9F9"))
	for _i in self.get_children ():
		_i.connect("pressed", self, "_on_button_pressed", [_i])
		_i.rect_size  = Vector2(get_viewport().size.x /4,  get_viewport().size.y *.65)
		current.x = _i.rect_size.x * num + num * pad
		_i.rect_global_position = current
		for text in _i.get_children():
			text.get_font("font", "Label").size =  get_viewport().size.y / 12
			#text.rect_size = _i.rect_size *.8
			#text.rect_global_position = _i.rect_global_position + (_i.rect_size - text.rect_size)/2
		num += 1

var disable = false
func _input(event):
	if event is InputEventScreenDrag:
		self.margin_left += event.get_relative().x

func _on_button_pressed(which : Button):
	if(Global.current_category == which.name):
		if scene_to_load == null || scene_to_load == "":
			printerr("TransitionButton: no scene to load.")
			return
			
		if !_can_transition():
			return
		#$global.orient = OS.get_screen_orientation()
		var temp = int(self.get_parent().get_node("LineEdit").text)
		if temp > 0:
			Global.time = temp
		get_tree().change_scene(scene_to_load)
		#TransitionMgr.transition_to(scene_to_load, transition_speed_seconds, fade_sound)
	else:
		Global.current_category = which.name
		
		
func _can_transition() -> bool:
	return true
		

