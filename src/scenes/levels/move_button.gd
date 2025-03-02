extends Button

func _ready() -> void:
	%SelectionSquare.connect("select_unit", _on_unit_selection)

func _on_unit_selection(position):
	grab_focus()

func _pressed():
	%SelectionSquare.moving = true
	%OptionsUI.visible = false
