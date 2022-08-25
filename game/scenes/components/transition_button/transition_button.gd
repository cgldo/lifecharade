class_name TransitionButton
extends Button


export (String, FILE, "*.tscn,*.scn,*.res") var scene_to_load := ""
export var transition_speed_seconds := -1.0
export var fade_sound := false
export var grab_focus_on_start := false


func _ready():
	if grab_focus_on_start and focus_mode != FOCUS_NONE:
		grab_focus()


# override this to control if button will complete transition
# or do something before the transition happens
func _can_transition() -> bool:
	return true
