extends Node
class_name State

var fsm
var character : Player

func enter():
	pass

func exit():
	pass

func process(_delta):
	pass

func switch_state(next):
	fsm.switch_state(next)
