extends Control

@export var themes : Array[Theme]
@export var themeButton : OptionButton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if themes != null:
		if themes.size() > 1:
			for t in themes:
				themeButton.add_item(t.get_name())
				print(t.get_name())

func _on_themes_button_item_selected(index: int) -> void:
	var t = themes[index]
	if t != null:
		theme = t
