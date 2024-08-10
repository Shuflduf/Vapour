extends Window

signal submitted
@onready var textbox: TextEdit = $VBoxContainer/Textbox

var text: String

func _on_confirm_pressed() -> void:
	text = textbox.text
	submitted.emit()
	hide()


func _on_cancel_pressed() -> void:
	_on_close_requested()


func _on_close_requested() -> void:
	textbox.text = text
	hide()
