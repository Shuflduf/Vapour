extends Control

@export var pic_size = 128
@onready var label: Control = $Control

var label_visible = false

func _on_mouse_entered() -> void:
	label_visible = true
	var tween = get_tree().create_tween()
	tween.tween_property(label, "position:x", pic_size, 0.3)


func _on_mouse_exited() -> void:
	label_visible = false
	var tween = get_tree().create_tween()
	tween.tween_property(label, "position:x", 0, 0.3)
