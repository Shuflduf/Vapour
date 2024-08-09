extends Control

@export var pic_size = 144
@onready var label: Control = $LabelContainer/Label

var label_visible = false

func _on_label_container_mouse_entered() -> void:
	print("Enter")
	label_visible = true
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_OUT)
	tween.tween_property(label, "position:x", pic_size, 0.3)


func _on_label_container_mouse_exited() -> void:
	print("Leave")
	label_visible = false
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CIRC).set_ease(Tween.EASE_IN)
	tween.tween_property(label, "position:x", 0, 0.3)


