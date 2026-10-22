extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var speed = 500.0
var jumpVel = -500.0
var isMoving = false
var maxSpeed = 1100



func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		sprite.play("inAir")
	if isMoving:
		speed += 8
		speed = clamp(speed, 500, maxSpeed)
	else:
		speed -= 16
		speed = clamp(speed, 500, maxSpeed)
	#print(speed)
		
		

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jumpVel

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
		sprite.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		if is_on_floor():
			sprite.play("default")
	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true
	if direction != 0:
		isMoving = true
	else:
		isMoving = false
	

	move_and_slide()
