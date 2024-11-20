extends Area2D
signal hit
@export var speed=400
var screen_size
var player_size



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	screen_size = get_viewport_rect().size
	player_size=$CollisionShape2D.shape.get_rect().size
	#hide()	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("Right"):
		velocity.x += 1
	if Input.is_action_pressed("Left"):
		velocity.x -= 1
	if Input.is_action_pressed("Down"):
		velocity.y += 1
	if Input.is_action_pressed("Up"):
		velocity.y -= 1
	if velocity.length()>0:
		velocity = velocity.normalized()*speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()
	position += velocity * delta
	position=position.clamp(Vector2.ZERO+player_size/2,screen_size-player_size/2)
	$AnimatedSprite2D.flip_v=velocity.y>0
	if velocity.x !=0:
		$AnimatedSprite2D.animation="Walk"
		$AnimatedSprite2D.flip_h = velocity.x<0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation="Up"
		$AnimatedSprite2D.flip_h=false
		
		


func _on_body_entered(body: Node2D) -> void:
	hide()
	hit.emit()
	$CollisionShape2D.set_deferred("disabled",true)
	
	
	
	 # Replace with function body.
