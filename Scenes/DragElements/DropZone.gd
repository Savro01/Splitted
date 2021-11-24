extends Node2D


func select():
	for child in get_tree().get_nodes_in_group("zone"):
		child.deselect()
	$Folder.set_frame(1)

func deselect():
	$Folder.set_frame(0)
