// Feather disable all

/// @param size
/// @param cellSize

function TexturePackrat(_size, _cellSize) constructor
{
    size     = _size;
    cellSize = _cellSize;
    
    cellCount = ceil(size / cellSize);
    packrat = new Packrat(cellCount, cellCount);
    
    surface = surface_create(size, size);
    surface_set_target(surface);
    draw_clear_alpha(c_black, 0);
    surface_reset_target();
    
    dictionary = {};
    boxArray = [];
    
    static DrawText = function(_x, _y, _string)
    {
        var _cellSize = cellSize;
        
        var _box = dictionary[$ _string];
        if (_box == undefined)
        {
            var _boxArray = boxArray;
            
            var _width  = ceil(string_width( _string)/_cellSize);
            var _height = ceil(string_height(_string)/_cellSize);
            
            _box = packrat.FindAndPlace(_width, _height);
            if (_box == undefined)
            {
                var _timer = get_timer();
                array_sort(_boxArray, function(_a, _b)
                {
                    return sign(_b.lastDraw - _a.lastDraw);
                });
                show_debug_message("Sort took " + string((get_timer() - _timer)/1000) + "ms");
                
                var _timer = get_timer();
                var _i = array_length(_boxArray)-1;
                repeat(array_length(_boxArray))
                {
                    var _foundBox = _boxArray[_i];
                    if (current_time - _foundBox.lastDraw > 100)
                    {
                        array_delete(_boxArray, _i, 1);
                        packrat.Remove(_foundBox);
                    }
                    
                    --_i;
                }
                show_debug_message("Prune took " + string((get_timer() - _timer)/1000) + "ms");
                
                _box = packrat.FindAndPlace(_width, _height);
                if (_box == undefined)
                {
                    var _timer = get_timer();
                    packrat.Defragment();
                    show_debug_message("Defrag took " + string((get_timer() - _timer)/1000) + "ms");
                    
                    var _timer = get_timer();
                    var _newSurface = surface_create(size, size);
                    show_debug_message("New surface took " + string((get_timer() - _timer)/1000) + "ms");
                    
                    //Move
                    var _timer = get_timer();
                    
                    var _oldMatrix = matrix_get(matrix_world);
                    matrix_set(matrix_world, matrix_build(0,0,0,   0,0,0,   _cellSize, _cellSize, 1));
                    surface_set_target(_newSurface);
                    gpu_set_blendmode_ext(bm_one, bm_zero);
                    
                    var _i = 0;
                    repeat(array_length(_boxArray))
                    {
                        var _foundBox = _boxArray[_i];
                        draw_surface_part(surface, _foundBox.left, _foundBox.top, _foundBox.width, _foundBox.height, _foundBox.left, _foundBox.top);
                        ++_i;
                    }
                    
                    gpu_set_blendmode(bm_normal);
                    surface_reset_target();
                    matrix_set(matrix_world, _oldMatrix);
                    
                    show_debug_message("Surface copy took " + string((get_timer() - _timer)/1000) + "ms");
                    
                    surface_free(surface);
                    surface = _newSurface;
                    
                    _box = packrat.FindAndPlace(_width, _height);
                    
                    if (_box == undefined)
                    {
                        var _targetArea = _width*_height;
                        var _areaRemoved = 0;
                        var _i = array_length(_boxArray)-1;
                        repeat(array_length(_boxArray))
                        {
                            var _foundBox = _boxArray[_i];
                            
                            array_delete(_boxArray, _i, 1);
                            _areaRemoved += _foundBox.width*_foundBox.height;
                            packrat.Remove(_foundBox);
                            if (_areaRemoved >= _targetArea) break;
                            
                            --_i;
                        }
                        
                        _box = packrat.FindAndPlace(_width, _height);
                        if (_box == undefined) return;
                    }
                }
            }
            
            surface_set_target(surface);
            
            gpu_set_blendmode(bm_subtract);
            draw_rectangle_color(_box.left*_cellSize, _box.top*_cellSize,
                                 (_box.right+1)*_cellSize-1, (_box.bottom+1)*_cellSize-1,
                                 c_white, c_white, c_white, c_white, false);
                           
            gpu_set_blendmode_ext(bm_one, bm_zero);
            draw_text(_box.left*_cellSize, _box.top*_cellSize, _string);
            
            gpu_set_blendmode(bm_normal);
            surface_reset_target();
            
            dictionary[$ _string] = _box;
            array_push(_boxArray, _box);
        }
        
        _box.lastDraw = current_time;
        draw_surface_part(surface,
                          _box.left*_cellSize, _box.top*_cellSize,
                          _box.width*_cellSize, _box.height*_cellSize,
                          _x, _y);
    }
}