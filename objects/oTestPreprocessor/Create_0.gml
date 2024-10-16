ScribblejrSetPreprocesor(function(_string)
{
    _string = string_replace_all(_string, "[mouse_x]", string(mouse_x));
    
    return _string;
})

element = ScribblejrExt("mouse_x = [mouse_x].");