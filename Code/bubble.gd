extends Sprite2D

var rng = RandomNumberGenerator.new()
var time:int


func _ready():
	$AnimationPlayer.play("blubb")

func _on_animation_player_animation_finished(anim_name):
	time = rng.randf_range(3,7)
	print(time)
	await get_tree().create_timer(time).timeout
	$AnimationPlayer.play("blubb")
