extends Node3D
# label the rotation of the camera such that the arrow keys stay the same direction
# 0 = default (S)
# 1 = E
# 2 = N
# 3 = W 
var curr_rotate = 0

func _ready() -> void:
	%Camera.connect("camera_move", _on_camera_rotate)

func _process(delta: float) -> void:
	var move = Vector3(0,0,0)
	# move selector left
	if Input.is_action_just_pressed("select_left"):
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
	if curr_rotate == 0:
		curr_rotate = 3
	if curr_rotate == 4:
		curr_rotate = 0
