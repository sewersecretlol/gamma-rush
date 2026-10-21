extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

var speed = 400.0
var jumpVel = -400.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jumpVel

	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * speed
		sprite.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		sprite.play("default")

	move_and_slide()
