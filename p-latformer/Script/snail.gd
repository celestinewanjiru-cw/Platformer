extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if body.has_method("take_damage"):
			body.take_damage(global_position)
