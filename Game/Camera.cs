using Godot;
using System;

public class Camera : Camera2D
{
    public override void _Ready()
    {
        make_current()
    }
}
