extends CharacterBody2D

@export var speed = 200.0
@onready var animation_player: AnimatedSprite2D = $AnimatedSprite2D

func on_ready():
		print("On ready player")
func _physics_process(_delta):
	var direction = Vector2.ZERO
		
	if Input.is_action_pressed("move_left"):
		direction.x = -1
	elif Input.is_action_pressed("move_right"):
		direction.x = 1
	elif Input.is_action_pressed("move_up"):
		direction.y = -1
	elif Input.is_action_pressed("move_down"):
		direction.y = 1
			
	velocity = direction*speed
	move_and_slide()
	change_animation(direction)
			
func change_animation(direction:Vector2):
	if direction == Vector2.ZERO:
		animation_player.play("idle")
		return
			
	if direction.x !=0:
		animation_player.flip_h = direction.x < 0
		animation_player.play("left")
						
	elif direction.y < 0:
		animation_player.play("up")
	else: animation_player.play("down")
						
				

const  Bomba = preload("res://scenes/bomba/rigid_body_2d.tscn")
var explosionBomba = preload("res://scenes/bomba/explosionBomba.tscn")

func _input(event):
		if event.is_action_pressed("Bomba"):
			var bomba = Bomba.instantiate()
			bomba.position = position
			get_parent().add_child(bomba)
			explode(bomba)
			
func explode(bomba:RigidBody2D):
		await get_tree().create_timer(2).timeout
		var explosion = explosionBomba.instantiate()
		explosion.position = bomba.position
		bomba.get_parent().add_child(explosion)
		explosion.restart()
		bomba.queue_free()
		
		await get_tree().create_timer(0.05).timeout
		for area in explosion.get_node("Area2D").get_overlapping_areas():
			if area.is_in_group("bloque_destructible"):
				area.get_parent().queue_free()
			
		await get_tree().create_timer(1).timeout
		explosion.queue_free()

func _on_area_2d_body_exited(body: Node2D) -> void:
		if body.get_class() == "RigidBody2D": 
			body.collision_layer = 1
		pass # Replace with function body.


@warning_ignore("unused_parameter")
func _on_area_2d_body_entered(body: Node2D) -> void:
		pass # Replace with function body.
