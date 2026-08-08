extends CharacterBody2D
@export var speed = 0
 
@onready var animated_sprite = $AnimatedSprite2D
 
func _physics_process(delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down") 
	velocity = direction * speed
	move_and_slide()
	update_animation(direction)
 
func update_animation(direction):
	
	if direction == Vector2.ZERO:
		animated_sprite.play("static")
	else:
		animated_sprite.play("run")
	
	if direction.x != 0:
		animated_sprite.flip_h = direction.x < 0

 
