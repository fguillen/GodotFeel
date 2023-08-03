// From: https://godotshaders.com/shader/led-dot-matrix-shader/

shader_type canvas_item;

uniform float size = 64.0; // dots size | using int is ok
uniform vec4 background_color : source_color;

void fragment() {
	vec2 ratio = vec2(1.0, TEXTURE_PIXEL_SIZE.x / TEXTURE_PIXEL_SIZE.y); // make sure the dots are going to be 1:1
	vec2 pixelated_uv = floor(UV * size * ratio) / (size * ratio); // pixelates the UV, first multiply with size so it can be rounded to integer then divide it with the same value so your computer can see it and multiply with ratio to fix stretching
	float dots = length(fract(UV * size * ratio) - vec2(0.5)) * 2.0; // fracts the UV to make it loop, substract it by half then turn it into circle (using length) and finally multiply with 2 for smaller circle
	dots = (1.0 - dots) * 10.0; // invert the dot then make it look hard so soft circle is no more
	dots = clamp(dots, 0.0, 1.0); // limit the value to 1.0, otherwise it would add your pixel's brightness instead of being a border (this is because some of it's value is above 1.0)
	COLOR = mix(background_color, texture(TEXTURE, pixelated_uv), dots); // mix the dots with the texture
}