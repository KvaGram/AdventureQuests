using Godot;
using System;
using NodeCollection = Godot.Collections.Array;
using SaveDataObject = Godot.Collections.Dictionary<string, object>;
using SaveDataEntry = System.Collections.Generic.KeyValuePair<string, object>;

public class GameData : Node
{
    private LineEdit lineEdit;
    public string lineText;

    public override void _Ready()
    {
        lineEdit = GetNode<LineEdit>("../Testarea");
        GD.Print("lineEdit:" +(lineEdit != null).ToString());
    }
    public SaveDataObject SaveSdo()
    {
        return new SaveDataObject()
        {
            { "Filename", Filename },
            { "lineText", lineText }
        };
    }
    public void LoadSdo(SaveDataObject sdo)
    {
        lineText = (string)sdo["lineText"];
        if(lineEdit == null)
            lineEdit = GetNode<LineEdit>("../Testarea");
        lineEdit.Text = lineText;
    }
}