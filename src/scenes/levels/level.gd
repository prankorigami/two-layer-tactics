extends Node3D
# game board is represented as a dictionary of all units/obstacles
# key is a 3 digit number = yxz
var board = []
	
func init():
	print("readying board")
	board.resize(200)
	board.fill(-1)
	# ROCKS
	board[11] = "ROCK"
	board[9] = "ROCK"
	board[34] = "ROCK"
	board[81] = "ROCK"
	board[63] = "ROCK"
	board[49] = "ROCK"
	
	# MOUNTAIN
	board[54] = "GROUND"
	board[55] = "GROUND"
	board[56] = "GROUND"
	board[64] = "GROUND"
	board[75] = "GROUND"
	board[76] = "GROUND"
	board[77] = "GROUND"
	board[67] = "GROUND"
	board[165] = "GROUND"
	board[166] = "GROUND"
	
	#WATER
	board[15] = "WATER"
	board[16] = "WATER"
	board[24] = "WATER"
	board[25] = "WATER"
	board[26] = "WATER"
	board[27] = "WATER"
	
	
func _on_move_unit(unit, oldpos, newpos):
	board[int(oldpos)] = -1
	board[int(newpos)] = unit

func get_board_pos(pos):
	return board[pos]
	
func has_board_pos(pos):
	if board[pos] is Unit:
		return true
	elif board[pos] is String:
		return true
	else:
		return false
