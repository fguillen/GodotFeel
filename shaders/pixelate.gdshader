/*
Shader from Godot Shaders - the free shader library.
godotshaders.com/shader/pixelate

This shader is under CC0 license. Feel free to use, improve and 
change this shader according to your needs and consider sharing 
the modified result to godotshaders.com.
*/

shader_type canvas_item;

uniform int amount = 40;

void fragment()
{
	vec2 grid_uv = round(UV * float(amount)) / float(amount);
	vec4 color = texture(TEXTURE, grid_uv);
	COLOR = color;
}