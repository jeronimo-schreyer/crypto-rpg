extends HBoxContainer

export (Array) var items

onready var slots : Array

# Called when the node enters the scene tree for the first time.
func _ready():
	for c in get_children():
		slots.push_back(c)
	
	for i in range(items.size()):
		add_to_belt(i, items[i])

func add_to_belt(index, id):
	assert(index < slots.size())
	slots[index].set_item(id)

func _input(event):
	if event is InputEventKey and event.pressed:
		match event.scancode:
			KEY_1:
				slots[0]._on_pressed()
			KEY_2:
				slots[1]._on_pressed()
			KEY_3:
				slots[2]._on_pressed()
			KEY_4:
				slots[3]._on_pressed()
			KEY_5:
				slots[4]._on_pressed()
			KEY_6:
				slots[5]._on_pressed()
