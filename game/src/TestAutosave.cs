using Godot;
using System;

public class TestAutosave : Timer
{
    public void OnAutosave()
    {
        GD.Print("OnAutosave");
        
        //test feature
        GameData.DATA.lineText = GetNode<LineEdit>("../Testsave").Text;
        //test game save
        GameData.DATA.SaveGameData();
    }


    // Declare member variables here. Examples:
    // private int a = 2;
    // private string b = "text";

    // Called when the node enters the scene tree for the first time.
    public override void _Ready()
    {
        GD.Print("TestAutosave _Ready()");
    }

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }
}
