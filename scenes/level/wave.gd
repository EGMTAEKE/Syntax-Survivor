extends Node2D

@onready var enemyPool = $"../poolEnemy"
@onready var spawnCooldown = $Timer
var waveHP = 1
var waveDS = 1.0 
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawnCooldown.wait_time = 2
	spawnCooldown.start()
	$damageSpeed.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func getEnemyIsPool():
	var enemy = enemyPool.getEnemy()
	if enemy:
		enemy.maxHealth = enemy.maxHealth * waveHP
		enemy.damage = enemy.damage * waveDS
		enemy.speed = enemy.speed * waveDS
		enemy.visible = true
		enemy.process_mode = Node.PROCESS_MODE_INHERIT
		enemy.position = getSpawnPosition()
		print(enemy.maxHealth)
		
func getSpawnPosition():
	var player = get_tree().get_first_node_in_group("players")
	if player:
		var angle = randf_range(0, PI * 2)
		var radius = 400
		return player.global_position + (Vector2(cos(angle),sin(angle)) * radius)


func _on_timer_timeout() -> void:
	if enemyPool.checkPoolAlive() == true:
		print("все мертвыв")
		$Timer.stop()
		await get_tree().create_timer(5).timeout
		enemyPool.reset()
		waveHP += 1
		$Timer.start()
	getEnemyIsPool() # Replace with function body.


func _on_damage_speed_timeout() -> void:
	waveDS += 0.1
