shader_type canvas_item;
render_mode unshaded;

uniform sampler2D dissolve_texture : hint_albedo;
uniform float amount : hint_range(0.0, 2.5) = 1.0;
uniform float x : hint_range(0.0, 1.0) = 0.5;
uniform float y : hint_range(0.0, 1.0) = 0.5;

uniform vec4 color : hint_color  = vec4(1.0);

float circle(in vec2 _st, in vec2 _pos, in float _radius){
	vec2 dist = _st-_pos;
	return step(_radius, dot(dist,dist)*4.0);
}

void fragment()
{
	vec4 noise_texture = texture(dissolve_texture, UV);
	COLOR = vec4(color.rgb, circle(UV, vec2(x, y), amount));
}