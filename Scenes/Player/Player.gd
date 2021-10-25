class_name Player
extends KinematicBody2D


var speed = 100
var velocity = Vector2.ZERO


func _physics_process(delta):
	
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
