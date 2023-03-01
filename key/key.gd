extends Node2D


export(NodePath) var book_path
onready var book = get_node(book_path)
export(NodePath) var key_hole_path
onready var key_hole = get_node(key_hole_path)
export(NodePath) var key_hole_path_offset
onready var key_hole_offset = get_node(key_hole_path_offset)

var following_mouse := false
var mouse_near_keyhole := false
var key_in_hole := false

var tween_moving : SceneTreeTween = null


func _ready():
	pass

func _process(delta):
	if following_mouse:
		global_position = global_position.linear_interpolate(get_global_mouse_position(), delta * 5.0)

	if get_global_mouse_position().distance_to(key_hole_offset.global_position) < 100 and following_mouse:
		global_rotation_degrees = 20
	elif following_mouse:
		global_rotation_degrees = 0

func _unhandled_input(event):

	if Input.is_action_just_pressed("interact") and get_global_mouse_position().distance_to(key_hole_offset.global_position) < 100 and following_mouse:
		open_book()


func go_in_key_hole():
	following_mouse = false

	if tween_moving:
		tween_moving.kill()

	tween_moving = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

	tween_moving.tween_property(self, "global_position", key_hole_offset.global_position, 0.5)
	tween_moving.parallel().tween_property(self, "global_rotation", key_hole_offset.global_rotation, 0.5)
	tween_moving.tween_property(self, "z_index", -1, 0.0)
	tween_moving.tween_property(self, "global_position", key_hole.global_position, 0.5)
	tween_moving.tween_property(self, "key_in_hole", true, 0.0)

func go_out_key_hole():

	if tween_moving:
		tween_moving.kill()

	tween_moving = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)
	
	tween_moving.tween_property(self, "key_in_hole", false, 0.0)
	tween_moving.tween_property(self, "global_position", key_hole_offset.global_position, 0.5)
	tween_moving.parallel().tween_property(self, "global_rotation", 0.0, 0.5)
	tween_moving.tween_property(self, "z_index", 0, 0.0)
	tween_moving.tween_property(self, "following_mouse", true, 0.0)
	
	return

func open_book():
	following_mouse = false
	mouse_near_keyhole = false
	key_in_hole = false

	if tween_moving:
		tween_moving.kill()

	tween_moving = create_tween().set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

	tween_moving.tween_property(self, "global_position", key_hole_offset.global_position, 0.5)
	tween_moving.parallel().tween_property(self, "global_rotation", key_hole_offset.global_rotation, 0.5)
	tween_moving.tween_property(self, "z_index", -1, 0.0)
	tween_moving.tween_property(self, "global_position", key_hole.global_position, 0.5)
	tween_moving.tween_property(self, "key_in_hole", true, 0.0)
	
	tween_moving.tween_property($AudioStreamPlayer, "playing", true, 0.0)
	tween_moving.tween_property($Key, "texture", preload("res://key/key_2.png"), 0.0)
	tween_moving.tween_property($Key, "texture", preload("res://key/key.png"), 0.5)
	tween_moving.tween_property(self, "global_position", key_hole_offset.global_position, 0.5)
	tween_moving.tween_callback(book, "open")
	tween_moving.tween_property(self, "z_index", 0, 0.0)
	tween_moving.tween_property(self, "global_position", Vector2(200, 600), 0.5)
	tween_moving.parallel().tween_property(self, "global_rotation", 0.0, 0.5)



func follow_mouse():
	following_mouse = true
