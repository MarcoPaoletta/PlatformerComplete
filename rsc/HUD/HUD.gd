extends CanvasLayer
signal player_anim
export var finish = 0
var coins = 0
var enemies = 0

func _ready():
	$Coins.text = String(coins)
	$Enemies.text = String(enemies)
	
func _on_coin_collected():
	coins = coins + 1
	_ready()


func _on_enemy_dead():
	enemies += 1
	_ready()


func _on_Portal_body_entered(body):
	if body is Player:
		if coins == finish:
			emit_signal("player_anim")
