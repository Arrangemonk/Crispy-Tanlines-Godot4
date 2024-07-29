shader_type spatial;
uniform sampler2D iChannel0;
const float pi = 3.141592653589;

float Mask(float x){
    x= x -.5;
    return .5+sign(.5*(.25 -x*x))*.5;
}

vec3 colorramp2(float inx)
{   
    inx = clamp(inx,.0001,.9999);
    float x = 2.* inx * inx;
     vec3 col = (.4 + .4*cos((1.-x)*vec3(4,2,1)))*Mask(x) 
     + (.4 + .4*cos((x-1.)*vec3(2,1.25,2)))*Mask(x-1.);
     col = mix(vec3(.4,.7,.6),mix(col, col*col,.5),.5);
     return col;
}

void vertex()
{
	VERTEX += vec3(sin(TIME * 0.2),0.0,sin(TIME * 0.5)*0.1 + sin(TIME * 0.25)*0.05);
}

void fragment()
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = (1.0-UV.xy *vec2(2,1)) + vec2(sin(TIME * -0.2),0);
	uv = uv * vec2(2,1);
	float iTime = sin(TIME * 0.07)*10.0;
    float height = uv.y +0.08;
       float val = texture(iChannel0,uv + vec2(0.15*sin(iTime* -0.1),0.2*sin(iTime*0.75))).x * 0.6;
       val += texture(iChannel0,uv *0.8 + vec2(0.25*sin(iTime* 0.1 + val),0.1*sin(iTime* 0.25 + val))).x*0.4;
       val += texture(iChannel0,uv *0.8 + vec2(0.125*sin(iTime* 0.15 * val),0.5*sin(iTime* 0.3 + val))).x*0.2;
       val = val * height * 2.0;
       val += 0.5* clamp(pow(0.0001,1.0-height),0.0,1.0);
           float result = val > (pow(height*1.15,1.1) * 0.75) ? 0.0 : val;
           result = result < (height *0.7) ? 1.0 : 0.0;
           result = val > 0.99 ? 0.0: result;
           result = 1.0 - result;
    // Output to screen
    ALBEDO = result >= 1.0 ? vec3(1.0,1.0,1.0) : colorramp2(uv.y -0.35);
	ALPHA = clamp(pow(UV.y,2) * 2000.0,0,1.0);
}