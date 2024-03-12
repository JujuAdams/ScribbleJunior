/// Packrat(width, height) constructor
/// 
/// Grid-based knapsack problem solver. Packrat structs are instantiated by calling
/// `new Packrat(width, height)`. A packrat struct has public variables but many public methods
/// (see below). You MUST call the .Destroy() method on the packrat struct to avoid memory leaks.
/// 
/// The methods .FindAndPlace() and .FindSpace() return a struct in most cases. This is called a
/// "box struct" and contains information that describes how a box should be placed on the grid.
/// This struct contains the following read-only variables:
/// 
/// {
///   .space    Boolean, whether there is space to place this box
///   .placed   Booleam, whether the box has been placed on the grid
///   .removed  Boolean, whether the box was placed on the grid and then removed
///   .left     Integer, the left coordinate of the box on the grid. Can be <undefined>
///   .top      Integer, the top coordinate of the box on the grid. Can be <undefined>
///   .right    Integer, the right coordinate of the box on the grid. Can be <undefined>
///   .bottom   Integer, the bottom coordinate of the box on the grid. Can be <undefined>
///   .width    Integer, the width of the box
///   .height   Integer, the height of the box
/// }
/// 
/// The box struct also contains two variables called "__index" and "__salt" which is for internal
/// use and should never be written to or read. Box structs cannot no methods.
/// 
/// Public methods for packrat structs are as follows:
/// 
/// .Destroy()
///     Frees memory used by the Packrat struct.
/// 
/// .FindAndPlace(width, height, [alwaysReturnStruct=false], [existingStruct])
///     Tries to place a box with the given width and height. If successful, a new box struct is
///     returned. If unsuccessful, this function returns <undefined>. If "alwaysReturnStruct" is
///     set to <true> then this function will return a box struct even when failing to place a box.
///     If "existingStruct" is set to a struct then the box data will be written into that struct
///     rather than a new struct being instantiated.
/// 
/// .FindSpace(width, height, [alwaysReturnStruct=false], [existingStruct])
///     Tries to find an empty space for a box with the given width and height. This function
///     operates the same as .FindAndPlace() above but does not actually place the box in the grid.
///     This is useful to detect if there is enough free space before placing a box.
/// 
/// .Place(boxStruct)
///     Places a box in the grid. This box should have been created by .FindSpace() above. Trying
///     to re-place a box that has already been placed will cause problems. Additionally, trying to
///     place a box associated with one packrat into another packrat will cause problems.
/// 
/// .Remove(boxStruct)
///     Removes the box from the grid.
/// 
/// .Defragment()
///     Rearranges boxes in the grid to create as much contiguous free space as possible. If this
///     function fails then the grid will retain its original layout. Four new variables will be
///     added to each box struct: leftPrev, topPrev, rightPrev, bottomPrev. These refer to the
///     original position of the box before defragmentation.
/// 
/// .Duplicate()
///     Duplicates the packrat struct using a deep copy and returns the copy.
/// 
/// .Clear()
///     Clears the grid entirely.
/// 
/// .DebugDraw(x, y, scale)
///     Draws a debug visualisation of the grid.
/// 
/// .GetWidth()
///     Returns the width of the grid.
/// 
/// .GetHeight()
///     Returns the height of the grid.
/// 
/// .GetTotalCells()
///     Returns the total number of cells on the grid.
/// 
/// .GetUsedCells()
///     Returns the number of cells on the grid being occupied by a box.
/// 
/// .GetFreeCells()
///     Returns the number of unoccupied cells on the grid. These cells are not necessarily
///     contiguous.
/// 
/// .GetGrid()
///     Returns the grid itself. Don't edit the grid or you'll break something!
/// 
/// .GetPlacedCount()
///     Returns the number of placed boxes on the grid.
/// 
/// .GetPlacedArray()
///     Returns an array of placed boxes. Not all entries in the array will be box structs and some
///     entries may be <undefined>.
///
/// @param width
/// @param height

// Feather disable all

function Packrat(_width, _height) constructor
{
    static _backupGrid = ds_grid_create(1, 1);
    
    __width  = _width;
    __height = _height;
    
    __grid = ds_grid_create(_width, _height);
    ds_grid_clear(__grid, -1);
    
    __placedArray    = [];
    __freeIndexArray = [];
    
    __totalCount = 0;
    
    static FindAndPlace = function(_width, _height, _alwaysReturnStruct = false, _box = undefined)
    {
        _box = FindSpace(_width, _height, _alwaysReturnStruct, _box);
        Place(_box);
        return _box;
    }
    
    static FindSpace = function(_width, _height, _alwaysReturnStruct = false, _box = undefined)
    {
        --_width;
        --_height;
        
        var _realWidth = __width - _width;
        if (_realWidth > 0)
        {
            var _grid = __grid;
            
            var _top = 0;
            var _bottom = _height;
            repeat(__height - _height)
            {
                var _left   = 0;
                var _right = _width;
                repeat(_realWidth)
                {
                    if (ds_grid_get_max(_grid, _left, _top, _right, _bottom) < 0)
                    {
                        ++__totalCount;
                        
                        if (_box == undefined) _box = {};
                        with(_box)
                        {
                            space   = true;
                            placed  = false;
                            removed = false;
                            left    = _left;
                            top     = _top;
                            right   = _right;
                            bottom  = _bottom;
                            width   = 1+_width;
                            height  = 1+_height;
                            __index = undefined;
                            __salt  = other.__totalCount;
                        }
                        
                        return _box;
                    }
                    
                    ++_left;
                    ++_right;
                }
                
                ++_top;
                ++_bottom;
            }
        }
        
        if (_alwaysReturnStruct)
        {
            if (_box == undefined) _box = {};
            with(_box)
            {
                space   = false;
                placed  = false;
                removed = false;
                left    = undefined;
                top     = undefined;
                right   = undefined;
                bottom  = undefined;
                width   = 1+_width;
                height  = 1+_height;
                __index = undefined;
                __salt  = undefined;
            }
            
            return _box;
        }
        else
        {
            return undefined;
        }
    }
    
    static Defragment = function()
    {
        var _oldPlacedArray = __placedArray;
        var _oldFreeArray   = __freeIndexArray;
        ds_grid_resize(_backupGrid, __width, __height);
        ds_grid_copy(_backupGrid, __grid);
        
        ds_grid_clear(__grid, -1);
        __placedArray    = [];
        __freeIndexArray = [];
        
        array_sort(_oldPlacedArray, function(_a, _b)
        {
            if (_a == undefined)
            {
                return (_b == undefined)? 0 : 1;
            }
            else if (_b == undefined)
            {
                return -1;
            }
            else
            {
                return sign(_b.width*_b.height - _a.width*_a.height);
            }
        });
        
        var _fail = false;
        var _i = 0;
        repeat(array_length(_oldPlacedArray))
        {
            var _box = _oldPlacedArray[_i];
            if (_box != undefined)
            {
                with(_box)
                {
                    leftPrev   = left;
                    topPrev    = top;
                    rightPrev  = right;
                    bottomPrev = bottom;
                }
                
                if (FindAndPlace(_box.width, _box.height, false, _box) == undefined)
                {
                    _fail = true;
                    break;
                }
            }
            
            ++_i;
        }
        
        if (_fail)
        {
            //Oops!
            var _j = 0;
            repeat(_i+1)
            {
                var _box = _oldPlacedArray[_j];
                with(_box)
                {
                    left   = leftPrev;
                    top    = topPrev;
                    right  = rightPrev;
                    bottom = bottomPrev;
                }
                
                ++_j;
            }
            
            __placedArray    = _oldPlacedArray;
            __freeIndexArray = _oldFreeArray;
            ds_grid_copy(__grid, _backupGrid);
        }
    }
    
    static Duplicate = function()
    {
        var _newPackrat = new Packrat(__width, __height);
        
        ds_grid_copy(_newPackrat.__grid, __grid);
        _newPackrat.__placedArray    = variable_clone(__placedArray, 2);
        _newPackrat.__freeIndexArray = variable_clone(__freeIndexArray);
        
        return _newPackrat;
    }
    
    static Place = function(_box)
    {
        if ((_box == undefined) || (not _box.space) || _box.placed || _box.removed) return;
        
        var _id = array_pop(__freeIndexArray);
        if (_id == undefined) _id = array_length(__placedArray);
        
        __placedArray[_id] = _box;
        _box.__index = _id;
        _box.placed = true;
        
        ds_grid_set_region(__grid, _box.left, _box.top, _box.right, _box.bottom, _id);
    }
    
    static Remove = function(_box)
    {
        if ((_box == undefined) || ((not _box.placed) || _box.removed)) return;
        
        var _id = _box.__index;
        if (_id == undefined) return;
        
        _box.__index = undefined;
        __placedArray[_id] = undefined;
        array_push(__freeIndexArray, _id);
        
        ds_grid_set_region(__grid, _box.left, _box.top, _box.right, _box.bottom, -1);
    }
    
    static Clear = function()
    {
        var _i = 0;
        repeat(array_length(__placedArray))
        {
            with(__placedArray[_i])
            {
                removed = true;
                __index = undefined;
            }
            
            ++_i;
        }
        
        ds_grid_clear(__grid, -1);
        __placedArray    = [];
        __freeIndexArray = [];
    }
    
    static GetWidth = function()
    {
        return __width;
    }
    
    static GetHeight = function()
    {
        return __height;
    }
    
    static GetGrid = function()
    {
        return __grid;
    }
    
    static GetBox = function(_x, _y)
    {
        var _id = __grid[# _x, _y];
        if (_id < 0) return undefined;
        if (_id == undefined) return undefined;
        return __placedArray[_id];
    }
    
    static GetPlacedArray = function()
    {
        return __placedArray;
    }
    
    static GetPlacedCount = function()
    {
        return array_length(__placedArray);
    }
    
    static GetTotalCells = function()
    {
        return __width*__height;
    }
    
    static GetUsedCells = function()
    {
        return __width*__height - GetFreeCells();
    }
    
    static GetFreeCells = function()
    {
        var _space = 0;
        var _grid = __grid;
        var _width = __width;
        
        var _y = 0;
        repeat(__height)
        {
            var _x = 0;
            repeat(_width)
            {
                if (_grid[# _x, _y] < 0) _space++;
                ++_x;
            }
                
            ++_y;
        }
        
        return _space;
    }
    
    static Destroy = function()
    {
        if (__grid != undefined)
        {
            ds_grid_destroy(__grid);
            __grid = undefined;
        }
    }
    
    static DebugDraw = function(_x, _y, _scale)
    {
        var _oldMatrix = matrix_get(matrix_world);
        matrix_set(matrix_world, matrix_multiply(_oldMatrix, matrix_build(_x, _y, 0,   0,0,0,   _scale, _scale, 1)))
        
        draw_rectangle_color(0, 0, __width-1, __height-1, c_dkgray, c_dkgray, c_dkgray, c_dkgray, false);
        
        var _placedArray = __placedArray;
        var _i = 0;
        repeat(array_length(_placedArray))
        {
            var _box = _placedArray[_i];
            if (_box != undefined)
            {
                var _color = int64(ptr(string_copy(md5_string_utf8(string(_box.__salt*3254698)), 1, 6)));
                draw_rectangle_colour(_box.left, _box.top, _box.right, _box.bottom, _color, _color, _color, _color, false);
            }
            
            ++_i;
        }
        
        matrix_set(matrix_world, _oldMatrix);
    }
}