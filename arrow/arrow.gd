extends Area2D


var v = 0.0
var d = 0.0
var wiggle := false
var s = 50.0
var current_view = 1


func _ready():

	pass


func _process(delta):

	if wiggle:
		v += delta * s
	else:
		v -= delta * s

	v = clamp(v, 0.0, 10.0)

	$Arrow.position.x = sin(OS.get_ticks_msec() * 0.001 * PI * 2.0) * v

func _input_event(viewport, event, shape_idx):

	if event is InputEventMouseButton  and event.pressed and event.button_index == BUTTON_LEFT:
		swap_view()


func move_in_view():
	var tween = create_tween().set_trans(Tween.TRANS_BACK)
	tween.tween_property(self, "position", Vector2(576 * current_view, 0), 0.75)

func move_out_view():
	var tween = create_tween().set_trans(Tween.TRANS_BACK)
	tween.tween_property(self, "position", Vector2(776 * current_view, 0), 1.0)

func swap_view():

	var tween = create_tween().set_trans(Tween.TRANS_BACK)

	tween.tween_property(self, "input_pickable", false, 0.0)

	tween.tween_property(self, "position", Vector2(776 * current_view, 0), 0.75)
	tween.tween_property($"../../Cut", "following_mouse", !$"../../Cut".following_mouse, 0.0)
	tween.parallel().tween_property(get_parent(), "position", get_parent().position + Vector2(1280, 0) * current_view, 0.75).set_trans(Tween.TRANS_QUART)
	tween.tween_property($Arrow, "flip_h", !$Arrow.flip_h, 0.0)
	current_view *= -1
	tween.tween_property(self, "position", Vector2(776 * current_view, 0), 0.0)
	tween.tween_callback(self, "move_in_view")

	tween.tween_property(self, "input_pickable", true, 0.0)

	return tween


func _on_Arrow_mouse_entered():
	wiggle = true


func _on_Arrow_mouse_exited():
	wiggle = false
