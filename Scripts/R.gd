extends Node

remotesync var test_com = "Test de base"

var click = false;
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
remote func change_test_com():
	test_com = "Print Electricien"
	
remotesync func printData():
	print(click)
	
remotesync func setData(data):
	click = data;


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
