shader_type canvas_item;

uniform vec4 color: source_color;
uniform float percent: hint_range(0.0, 1.0, 0.1);

void fragment() {
	vec4 texture_color = texture(TEXTURE, UV);
	vec4 mixed_color = vec4(color.r, color.g, color.b, texture_color.a);
	vec4 final_color = mix(texture_color, mixed_color, percent);
	COLOR = final_color;
}
