/*
Variant from: https://godotshaders.com/shader/pixelate-2/
*/

shader_type canvas_item;
uniform int pixel_size : hint_range(1, 100, 1) = 4 ;
uniform sampler2D screen_texture : hint_screen_texture, repeat_disable, filter_nearest;

void fragment()
{
	ivec2 size = textureSize(screen_texture, 0);
	
	int xRes = size.x;
	int yRes = size.y;
	
	float xFactor = float(xRes) / float(pixel_size);
	float yFactor = float(yRes) / float(pixel_size);
	
	float grid_uv_x = round(SCREEN_UV.x * xFactor) / xFactor;
	float grid_uv_y = round(SCREEN_UV.y * yFactor) / yFactor;
	
	vec4 text = texture(screen_texture, vec2(grid_uv_x, grid_uv_y));
	
	COLOR = text;
}