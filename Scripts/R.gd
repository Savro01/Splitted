extends Node

var test_com = "Test de base"

var click = false;
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	
remotesync func printData():
	print(click)
	
remotesync func setData(data):
	click = data;


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
