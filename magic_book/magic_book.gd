extends Node2D


func go_on_table():

	var tween = create_tween().set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

	var s = 0.75

	tween.tween_property(self, "position", Vector2.ZERO, s)
	tween.parallel().tween_property(self, "rotation_degrees", -4.0, s)
	#set_trans(Tween.TRANS_BOUNCE).set_ease(Tween.EASE_OUT).

func open():
	
	var tween = create_tween().set_trans(Tween.TRANS_BACK)

	var s = 1.0 

	tween.tween_property(self, "position", Vector2(220, 0), s)
	tween.parallel().tween_property(self, "rotation_degrees", 0.0, s)
	tween.tween_property(self, "position", Vector2.ZERO, 0).set_delay(0.5)
	tween.tween_property($MagicBook, "texture", preload("res://magic_book/magic_book_open.png"), 0)
	tween.tween_callback(self, "show_page", ["1"])
	
#	tween.tween_callback(self, "show_page", ["2"])
#	tween.tween_callback(self, "show_page", ["3"])
#	tween.tween_callback(self, "show_validate", ["1"])
#	tween.tween_callback(self, "show_validate", ["2"])
#	tween.tween_callback(self, "show_validate", ["3"])

func show_page(var n):

	var tween = create_tween()
	var page = get_node("Pages/Page" + n)

	tween.tween_property(get_node("Pages/Page" + n), "visible", true, 0.0)
	page.material.set_shader_param("dissolve_value", 0.0)
	tween.tween_property(page.material, "shader_param/dissolve_value", 1.0, 4.0)
	tween.parallel().tween_callback($"../Camera2D/Arrow", "move_in_view")

	return

func show_validate(var n):

	var tween = create_tween()
	var page = get_node("Pages/Validate" + n)

	tween.tween_property(page, "visible", true, 0.0)
	page.material.set_shader_param("dissolve_value", 0.0)
	tween.tween_property(page.material, "shader_param/dissolve_value", 1.0, 4.0)
