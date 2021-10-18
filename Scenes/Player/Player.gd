class_name Player
extends KinematicBody2D

var speed = 100
#var velocity = Vector2.ZERO


var velocity: Vector2 = Vector2.ZERO

func _physics_process(delta):
	var new_velocity: Vector2 = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		new_velocity.x += speed
	if Input.is_action_pressed("move_left"):
		new_velocity.x -= speed
	if Input.is_action_pressed("move_up"):
		new_velocity.y -= speed
	if Input.is_action_pressed("move_down"):
		new_velocity.y += speed
	self.velocity = new_velocity
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
	move_and_slide(velocity)
	if Input.is_action_just_pressed("move_right"):
		$BodyElectricien.flip_h = false
		$BodyElectricien.animation = "right"
		$BodyCommandant.flip_h = false
		$BodyCommandant.animation = "right"
	if Input.is_action_just_pressed("move_down"):
		$BodyElectricien.animation = "down"
		$BodyCommandant.animation = "down"
	if Input.is_action_just_pressed("move_up"):
		$BodyElectricien.animation = "up"
		$BodyCommandant.animation = "up"
	if Input.is_action_just_pressed("move_left"):
		$BodyElectricien.animation = "right"
		$BodyElectricien.flip_h = true
		$BodyCommandant.animation = "right"
		$BodyCommandant.flip_h = true
