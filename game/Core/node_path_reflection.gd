extends Node
# https://dfaction.net/author/rabbit/

var _cachedNodePathVariables = {}

func CacheNodePathVariables(node):
	var links = []
	var propertyList = node.get_property_list()

	for property in propertyList:
		if property.type == TYPE_NODE_PATH and property.usage & PROPERTY_USAGE_SCRIPT_VARIABLE:
			links.append(property.name)

	_cachedNodePathVariables[node.get_script()] = links
	return links

func LinkNodePaths(node):
	var nodeScript = node.get_script()
	var links

	if _cachedNodePathVariables.has(nodeScript):
		links = _cachedNodePathVariables[nodeScript]
	else:
		links = CacheNodePathVariables(node)

	for link in links:
		
		
		var propertyValue = node.get(link)

		if propertyValue:
			node.set(link, node.get_node(propertyValue))
		else:
			node.set(link, null)

	return true
