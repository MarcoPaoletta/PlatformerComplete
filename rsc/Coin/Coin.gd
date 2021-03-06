extends Area2D

signal coin_collected

func _on_Coin_body_entered(body):
	if body is Player:
		emit_signal("coin_collected")
		set_collision_mask_bit(0, false)
		$AnimationPlayer.play("bounce")
		$SoundCoinCollect.play()
		yield($AnimationPlayer,"animation_finished")
		queue_free()
