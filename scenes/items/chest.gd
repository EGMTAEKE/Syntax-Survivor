extends Area2D
var player = null
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	add_to_group("chest")
	player = get_tree().get_first_node_in_group("players")
	var ArrowIndicatorScene = preload("res://scenes/items/arrow_indicator.tscn")
	var ArrowIndicator = ArrowIndicatorScene.instantiate()
	player.add_child(ArrowIndicator)
	ArrowIndicator.targetChest(self)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var count = global.items.size()
	if count == 0:
		queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body == player:
		var chestOpen = preload("res://scenes/menu/chest_menu.tscn").instantiate()
		add_child(chestOpen)
