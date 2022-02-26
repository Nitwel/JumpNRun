extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var gravity = 1500
var jump_strenght = 500
var velocity = Vector2(0, 0)
var speed = 10000

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	
	var move_direction = get_move_direction()
	
	velocity.x = move_direction.x * speed * delta
	
	if is_on_floor():
		velocity.y = 0
	else:
		velocity.y += gravity * delta
		
	if move_direction.y != 0:
		velocity.y = -jump_strenght
	
	move_and_slide(velocity, Vector2.UP)

func get_move_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("move_right") - Input.get_action_strength("move_left"),
		-Input.get_action_strength("move_up") if is_on_floor() and Input.is_action_just_pressed("move_up") else 0.0
	)
