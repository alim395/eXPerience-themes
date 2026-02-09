@tool
class_name E_ElementManger
extends EditorPlugin

var nodes
var libraries

const NODE_DIR = "res://addons/Elementum/Downloads/Node/"
const LIB_DIR = "res://addons/Elementum/Downloads/Library/"

func on():
	nodes = DirAccess.get_files_at(NODE_DIR)
	if nodes != null:
		for node in nodes:
			var file = FileAccess.open(NODE_DIR.path_join(node), FileAccess.READ)
			var code = file.get_as_text()
			file.close()
			if code.find("#extends") == -1: continue
			var base = code.split("#extends")[1].split("\n")[0]
			while base.find(" ") != -1:
				base = base.erase(base.find(" "))
			var script = GDScript.new()
			script.source_code = code
			add_custom_type(node.split(".")[0], base, script, load("res://addons/Elementum/icon.svg"))
	libraries = DirAccess.get_files_at(LIB_DIR)
	if libraries == null: return
	for lib in libraries:
		add_autoload_singleton(lib.split(".")[0], LIB_DIR.path_join(lib))

func off():
	if nodes != null:
		for node in nodes:
			var file = FileAccess.open(NODE_DIR.path_join(node), FileAccess.READ)
			var code = file.get_as_text()
			file.close()
			remove_custom_type(node.split(".")[0])
	if libraries == null: return
	for lib in libraries:
		remove_autoload_singleton(lib.split(".")[0])
