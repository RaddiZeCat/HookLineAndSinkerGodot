extends Sprite2D

@onready var animator = $AnimationPlayer

func _ready():
	animator.play("Idle")
