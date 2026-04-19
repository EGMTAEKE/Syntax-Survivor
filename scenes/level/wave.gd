extends Node2D

@onready var enemyPool = $"../poolEnemy"
@onready var spawnCooldown = $Timer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	spawnCooldown.wait_time = 2
	spawnCooldown.start() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func getEnemyIsPool():
	var enemy = enemyPool.getEnemy()
	if enemy:
		enemy.visible = true
		enemy.process_mode = Node.PROCESS_MODE_INHERIT
		enemy.position = getSpawnPosition()
		
func getSpawnPosition():
	var player = get_tree().get_first_node_in_group("players")
	if player:
		var angle = randf_range(0, PI * 2)
		var radius = 400
		return player.global_position + (Vector2(cos(angle),sin(angle)) * radius)


func _on_timer_timeout() -> void:
	getEnemyIsPool() # Replace with function body.
