extends Node
class_name StateMachine

var states = {}
var current_state

# Called when the node enters the scene tree for the first time.
func _ready():
	for state in get_children():
		if state is State:
			states[state.name] = state
			state.character = get_parent()
			state.fsm = self
	
	if states.size() > 0:
		current_state = states.keys()[0]
		enter_state(current_state)

func _process(delta):
	if states[current_state].is_processing():
		states[current_state].call_deferred("process", delta)

func enter_state(next):
	current_state = next
	states[current_state].call_deferred("enter")

func switch_state(next):
	if current_state == next: return
	states[current_state].call_deferred("exit")
	enter_state(next)
