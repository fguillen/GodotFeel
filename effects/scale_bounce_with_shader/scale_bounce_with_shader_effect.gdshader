shader_type canvas_item;

uniform sampler2D pattern: repeat_enable;
uniform float speed = 1.0;
uniform float size_scale = 1.0;
uniform vec4 color: source_color;

void fragment() {
	vec2 centered_uv = UV * 2.0 - 1.0;
	vec2 scaled_uv = centered_uv * size_scale;
	scaled_uv = scaled_uv * 0.5 + 0.5;
	vec2 moving_uv = vec2(scaled_uv.x - (TIME*speed), scaled_uv.y);
	vec4 in_tex = texture(pattern, moving_uv);
	COLOR = in_tex * color;
}