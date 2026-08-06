extends CharacterBody2D

@export var speed = 200.0

func on_ready():
	print("On ready player")
func _physics_process(_delta):
	var direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = direction * speed
	move_and_slide()

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
	await get_tree().create_timer(1).timeout
	explosion.queue_free()
	


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.get_class() == "RigidBody2D": 
		body.collision_layer = 1
	pass # Replace with function body.
