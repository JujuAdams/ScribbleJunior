draw_text(10, 10, fps);
draw_text(10, 30, fps_real);

//texturePackrat.packrat.DebugDraw(10, room_height - 10 - 6*2048/32, 6);

if (keyboard_check(vk_space))
{
    repeat(1000)
    {
        draw_text(10, 50, testString);
    }
}
else if (keyboard_check(vk_shift))
{
    repeat(1000)
    {
        Scribblejr(testString).Draw(10, 50);
    }
}
else
{
    repeat(1000)
    {
        texturePackrat.DrawText(10, 50, testString);
    }
}