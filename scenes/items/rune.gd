extends Area2D

var runesType = [
	Color.CRIMSON,
	Color.AQUA,
	Color.GREEN_YELLOW
] 

var player = null

func _ready() -> void:
	add_to_group("runes")
	runesType.shuffle()
	$Polygon2D.color = runesType[0]
	player = get_tree().get_first_node_in_group("players")
	
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_body_entered(body: Node2D) -> void:
	if body == player:
		var quest = preload("res://scenes/menu/rune_quest.tscn").instantiate()
		add_child(quest)
		

	
