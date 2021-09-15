tool
extends EditorPlugin

var plugin
var pluginObject := preload("res://addons/obj_importer/plugin.gd")

func _enter_tree():
	plugin = pluginObject.new()
	add_import_plugin(plugin)


func _exit_tree():
	if plugin:
		remove_import_plugin(plugin)
		plugin = null
