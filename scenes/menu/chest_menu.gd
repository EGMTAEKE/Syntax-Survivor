extends CanvasLayer

var items = [
	preload("res://scenes/items/chestItems/expItem.tres"),
	preload("res://scenes/items/chestItems/damageItem.tres"),
	preload("res://scenes/items/chestItems/speedItem.tres")
]
var chest = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	chest = get_tree().get_first_node_in_group("chest")
	get_tree().paused = true
	items.shuffle()
	for i in range(3):
		var card = $Panel/HBoxContainer.get_child(i)
		var item = items[i]
		
		card.get_node("NameLabel").text = item.name
		card.get_node("DescLabel").text = item.description
		
		var button = card.get_node("SelectButton")
		button.pressed.connect(func ():paus())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func paus():
	chest.queue_free()
	get_tree().paused = false
	queue_free()
