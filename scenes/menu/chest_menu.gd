extends CanvasLayer

var items = []
var chest = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	chest = get_tree().get_first_node_in_group("chest")
	items = global.items.duplicate()
	var count = min(3,items.size())
	
	get_tree().paused = true
	items.shuffle()
	for i in range(count):
		var card = $Panel/HBoxContainer.get_child(i)
		var curentItem = items[i]
		card.get_node("icon").texture = curentItem.icon
		card.get_node("NameLabel").text = curentItem.name
		card.get_node("DescLabel").text = curentItem.description
		
		var button = card.get_node("SelectButton")
		button.released.connect(func ():paus(curentItem))
	
	for i in range(count,3):
		$Panel/HBoxContainer.get_child(i).visible = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func paus(item):
	var player = get_tree().get_first_node_in_group("players")
	player.apllyItem(item)
	global.items.erase(item)
	chest.queue_free()
	get_tree().paused = false
	queue_free()
