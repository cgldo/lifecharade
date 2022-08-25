extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export (int) var count = 3
export (int) var time_left = 90
export (String) var word_file = "HarryPotter.json"
var game_text = "Start"
var started = false
var file_path := str("res://assets/data/",  word_file)
var total = 0
var prev = 0
var curr = 0
var wait = 7

# Called when the node enters the scene tree for the first time.
var timer := Timer.new()

var file_data = []


func _ready():
	add_child(timer)
	timer.connect("timeout", self, "_on_timer_timeout")
	timer.wait_time = 1.0
	timer.one_shot = false
	timer.start()
	



var index = 0
func _on_timer_timeout() -> void:
	if(started == true):
		curr = Input.get_accelerometer().z
		if (total == 100 or ((abs(prev + curr) / 2) > 7 and wait <= 0)):
			index += 1
			self.text = file_data[index]
			total = 0
			prev = 0
			wait = 7
		else:
			wait -= 1 
			prev = curr
			total += 1
	if(started == false):
		self.text = str(count)
		count -= 1
	if(count < 0 and started == false):
		self.load()
		count = time_left
		started = true
		self.text = file_data[index]
		timer.wait_time = 0.1
	
		
	
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
	print(file_path)
	file.open(file_path, File.READ)
	file_data = parse_json(file.get_as_text())
	file_data.shuffle()

