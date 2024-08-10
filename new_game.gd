extends PopupPanel

@onready var file_dialog: FileDialog = %FileDialog
@onready var game: Control = $MarginContainer/HBoxContainer/Game

func _on_button_pressed() -> void:
	file_dialog.show()


func _on_file_dialog_file_selected(path: String) -> void:
	game.app_icon = path


func _on_line_edit_text_changed(new_text: String) -> void:
	game.name = new_text
