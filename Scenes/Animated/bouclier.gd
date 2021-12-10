extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var pressed = false
var lock = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(pressed == true):
		var mousepos = get_global_mouse_position()+Vector2($TextureRect.rect_size.x/1.5,$TextureRect.rect_size.y/4)
		$TextureRect.set_global_position(mousepos)
		print($TextureRect.rect_position)

func _on_TextureRect_button_down():
	if (lock == false):
		pressed = true

func _on_TextureRect_button_up():
	pressed = false
	if($TextureRect.rect_position.x > 411 and $TextureRect.rect_position.x < 441):
		print("Entre x1")
		if($TextureRect.rect_position.y > 361.5 and $TextureRect.rect_position.y < 391.5):
			print("Entre y1")
			$TextureRect.rect_position = Vector2(426,376.5)
			lock = true
			send_signal()
	if($TextureRect.rect_position.x > 543 and $TextureRect.rect_position.x < 573):
		print("Entre x2")
		if($TextureRect.rect_position.y > 359.5 and $TextureRect.rect_position.y < 389.5):
			print("Entre y2")
			$TextureRect.rect_position = Vector2(558,374.5)
			lock = true
			send_signal()

signal bouclierLock
func send_signal():
	emit_signal("bouclierLock")

