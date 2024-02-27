extends CharacterBody2D
var power : float = 25500
@onready var bird_texture = $bird_texture
@onready var flap = $flap
var birds : Array = ["bird_yellow", "bird_blue", "bird_red"]
var bird = randi_range(0,2)
@export var can_die :bool
var dead: bool = false
var gravity = Vector2(0,0)
signal die

func _ready():
	pass

func _physics_process(delta):
	if dead:
		rotate(PI/2)
	velocity += gravity * delta
	if !dead:
		if Input.is_action_just_pressed("jump"):
			$bird_texture.play(birds[bird])
			velocity = Vector2.ZERO
			velocity.y -= power * delta
			flap.play()

	look_at(Vector2(global_position.x+50,velocity.y))
	rotation = clamp(rotation,deg_to_rad(-10),deg_to_rad(90))
	global_position.y = clamp(global_position.y,10,1000)
	move_and_slide()

func _on_area_2d_body_entered(body):
	if can_die:
		$hit.play(0.05)
		$die.play(0.35)
		die.emit()
		bird_texture.stop()
		dead = true

func reload():
	dead = false
	bird_texture.play(birds[randi_range(0,2)])
	global_position.y = 357


