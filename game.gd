extends Control

@export var pic_size = 144
@onready var label: Control = $LabelContainer/Label

var label_visible = false
var tween: Tween

func tween_label(out: bool):
	if tween:
		await tween.finished

	tween = get_tree().create_tween().set_trans(Tween.TRANS_CIRC)
	tween.tween_property(label, "position:x", pic_size * int(out), 0.3)\
			.set_ease(Tween.EASE_OUT if out else Tween.EASE_IN)

	tween.finished.connect(func():
		tween = null)


func _on_label_container_mouse_entered() -> void:
	label_visible = true
	tween_label(true)


func _on_label_container_mouse_exited() -> void:
	label_visible = false
	tween_label(false)
