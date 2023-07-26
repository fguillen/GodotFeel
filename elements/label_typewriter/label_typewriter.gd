class_name LabelTypewriter
extends Label

@export var key_delay_seconds := 0.1
@export var auto_perform := false

@onready var timer: Timer = $Timer

var _text_to_display

signal key()
signal finished()


func _ready():
	_text_to_display = self.get_text()
	self.set_text("")
	timer.wait_time = key_delay_seconds
	
	if auto_perform:
		perform()


func perform() -> void:
	timer.start()


func _on_timer_timeout():
	if len(_text_to_display) > len(self.get_text()):
		var new_text = self.get_text() + _text_to_display[len(self.get_text())]
		self.set_text(new_text)
		key.emit()
	else:
		finished.emit()
		timer.stop()
