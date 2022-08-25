extends HBoxContainer


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (String, FILE, "*.tscn,*.scn,*.res") var scene_to_load := ""
export var transition_speed_seconds := -1.0
export var fade_sound := false
var current = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	for b in self.get_children():
		b.connect("pressed", self, "_on_button_pressed", [b])


# Called every frame. 'delta' is the elapsed time since the previous frame
	
	
var disable = false
func _input(event):
	if event is InputEventScreenDrag:
		self.margin_left += event.get_relative().x

func _on_button_pressed(which : Button):
	if(current == which.name):
		if scene_to_load == null || scene_to_load == "":
			printerr("TransitionButton: no scene to load.")
			return
			
		if !_can_transition():
			return
		
		TransitionMgr.transition_to(scene_to_load, transition_speed_seconds, fade_sound)
	else:
		current = which.name
		print(current)
		
		
func _can_transition() -> bool:
	return true
		
