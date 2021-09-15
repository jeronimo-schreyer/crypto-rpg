tool
extends EditorImportPlugin

func import(source_file, save_path, options, platform_variants, gen_files):
	var mesh = load(source_file) as ArrayMesh
	mesh.lightmap_unwrap(Transform(), options.TexelSize)
	
	if !options.MaterialOverride.empty():
		var material = load(options.MaterialOverride) as Material
		mesh.surface_set_material(0, material)
	
	return ResourceSaver.save("%s.%s" % [save_path, get_save_extension()], mesh, 32)
