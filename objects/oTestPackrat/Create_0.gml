texturePackrat = new TexturePackrat(2000, 40);

testString = "";
repeat(irandom_range(1, 10))
{
    repeat(choose(1, 1, 1, 1, 1, 2, 2, 3))
    {
        testString += md5_string_utf8(irandom(0xFFFFFFFF));
    }
    
    testString += "\n";
}
testString = string_copy(testString, 1, string_length(testString)-1);