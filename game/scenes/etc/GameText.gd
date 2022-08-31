extends RichTextLabel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var count = 3
var time_left = (1/.075) * Global.time
export (bool) var rush = false
var game_text = "Start"
var started = false
var file_path := "res://assets/data/"
var total = 0
var prev = 0
var curr = 0
var wait = 7
var result = ""
var timer := Timer.new()
var file_data = []
var done = false

func _ready():
	file_path += Global.current_category + ".json"
	self.get("custom_fonts/bold_font").size = get_viewport().size.y/6
	self.bbcode_enabled = true
	#self.rect_min_size = Vector2(get_viewport().size.x *.8,  get_viewport().size.y *.9)
	add_child(timer)
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.wait_time = 1.0
	timer.one_shot = false
	timer.start()
	
	
var contant = (1/.075)


var index = 0
var color = false
func _on_timer_timeout() -> void:
	if time_left <= 0:
		$end.play()
		done = true
		#print(result)
		timer.stop()
		VisualServer.set_default_clear_color( Color("C9B6E4"))
		self.bbcode_text ="[b]"+ result+ "[/b]"
		self.get("custom_fonts/bold_font").size = get_viewport().size.y/10
		self.get_parent().get_node("Button").rect_global_position.y = get_viewport().size.y - self.get_parent().get_node("Button").rect_size.y
		self.get_parent().get_node("Button").visible = true
		self.get_parent().get_node("Button/Label").visible = true
		self.get_parent().get_node("TextureButton").visible = false
	if(started == true):
		time_left -= 1
		if wait > 0 :
			wait -= 1
		else:
			if not color:
				VisualServer.set_default_clear_color( Color("C9B6E4"))
				color = true
				self.bbcode_text = "[center][b][color=white]%s[/color][/b][/center]" % file_data[index]
			get_parent().get_node("Label").text = str(int(time_left /contant ))
			curr = Input.get_accelerometer().z
			if ((rush and total == 100) or (wait <= 0 and (abs(prev + curr) / 2) > 7)):
				index += 1
				if(total == 100 or (prev + curr) / 2 < -7):
					VisualServer.set_default_clear_color( Color("FFB3B3"))
					self.bbcode_text = "[center][b][color=white]%s[/color][/b][/center]" % "Pass"
					$wrong.play()
					result += "[color=#F29191]%s    [/color]"% file_data[index]
				else:
					VisualServer.set_default_clear_color( Color("90C8AC"))
					self.bbcode_text = "[center][b][color=white]%s[/color][/b][/center]" % "Correct"
					$correct.play()
					result += "[color=#C2DED1]%s    [/color]"% file_data[index]
				total = 0
				prev = 0
				wait = 10
				color = false
			else:
				prev = curr
				total += 1
				
	if(started == false):
		self.bbcode_text = "[center][b][color=white]%s[/color][/b][/center]" % str(count)
		$start.play()
		count -= 1
	if(count < 0 and started == false):
		self.load()
		started = true
		self.bbcode_text = "[center][b][color=white]%s[/color][/b][/center]" % file_data[index]
		timer.wait_time = 0.075
		get_parent().get_node("Label").text = str(int(time_left / contant))
		get_parent().get_node("Label").visible = true
	
		
	
# Called every frame. 'delta' is the elapsed time since the previous frame.


func save():
	var file = File.new()
	file.open("user://file_data.json", File.WRITE)
	file.store_line(to_json(file_data))
	file.close()

func load():
	var file = File.new()
	if !file.file_exists(file_path):
		return "file does not exist: '%s'" % file_path
	file.open(file_path, File.READ)
	file_data = parse_json(file.get_as_text())
	file_data.shuffle()

func pause():
	timer.paused = true
func unpause():
	timer.paused = false

func _input(event):
	if done and event is InputEventScreenDrag:
		self.margin_top += event.get_relative().y
