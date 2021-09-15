tool
extends "importer.gd"

func get_importer_name():
	return "obj.importer"

func get_visible_name():
	return "Jairo's OBJ Importer as Mesh"
	
func get_recognized_extensions():
	return ["obj"]
	
func get_save_extension():
	return "mesh"
	
func get_resource_type():
	return "Mesh"

func get_option_visibility(_option, _options):
	return true
	
func get_import_options(_preset):
	return [
		{
			"name": "Texel Size",
			"default_value": 0.1
		},
		{
			"name": "Material Override",
			"default_value": "",
			"property_hint": PROPERTY_HINT_FILE
		},
	]

func get_preset_count():
	return 0

func get_preset_name(preset):
	return "Default"
