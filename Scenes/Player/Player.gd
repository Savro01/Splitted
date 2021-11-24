class_name Player
extends KinematicBody2D


var speed = 100
var velocity = Vector2.ZERO
var isAndroid = OS.get_name() == "Android"

func _ready():
	for c in $Joystick.get_children():
			c.visible = true
		
master func printdata(puppettext):
	print(puppettext)

func _physics_process(delta):
	if(isAndroid):
		if Input.is_action_pressed("move_right"):
			velocity.x = speed
		elif Input.is_action_pressed("move_left"):
			velocity.x = -speed
		else:
			velocity.x = 0
		if Input.is_action_pressed("move_up"):
			velocity.y = -speed
		elif Input.is_action_pressed("move_down"):
			velocity.y = speed
		else:
			velocity.y = 0
		if velocity.length() > 0:
			velocity = velocity.normalized() * speed
		move_and_slide(velocity)
		if Input.is_action_pressed("move_right"):
			$BodyElectricien.playing = true
			$BodyElectricien.flip_h = false
			$BodyElectricien.animation = "right"
			$BodyCommandant.playing = true
			$BodyCommandant.flip_h = false
			$BodyCommandant.animation = "right"
		elif Input.is_action_pressed("move_down"):
			$BodyCommandant.playing = true
			$BodyElectricien.playing = true
			$BodyElectricien.animation = "down"
			$BodyCommandant.animation = "down"
		elif Input.is_action_pressed("move_up"):
			$BodyCommandant.playing = true
			$BodyElectricien.playing = true
			$BodyElectricien.animation = "up"
			$BodyCommandant.animation = "up"
		elif Input.is_action_pressed("move_left"):
			$BodyCommandant.playing = true
			$BodyElectricien.playing = true
			$BodyElectricien.animation = "right"
			$BodyElectricien.flip_h = true
			$BodyCommandant.animation = "right"
			$BodyCommandant.flip_h = true
		else:
			$BodyCommandant.playing = false
			$BodyElectricien.playing = false


func _on_Joystick_use_move_vector(move_vector):
	if(!isAndroid):
		move_and_slide(move_vector * speed)
		####     LEFT 
		if move_vector.x < -0.75 and move_vector.y > -0.75:
			$BodyCommandant.flip_h = true
			$BodyCommandant.playing = true
			$BodyCommandant.animation = "right"		
			$BodyElectricien.flip_h = true
			$BodyElectricien.playing = true
			$BodyElectricien.animation = "right"
		####     RIGHT 
		elif move_vector.x > 0.75 and move_vector.x > move_vector.y:
			$BodyCommandant.flip_h = false
			$BodyCommandant.playing = true
			$BodyCommandant.animation = "right"		
			$BodyElectricien.flip_h = false
			$BodyElectricien.playing = true
			$BodyElectricien.animation = "right"
		####     UP 
		elif move_vector.y < 0 :
			$BodyCommandant.playing = true
			$BodyCommandant.animation = "up"		
			$BodyElectricien.playing = true
			$BodyElectricien.animation = "up"
		####     DOWN 
		elif move_vector.y > 0 and move_vector.x > -0.75:
			$BodyCommandant.playing = true
			$BodyCommandant.animation = "down"		
			$BodyElectricien.playing = true
			$BodyElectricien.animation = "down"
		else:
			$BodyCommandant.playing = false
			$BodyElectricien.playing = false
			$BodyCommandant.set_frame(1)
			$BodyElectricien.set_frame(1)
			
