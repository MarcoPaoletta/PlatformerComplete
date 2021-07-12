extends Position2D

func _on_Steve_anim_pos():
	position = Vector2(20,20)
	set_modulate(Color(0.369598, 1, 0.113281))
	$Portal/AnimationPlayer.stop()
