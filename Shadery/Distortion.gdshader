shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture;
uniform sampler2D noise : repeat_enable, filter_linear_mipmap;
uniform float predkosc = 0.1;
uniform float skala = 0.01;
uniform float vector = 1.0;

void fragment() {
	vec2 uv_offset = (texture(noise, SCREEN_UV + vec2(TIME * predkosc, 0.0), vector).rb - texture(noise, SCREEN_UV + vec2(0.0, TIME * predkosc), vector).rb);COLOR = texture(SCREEN_TEXTURE, SCREEN_UV + uv_offset * skala);
}