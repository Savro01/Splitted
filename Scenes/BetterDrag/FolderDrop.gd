extends Node2D

var empty = true
var color

func setToBin():
	$Bin.visible = true
	$Folder.visible = false
	
func setEmpty(val):
	empty = val
	if(empty == true):
		$Bin.set_frame(0)
		$Folder.set_frame(0)
	else:
		$Bin.set_frame(1)
		$Folder.set_frame(1)

func setFilled():
	$Bin.set_frame(2)
	
func setColor(c):
	color = c
	$Folder.modulate = c
