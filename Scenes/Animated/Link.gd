class_name Link
extends Node2D

onready var line = $Control/Line2D
var item1 = null
var item2 = null
var point1 = Vector2()
var point2 = Vector2()
var item2String = ""

func _ready():
	$Control/Node1.set_global_position(item1.get_global_position())
	$Control/Node2.set_global_position(item2.get_global_position())
	line.add_point($Control/Node1.get_position()+$Control/Node1.rect_size/2)
	line.add_point($Control/Node2.get_position()+$Control/Node2.rect_size/2)

func get_class():
	return "Link"
