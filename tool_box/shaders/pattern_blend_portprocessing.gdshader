/*
	Inspired from here: https://godotshaders.com/snippet/blending-modes/
*/

shader_type canvas_item;

uniform vec4 modulate_color: source_color = vec4(1, 1, 1, 1);

uniform sampler2D pattern_texture : source_color, repeat_enable;
uniform float pattern_scale : hint_range(0.1, 10.0, 0.1) = 1.0;
uniform vec2 pattern_offset = vec2(0.0, 0.0);
uniform bool inverted = false;

uniform int blend_mode : hint_range(1, 13) = 1;

uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

// blend_mode = 1
vec4 multiply(vec4 base, vec4 blend) {
	return base * blend;
}

// blend_mode = 2
vec4 screen(vec4 base, vec4 blend) {
	return 1.0 - (1.0 - base) * (1.0 - blend);
}

// blend_mode = 3
vec4 darken(vec4 base, vec4 blend) {
	return min(base, blend);
}

// blend_mode = 4
vec4 lighten(vec4 base, vec4 blend) {
	return max(base, blend);
}

// blend_mode = 5
vec4 difference(vec4 base, vec4 blend) {
	return abs(base - blend);
}

// blend_mode = 6
vec4 exclusion(vec4 base, vec4 blend) {
	return base + blend - 2.0 * base * blend;
}

// blend_mode = 7
vec4 overlay(vec4 base, vec4 blend) {
	vec4 limit = step(0.5, base);
	return mix(2.0 * base * blend, 1.0 - 2.0 * (1.0 - base) * (1.0 - blend), limit);
}

// blend_mode = 8
vec4 hard_light(vec4 base, vec4 blend) {
	vec4 limit = step(0.5, blend);
	return mix(2.0 * base * blend, 1.0 - 2.0 * (1.0 - base) * (1.0 - blend), limit);
}

// blend_mode = 9
vec4 soft_light(vec4 base, vec4 blend) {
	vec4 limit = step(0.5, blend);
	return mix(2.0 * base * blend + base * base * (1.0 - 2.0 * blend), sqrt(base) * (2.0 * blend - 1.0) + (2.0 * base) * (1.0 - blend), limit);
}

// blend_mode = 10
vec4 color_dodge(vec4 base, vec4 blend) {
	return base / (1.0 - blend);
}

// blend_mode = 11
vec4 linear_dodge(vec4 base, vec4 blend) {
	return base + blend;
}

// blend_mode = 12
vec4 color_burn(vec4 base, vec4 blend) {
	return 1.0 - (1.0 - base) / blend;
}

// blend_mode = 13
vec4 linear_burn (vec4 base, vec4 blend) {
	return base + blend - 1.0;
}



vec4 invert(vec4 base) {
	return vec4(1.0 - base.rgb, base.a);
}

vec4 modulate(vec4 base, vec4 blend) {
	return multiply(base, blend);
}


void fragment() {
	vec4 pattern_color = texture(pattern_texture, ((SCREEN_UV + pattern_offset) / pattern_scale));
	
	if(inverted) {
		pattern_color = invert(pattern_color);
	}
	
	pattern_color = modulate(pattern_color, modulate_color);
	
	vec4 screen_color = texture(screen_texture, SCREEN_UV);
	
	switch (blend_mode) {
		case 1:
			screen_color = multiply(screen_color, pattern_color);
			break;
		case 2:
			screen_color = screen(screen_color, pattern_color);
			break;
		case 3:
			screen_color = darken(screen_color, pattern_color);
			break;
		case 4:
			screen_color = lighten(screen_color, pattern_color);
			break;
		case 5:
			screen_color = difference(screen_color, pattern_color);
			break;
		case 6:
			screen_color = exclusion(screen_color, pattern_color);
			break;
		case 7:
			screen_color = overlay(screen_color, pattern_color);
			break;
		case 8:
			screen_color = hard_light(screen_color, pattern_color);
			break;
		case 9:
			screen_color = soft_light(screen_color, pattern_color);
			break;
		case 10:
			screen_color = color_dodge(screen_color, pattern_color);
			break;
		case 11:
			screen_color = linear_dodge(screen_color, pattern_color);
			break;
		case 12:
			screen_color = color_burn(screen_color, pattern_color);
			break;
		case 13:
			screen_color = linear_burn(screen_color, pattern_color);
			break;

	}
	
	COLOR = screen_color;
}

