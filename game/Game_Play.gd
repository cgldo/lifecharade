extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export (String, FILE, "*.tscn,*.scn,*.res") var scene_to_load := ""
# Called when the node enters the scene tree for the first time.


var pad = 50
var num = 2
var current = Vector2(0, 0) 
func _ready():
	current.x = (get_viewport().size.x - get_viewport().size.x/2 )/2
	current.y = (get_viewport().size.y - get_viewport().size.y/6)/2
	VisualServer.set_default_clear_color( Color("C9B6E4"))
	for _i in self.get_children ():
		if _i is Button:
			_i.connect("pressed", self, "_on_button_pressed", [_i])
			_i.visible = false
			_i.rect_size  = Vector2(get_viewport().size.x /2,  get_viewport().size.y/6)
			_i.get_node("Label").get_font("font", "Label").size =  get_viewport().size.y / 12
			#_i.get_node("Label").rect_size.x = _i.rect_size.x *.8
			#_i.get_node("Label").rect_size.y = _i.rect_size.y *.8
			current.y = _i.rect_size.y * num + num * pad
			_i.rect_global_position = current
			#_i.get_node("Label").rect_global_position = _i.rect_global_position + (_i.rect_size - _i.get_node("Label").rect_size)/2
			_i.get_node("Label").visible = false
			num += 1

func _on_button_pressed(which : Button):
	if which.name == "Button":
		Global.current_category = ""
		get_tree().change_scene(scene_to_load)
	else:
		$Button.visible = false
		$Button2.visible = false
		$Button/Label.visible = false
		$Button2/Label.visible = false
		$RichTextLabel.unpause()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

var toggle = false
func _on_TextureButton_pressed():
	$Button.visible = true
	$Button2.visible = true
	$Button/Label.visible = true
	$Button2/Label.visible = true
	$RichTextLabel.pause()


