extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_controls_pressed() -> void:
	get_tree().change_scene_to_file("res://src/scenes/UI/Help Menu/controls.tscn")


func _on_lore_pressed() -> void:
	get_tree().change_scene_to_file("res://src/scenes/UI/Help Menu/lore.tscn")


func _on_back_pressed() -> void:
	get_tree().change_scene_to_file("res://src/scenes/UI/main menu/main_menu.tscn")
