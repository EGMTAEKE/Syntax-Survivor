extends Area2D
var speed = 200
var direction = Vector2.RIGHT
var damage = 50
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	add_to_group("abilities")
	var player = get_tree().get_first_node_in_group("players")
	damage = damage * player.damageMultiplier
	rotation = direction.angle()
	var timer = $Timer
	timer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	position += speed * direction * delta


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemies"):
		body.health -= damage
	if body.health <= 0:
		body.returnToPool()


func _on_timer_timeout() -> void:
	queue_free()
