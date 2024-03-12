if ((!keyboard_check(vk_control) && keyboard_check(vk_enter)) || (keyboard_check(vk_control) && keyboard_check_pressed(vk_enter)))
{
    testString = "";
    repeat(irandom_range(1, 10))
    {
        repeat(choose(1, 1, 1, 2))
        {
            testString += md5_string_utf8(irandom(0xFFFFFFFF));
        }
        
        testString += "\n";
    }
    testString = string_copy(testString, 1, string_length(testString)-1);
}