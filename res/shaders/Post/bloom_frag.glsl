#version 410

uniform sampler2D colorTexture;

in vec2 uv;
out vec4 fragColor;

uniform float u_threshold = 0.8;
void main()
{
    float XYoffset = 1.0 / textureSize(colorTexture, 0).x;

    vec4 text = texture2D( colorTexture , uv );
   
    float brightness = dot( text.rgb , vec3( 0.2126 , 0.7152 , 0.0722 ) );
    //make sure that only the brightest sports (over 0.8) will take into the calculation of blur
    if ( brightness > u_threshold)
    {
        //Gaussian blur
        //But unlike the this example:https://learnopengl.com/code_viewer.php?code=advanced-lighting/blur&type=fragment
        //The result of this will blur in diagonal
        vec4 result  = texture2D( colorTexture , vec2( uv.x - 4.0* XYoffset , uv.y - 4.0 * XYoffset )) * 0.0162162162
        + texture2D( colorTexture , vec2( uv.x - 3.0* XYoffset , uv.y - 3.0* XYoffset )) * 0.0540540541
        + texture2D( colorTexture , vec2( uv.x - 2.0* XYoffset , uv.y - 2.0* XYoffset )) * 0.1216216216
        + texture2D( colorTexture , vec2( uv.x - 1.0* XYoffset , uv.y - 1.0* XYoffset )) * 0.1945945946
        + texture2D( colorTexture , vec2( uv.x , uv.y ))                                 * 0.2270270270
        + texture2D( colorTexture , vec2( uv.x + 1.0* XYoffset , uv.y + 1.0* XYoffset )) * 0.1945945946
        + texture2D( colorTexture , vec2( uv.x + 2.0* XYoffset , uv.y + 2.0* XYoffset )) * 0.1216216216
        + texture2D( colorTexture , vec2( uv.x + 3.0* XYoffset , uv.y + 3.0* XYoffset )) * 0.0540540541
        + texture2D( colorTexture , vec2( uv.x + 4.0* XYoffset , uv.y + 4.0* XYoffset )) * 0.0162162162; 
        //making the result look brighter by multiplied it by a constant
        fragColor = vec4( result .rgb * 1.2, 1.0 );
    }
    else
       fragColor = vec4(text.rgb,1.0);

}
