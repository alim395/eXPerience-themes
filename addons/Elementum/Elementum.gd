@tool
class_name Elementum
extends EditorPlugin

var panel

func _enter_tree() -> void:
	panel = preload("res://addons/Elementum/Panel.tscn").instantiate()
	add_control_to_bottom_panel(panel, "Elementum")
	panel.hide()
	E_ElementManger.new().on()

func _exit_tree()-> void:
	E_ElementManger.new().off()
	remove_control_from_bottom_panel(panel)
