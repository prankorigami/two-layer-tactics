extends Node3D
# label the rotation of the camera such that the arrow keys stay the same direction
# 0 = default (S)
# 1 = E
# 2 = N
# 3 = W 
var curr_rotate = 0
var unit_selected = false
var moving = false
var attacking = false
@onready var game_board = get_tree().root.get_node("Level")

signal select_unit(position)
signal move_unit(position)


func _ready() -> void:
	%Camera.connect("camera_move", _on_camera_rotate)
	%Back.connect("deselect", _on_deselect)

func _process(delta: float) -> void:
	var move = Vector3(0,0,0)
			
	if (not unit_selected) or (unit_selected and moving) or (unit_selected and attacking):
		if Input.is_action_just_pressed("select"):
			var curr_x = position.x - 0.5
			var curr_y = 0 if position.y < 1 else 1
			var curr_z = position.z - 0.5
			var pos = int(curr_y * 100 + curr_x * 10 + curr_z)
			if not unit_selected and game_board.has_board_pos(pos):
					select_unit.emit(pos)
					unit_selected = true
			if unit_selected and moving and not game_board.has_board_pos(pos):
				move_unit.emit(pos)
				unit_selected = false
				moving = false

		# move selector left
		elif Input.is_action_just_pressed("select_left"):
			move.z -= 1
		# move selector right
		elif Input.is_action_just_pressed("select_right"):
			move.z += 1
		# move selector up
		elif Input.is_action_just_pressed("select_up"):
			move.x += 1
		# move selector down
		elif Input.is_action_just_pressed("select_down"):
			move.x -= 1
		elif Input.is_action_just_pressed("select_layer_change"):
			move.y += 1.5 if position.y < 1 else -1.5
		
		# rotate the movement if the camera is moved
		if curr_rotate == 1:
			if move.x != 0:
				move.z = move.x * -1
				move.x = 0
			elif move.z != 0:
				move.x = move.z
				move.z = 0
		if curr_rotate == 2:
			move.x *= -1
			move.z *= -1
		if curr_rotate == 3:
			if move.x != 0:
				move.z = move.x
				move.x = 0
			elif move.z != 0:
				move.x = move.z * -1
				move.z = 0
			
		# move the selection square
		position += move
		
		# clamp selection square to grid
		if position.x > 9.5:
			position.x = 9.5
		if position.x < 0:
			position.x = 0.5
		if position.z > 9.5:
			position.z = 9.5
		if position.z < 0:
			position.z = 0.5

# note down the camera's new rotation
func _on_camera_rotate(direction):
	curr_rotate += direction
	if curr_rotate == -1:
		curr_rotate = 3
	if curr_rotate == 4:
		curr_rotate = 0
		
func _on_deselect():
	unit_selected = false
