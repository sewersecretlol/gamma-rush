extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

@export var speed = 500.0
var jumpVel = -600.0
var isMoving = false
var maxSpeed = 1100.0
var rotationSpeed = 10.0

var magnetTarget: Node2D = null 
func _ready() -> void:
	global.playerCoords = global_position

func alignToFloor(delta):
	if is_on_floor():
		var normal: Vector2 = get_floor_normal()
		var targetAngle = normal.angle() + PI / 2.0
		
		rotation = lerp_angle(rotation, targetAngle, rotationSpeed * delta)
	else:
		rotation = lerp_angle(rotation, 0, rotationSpeed * delta)


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
	alignToFloor(delta)
