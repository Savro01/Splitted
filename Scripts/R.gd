#extends Node
#
#remotesync var test_com = "Test de base"
#
#
#
#var click = false;
#remotesync var electricite = false;
#remotesync var code_porte = 0
#
#
## Declare member variables here. Examples:
## var a = 2
## var b = "text"
#
#
## Called when the node enters the scene tree for the first time.
#func _ready():
#	pass
#
#remote func change_test_com():
#	test_com = "Print Electricien"
#
#remotesync func printData():
#	print(click)
#
#remotesync func setData(data):
#	click = data;
#
#remote func change_electricite():
#	electricite = true
#
#remote func set_code_porte(code):
#	pass
#
## Called every frame. 'delta' is the elapsed time since the previous frame.
##func _process(delta):
##	pass
