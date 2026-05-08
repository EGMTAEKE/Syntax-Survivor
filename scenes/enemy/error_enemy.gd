extends CharacterBody2D

var speed = 80 
var direction = Vector2.ZERO
var player = null
var health = 100
var maxHealth = 100
var damage = 20

var flagDead = false

@onready var enemy_pool = get_parent()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("players")
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
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
	if body == player:
		player.takeDamage(damage)
		


func _on_timer_timeout() -> void:
	enemy_pool.returnEnemy(self) # Replace with function body.
	$Timer.stop()
