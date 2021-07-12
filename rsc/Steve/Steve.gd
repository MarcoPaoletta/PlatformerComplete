extends KinematicBody2D
class_name Player
signal anim_pos
var velocity = Vector2(0,0)
var coins = 0
const speed = 400
const gravity = 35
const jump_force = -1100

func _physics_process(delta):
	if Input.is_action_pressed("right"):
		velocity.x = speed
		$Sprite.play("walk")
		$Sprite.flip_h = false
	elif Input.is_action_pressed("left"):
		velocity.x = -speed
		$Sprite.play("walk")
		$Sprite.flip_h = true
	else:
		$Sprite.play("idle")
		
	if not is_on_floor():
		$Sprite.play("air")
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
		$SoundJump.play()
		
	velocity.y = velocity.y + 30 
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.x = lerp(velocity.x,0,0.2)
	if Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("lobby"):
		get_tree().change_scene("res://rsc/TitleMenu/TitleMenu.tscn")
	


func _on_FallZone_body_entered(body):
	g.cs("res://rsc/Screens/GameOver.tscn")
	
func bounce():
	velocity.y = jump_force * 0.7

func ouch(var enemyposx):
	set_modulate(Color(1,0.3,0.3,0.3))
	velocity.y = jump_force * 0.5
	if position.x < enemyposx:
		velocity.x = -800
	elif position.x > enemyposx:
		velocity.x = 800		
	Input.action_release("left")
	Input.action_release("right")
	$Timer.start()
	yield($Timer, "timeout")
	g.cs("res://rsc/Screens/GameOver.tscn")

func _on_HUD_player_anim():
	emit_signal("anim_pos")
	$MusicLevel.stop()
	$AnimationPlayer.play("finish")
	yield($AnimationPlayer,"animation_finished")
	$AnimationPlayer.play_backwards("finish")
	yield($AnimationPlayer, "animation_finished")
	get_tree().change_scene("res://rsc/Screens/YouWin.tscn")
