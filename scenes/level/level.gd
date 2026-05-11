extends Node2D
var rune
var timeStart = 0
var player 
func _ready() -> void:
	player = get_tree().get_first_node_in_group("players")
	
	timeStart = Time.get_ticks_msec()

func elapsedTime():
	var time = Time.get_ticks_msec() - timeStart
	return time / 1000

func _process(_delta: float) -> void:
	$CanvasLayer/TimeLive.text = str(elapsedTime())


func _on_spawn_rune_timeout() -> void:
	var runeScene = preload("res://scenes/items/rune.tscn")
	rune = runeScene.instantiate()
	rune.position = getSpawnPosition(300)
	add_child(rune)
	print("руна появилась")
	await get_tree().create_timer(60).timeout
	if is_instance_valid(rune):
		rune.queue_free()
	
func getSpawnPosition(radius: float):
	if player:
		var angle = randf_range(0, PI * 2)
		return player.global_position + (Vector2(cos(angle),sin(angle)) * radius)
	


func _on_spawn_chest_timeout() -> void:
	var chest_scen = preload("res://scenes/items/chest.tscn")
	var chest = chest_scen.instantiate()
	chest.position = getSpawnPosition(1000)
	add_child(chest)
	print("cундук")
	if global.items.size() == 0:
		$spawnChest.stop()
