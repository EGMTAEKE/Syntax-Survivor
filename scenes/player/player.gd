extends CharacterBody2D

var speed = 150
var direction = Vector2.ZERO
var anim
var target = null
var health = 100
var maxHealth = 100
var experience = 0
var maxExp = 100

@onready var shootTimer = $ShootTimer
@onready var spawn = $Spawn
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	cheak() 
	$ProgressBar.value = 100
	$experienceBar.value = 0


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	Movement()
	direction = direction.normalized()
	velocity = speed * direction
	
	
	move_and_slide()

func Movement():
	direction.x = Input.get_action_strength("RightMove")- Input.get_action_strength("LeftMove")
	direction.y = Input.get_action_strength("DownMove")- Input.get_action_strength("UpMove")
	updateAnim()

func updateAnim():
	anim = $AnimatedSprite2D
	if direction.x == 0:
		anim.stop()
	elif direction.x > 0:
		anim.flip_h = false
		anim.play("catRun")
	elif  direction.x < 0:
		anim.flip_h = true
		anim.play("catRun")
	


func _on_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies") and target == null:
		target = body
		shootTimer.start()
		#print("враг в зоне")

func cursorshoot():
	var cursor_scene = preload("res://scenes/cursor/cursor.tscn")
	var cursor = cursor_scene.instantiate()
	cursor.global_position = spawn.global_position
	cursor.direction = (target.global_position - global_position).normalized()
	
	get_parent().add_child(cursor)
	


func _on_shoot_timer_timeout() -> void:
	cursorshoot() # Replace with function body.


func _on_detection_body_exited(body: Node2D) -> void:
	if body == target:
		target = null
		shootTimer.stop()
		print("враг не в зоне")
		cheak()

func cheak():
	for body in $detection.get_overlapping_bodies():
		if body.is_in_group("enemies") and target == null:
			target= body
			shootTimer.start()

func takeDamage(damageValue):
	health -= damageValue
	$ProgressBar.value = health
	print("урон получен")
	if health <= 0:
		print("Смерть")
		die()

func takeExp(expValue):
	experience += expValue
	if experience >= maxExp:
		print("Уровень повышен")
		experience = 0
		maxExp = maxExp + 200
		$experienceBar.max_value = maxExp 
		maxHealth = maxHealth + 20
		$ProgressBar.max_value = maxHealth
		health = maxHealth
		levelUpMenuOpen()
		
	$experienceBar.value = experience
	$ProgressBar.value = health
	
	

func levelUpMenuOpen():
	var menu = preload("res://scenes/menu/level_up_menu.tscn").instantiate()
	get_tree().root.add_child(menu)
	#get_tree().paused = true
	

func die():
	call_deferred("backToMenu")
	
func backToMenu():
	get_tree().change_scene_to_file("res://scenes/menu/menu.tscn")

func apllyAbility(ability):
	if ability.speedBonus != 0:
		$ShootTimer.wait_time = $ShootTimer.wait_time * (1 - ability.speedBonus)
	if ability.healthBonus != 0:
		maxHealth += ability.healthBonus 
		health = maxHealth
		$ProgressBar.max_value = maxHealth
		$ProgressBar.value = health
	else:
		pass
