extends Camera3D

var deltaCam = Vector3(0, 0 ,0)
var deltaRot = Vector3(0, 0, 0)
var order = [Vector3(0, 5, 5), Vector3(5, 5, 10), Vector3(10, 5, 5), Vector3(5, 5, 0)];
var ordIdx = 0
var currentPos = order[ordIdx]
var yPos = 0
var transLength = 0.75
var moving = false

func _process(delta: float) -> void:
	deltaCam = Vector3(0, 0 ,0)
	deltaRot = Vector3(0, 0, 0)
	var move = false
	# move camera left
	if Input.is_action_just_pressed("move_left") and not moving:
		ordIdx -= 1
		ordIdx = ordIdx if ordIdx > -1 else 3
		deltaCam = order[ordIdx] - currentPos
		deltaRot = Vector3(0, -1 * PI / 2, 0)
		move = true
	# move camera right
	elif Input.is_action_just_pressed("move_right") and not moving:
		ordIdx += 1
		ordIdx = ordIdx if ordIdx < 4 else 0
		deltaCam = order[ordIdx] - currentPos
		deltaRot = Vector3(0, PI / 2, 0)
		move = true
	# move camera up
	elif Input.is_action_just_pressed("move_forward") and yPos == 0 and not moving:
		deltaCam = Vector3(0, 2, 0)
		yPos = 1
		move = true
	# move camera down
	elif Input.is_action_just_pressed("move_backward") and yPos == 1 and not moving:
		deltaCam = Vector3(0, -2, 0)
		yPos = 0
		move = true
		
	# tween the camera
	if move:
		moving = true
		var tween = create_tween().set_parallel(true)
		tween.pause()
		tween.tween_property(self, "position", deltaCam, transLength).as_relative().set_trans(Tween.TRANS_SINE)
		tween.tween_property(self, "rotation", deltaRot, transLength).as_relative().set_trans(Tween.TRANS_SINE)
		tween.play()
		await get_tree().create_timer(transLength).timeout
		currentPos = order[ordIdx]
		moving = false
