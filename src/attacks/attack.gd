extends Node
class_name Attack

# attack name
var attackName
# the type of attack
# 0 = single hit, 1 = aoe
var attackType
# the damage the attack does
var damage
# the area of effect of the attack if its an aoe attack
# if a single hit, its the options available
var aoe

func _init(att_name, type, dam, aoe) -> void:
	self.attackName = att_name
	self.attackType = type
	self.damage = dam
	self.aoe = aoe
