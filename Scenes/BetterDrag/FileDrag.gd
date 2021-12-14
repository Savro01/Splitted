extends Node2D

var selected

func _ready():
	selected = false

func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		print("clickeeeeed")
		selected = true
		
func _input(event):
	if(event.is_action_released("click")):
		selected = false
