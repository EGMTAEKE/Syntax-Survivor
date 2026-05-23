extends CharacterBody2D

var speed = 45 
var direction = Vector2.ZERO
var player = null
var health = 100
var maxHealth = 100
var damage = 20
var push = false

@export var flagDead = false

@onready var enemy_pool = get_parent()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("players")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if not push:
		enemyMove()
	move_and_slide()
	
func enemyMove():
	direction = (player.global_position - global_position).normalized()
	velocity = direction * speed

	
func returnToPool():
	health = maxHealth
	if flagDead == false:
		call_deferred("ret")
		flagDead = true
		$Timer.start()
	

func ret():
	var exp_scene = preload("res://scenes/items/exp.tscn")
	var expIns = exp_scene.instantiate()
	expIns.global_position = global_position
	get_parent().add_child(expIns)

func _on_attack_area_body_entered(body: Node2D) -> void:
	var pushPower = null
	if body == player or body.is_in_group("enemies"):
				
		if body == player:
			pushPower = 0.2
			player.takeDamage(damage)
		if not push:
			if body.is_in_group("enemies"):
				pushPower = 1
			push = true
			var directionPush = (global_position - body.global_position).normalized()
			velocity = directionPush * (speed * pushPower)
			await get_tree().create_timer(0.2).timeout
			velocity = Vector2.ZERO
			push = false
		


func _on_timer_timeout() -> void:
	enemy_pool.returnEnemy(self) # Replace with function body.
	$Timer.stop()
