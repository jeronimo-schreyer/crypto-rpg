extends Node
class_name State

var fsm
var character

func _ready():
	set_process(true)

func enter():
	pass

func exit():
	pass

func process(_delta):
	pass

func switch_state(next):
	fsm.switch_state(next)
