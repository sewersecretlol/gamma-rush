extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var t = create_tween()
		t.tween_property(body, "global_position", global_position, 0.2)
		global.inBalloon = true
		print("alfdjas")
		
		
