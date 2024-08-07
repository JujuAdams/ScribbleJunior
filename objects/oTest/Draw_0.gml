var _string = "";
_string += Concat("Test Mode=", mode, "\n");
_string += Concat("Budget=", ScribblejrGetBudget(), "us, used=", ScribblejrGetBudgetUsed(), "us\n");
_string += Concat("Draw Count=", floor(stressCount), ", fps=", fps, ", fps_real (smoothed)=", floor(fpsRealSmoothed), "\n");
_string += Concat("Box=", width, " x ", height, ", font scale=", fontScale, "\n");

if (showHelp)
{
    _string += "\n";
    _string += "\n";
    _string += Concat("Scribblejr ", __SCRIBBLEJR_VERSION, " Tester\n");
    _string += "\n";
    _string += "F1 = toggle help\n";
    _string += "1-7 = change test mode\n";
    _string += "up/down = increase/decrease draw count\n";
    _string += "enter = change draw count to match 60FPS (roughly)\n";
    _string += "space = use native drawing\n";
    _string += "\n";
    _string += "left click = change bounding box (smooth)\n";
    _string += "ctrl+arrow keys = change bounding box (1px)\n";
    _string += "right click = move text\n";
    _string += "Q/A = increase/decrease font scale\n";
    _string += "shift+arrow keys = change alignment\n";
}
else
{
    _string += "F1 = toggle help\n";
}

draw_rectangle(x, y, x + width, y + height, true);

var _sdfEffects = {
    dropShadowEnable: true,
    dropShadowSoftness: 16*mouse_x/room_width,
    dropShadowOffsetX: 10,
    dropShadowOffsetY: 10,
    dropShadowColour: c_red,
    dropShadowAlpha: 1,
};

var _limitWidth = max(10, width);
switch(mode)
{
    case 1:
        repeat(stressCount)
        {
            ScribblejrDrawNative(x, y, testString, un, un, hAlign, vAlign, font, fontScale);
        }
    break;
    
    case 2:
        repeat(stressCount)
        {
            var _element = Scribblejr(testString, hAlign, vAlign, font, fontScale);
            _element.Draw(x, y, un, un, _sdfEffects);
        }
        
        draw_rectangle_color(x, y, x + _element.GetWidth(), y + _element.GetHeight(),
                             c_lime, c_lime, c_lime, c_lime, true);
    break;
    
    case 3:
        repeat(stressCount)
        {
            var _element = ScribblejrShrink(testString, hAlign, vAlign, font, fontScale, _limitWidth, height);
            _element.Draw(x, y, un, un, _sdfEffects);
        }
        
        draw_rectangle_color(x, y, x + _element.GetWidth(), y + _element.GetHeight(),
                             c_lime, c_lime, c_lime, c_lime, true);
    break;
    
    case 4:
        repeat(stressCount)
        {
            var _element = ScribblejrFit(testString, hAlign, vAlign, font, fontScale, _limitWidth, height);
            _element.Draw(x, y, un, un, _sdfEffects);
        }
        
        draw_rectangle_color(x, y, x + _element.GetWidth(), y + _element.GetHeight(),
                             c_lime, c_lime, c_lime, c_lime, true);
    break;
    
    case 5:
        repeat(stressCount)
        {
            var _element = ScribblejrExt(testStringColor, hAlign, vAlign, font, fontScale);
            _element.Draw(x, y, un, un, _sdfEffects);
        }
        
        draw_rectangle_color(x, y, x + _element.GetWidth(), y + _element.GetHeight(),
                             c_lime, c_lime, c_lime, c_lime, true);
    break;
    
    case 6:
        repeat(stressCount)
        {
            var _element = ScribblejrShrinkExt(testStringColor, hAlign, vAlign, font, fontScale, _limitWidth, height);
            _element.Draw(x, y, un, un, _sdfEffects);
        }
        
        draw_rectangle_color(x, y, x + _element.GetWidth(), y + _element.GetHeight(),
                             c_lime, c_lime, c_lime, c_lime, true);
    break;
    
    case 7:
        repeat(stressCount)
        {
            var _element = ScribblejrFitExt(testStringColor, hAlign, vAlign, font, fontScale, _limitWidth, height);
            _element.Draw(x, y, un, un, _sdfEffects);
        }
        
        draw_rectangle_color(x, y, x + _element.GetWidth(), y + _element.GetHeight(),
                             c_lime, c_lime, c_lime, c_lime, true);
    break;
}

draw_set_colour(c_white);
draw_set_alpha(0.8);
draw_rectangle(10, 10, string_width(_string) + 30, string_height(_string) + 30, false);
draw_set_colour(c_black);
draw_set_alpha(1);
draw_text(20, 20, _string);
draw_set_colour(c_white);











