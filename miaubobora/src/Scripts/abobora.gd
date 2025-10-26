extends RigidBody2D

@onready var area2d = $Area2D

@onready var timer = $Area2D/Timer
	
func _on_timer_timeout() -> void:
	$Area2D/AreaCollider.queue_free()
	$".".queue_free()
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name.contains("Gato"):
		timer.start()
		$AnimatedSprite2D.play("Hit")
		
