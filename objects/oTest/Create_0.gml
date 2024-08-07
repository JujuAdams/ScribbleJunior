hAlign    = fa_right;
vAlign    = fa_top;
font      = fntTest;
fontScale = 1;
width     = 300;
height    = 200;

showHelp = false;

testString = "Sphinx of black quartz,\njudge my vow! ";
testStringColor = 2*"Sphinx of black quartz, [sTestShape]judge my[c_red] vow[/c]! ";

vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_texcoord();
vertexFormat = vertex_format_end();

vertexBuffer = vertex_create_buffer();
vertex_begin(vertexBuffer, vertexFormat);

var _i = 0;
repeat(string_length(testString))
{
    vertex_position_3d(vertexBuffer, x +  0, y +  0, 0); vertex_texcoord(vertexBuffer, 0, 0);
    vertex_position_3d(vertexBuffer, x + 32, y +  0, 0); vertex_texcoord(vertexBuffer, 1, 0);
    vertex_position_3d(vertexBuffer, x +  0, y + 32, 0); vertex_texcoord(vertexBuffer, 0, 1);
    
    vertex_position_3d(vertexBuffer, x + 32, y +  0, 0); vertex_texcoord(vertexBuffer, 1, 0);
    vertex_position_3d(vertexBuffer, x + 32, y + 32, 0); vertex_texcoord(vertexBuffer, 1, 1);
    vertex_position_3d(vertexBuffer, x +  0, y + 32, 0); vertex_texcoord(vertexBuffer, 0, 1);
    
    ++_i;
}

vertex_end(vertexBuffer);
vertex_freeze(vertexBuffer);

stressCount = 1;
startTime = current_time;
fpsRealSmoothed = 1000;
mode = 2;

var _mapstring = " ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789,.-;:_+-*/\\'\"!?~^°<>|(){[]}%&=#@$ÄÖÜäöüß";
spriteFont = font_add_sprite_ext(sSpriteFont, _mapstring, true, 1);
ScribblejrAttachSpritefont(spriteFont, true, 1);

ScribblejrSetCharacterWrap(false);