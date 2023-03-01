extends Sprite

var following_mouse := false

func _ready():
	rotation_degrees = 20
	pass


func _process(delta):
	if following_mouse:
		global_position = global_position.linear_interpolate(get_global_mouse_position(), delta * 5.0)

	if Input.is_action_just_released("orient_right"):
		rotation_degrees += delta * 600.0
	elif Input.is_action_pressed("or"):
		rotation_degrees += delta * 300.0
	if Input.is_action_just_released("orient_left"):
		rotation_degrees -= delta * 600.0
	elif Input.is_action_pressed("ol"):
		rotation_degrees -= delta * 300.0
