extends CanvasLayer

@export_file('*.json') var file_path

@onready var background = $NinePatchRect

var dialogue = []
var current_dialogue_id = 0

signal dialogue_ended
	

func start():
	visible = true
	dialogue = load_dialogue()
	current_dialogue_id = 0
	$NinePatchRect/name.text = dialogue[0]['name']
	$NinePatchRect/text.text = dialogue[0]['text']
	$NinePatchRect/TextureRect.texture = load(dialogue[0]['img'])
	
	
func load_dialogue():
	var file = FileAccess.open(file_path, FileAccess.READ)
	var json = JSON.new()
	json.parse(file.get_as_text())
	return json.get_data()
	
func _input(event):
	if event.is_action_pressed("ui_accept"):
		next_script()

func next_script():
	current_dialogue_id +=1
	
	if current_dialogue_id >= len(dialogue):
		visible = false
		emit_signal('dialogue_ended')
		return
	$NinePatchRect/name.text = dialogue[current_dialogue_id]['name']
	$NinePatchRect/text.text = dialogue[current_dialogue_id]['text']
	$NinePatchRect/TextureRect.texture = load(dialogue[current_dialogue_id]['img'])
