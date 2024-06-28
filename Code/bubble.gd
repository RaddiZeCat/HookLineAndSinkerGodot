extends Sprite2D

var rng = RandomNumberGenerator.new()
var time:int


func _ready():
	time = rng.randf_range(0,4)
	await get_tree().create_timer(time).timeout
	$AnimationPlayer.play("blubb")

func _on_animation_player_animation_finished(anim_name):
	time = rng.randf_range(3,7)
	await get_tree().create_timer(time).timeout
	$AnimationPlayer.play("blubb")
