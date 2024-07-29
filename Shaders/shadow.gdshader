shader_type spatial;
const float pi = 3.141592653589;

float Mask(float x){
    x= x -.5;
    return .5+sign(.5*(.25 -x*x))*.5;
}

void vertex()
{
	VERTEX += vec3(sin(TIME * 0.2),-0.001,sin(TIME * 0.5 -pi*0.25)*0.1 + sin(TIME * 0.25-pi*0.25)*0.05);
}

void fragment()
{
    ALBEDO = vec3(0,0,0);
	ALPHA = clamp(pow(UV.y,1.5) * 10.0,0,0.4);
}