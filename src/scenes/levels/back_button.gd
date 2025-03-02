extends Button

signal deselect()

func _pressed():
	deselect.emit()
