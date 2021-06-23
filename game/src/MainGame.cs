using Godot;
using System;
using NodeCollection = Godot.Collections.Array;
using SaveDataObject = Godot.Collections.Dictionary<string, object>;
using SaveDataEntry = System.Collections.Generic.KeyValuePair<string, object>;

public class MainGame : Node
{
    private GameData data;
    const string SAVEFILE_NAME = "tenebrae_quests";

    public override void _Ready()
    {
        data = GameData.DATA;
        LoadGame();

        //test feature:
        GD.Print("linetext: "  + data.lineText);
        GetNode<LineEdit>("Testsave").Text = data.lineText;
    }

    public void SaveGame()
    {
        //first save main data
        data.SaveGameData();

        //now save aux data
        File savefile = new File();
        savefile.Open("user://"+SAVEFILE_NAME+".save", File.ModeFlags.Write);
        NodeCollection savenodes = GetTree().GetNodesInGroup("savedata");
        foreach(Node savenode in savenodes)
        {
            if(savenode.Filename.Empty())
            {
                GD.Print(String.Format("persistent node '{0}' is not an instanced scene, skipped", savenode.Name));
                continue;
            }
            if (!savenode.HasMethod("SaveSdo"))
            {
                GD.Print(String.Format("persistent node '{0}' is missing a SaveSdo() function, skipped", savenode.Name));
                continue;
            }
            SaveDataObject sdo = (SaveDataObject)savenode.Call("SaveSdo");
            savefile.StoreLine(JSON.Print(sdo));
        }
        savefile.Close();
    }
    public void LoadGame()
    {
        //first load main data
        data.LoadGameData();

        //now load aux data
        File savefile = new File();
        if(!savefile.FileExists("user://"+SAVEFILE_NAME+".save"))
        {
            GD.Print("No aux save data detected. Exiting LoadGame function");
            return;
        }
        NodeCollection savenodes = GetTree().GetNodesInGroup("savedata");
        foreach(Node savenode in savenodes)
        {
            savenode.QueueFree();
        }
        savefile.Open("user://"+SAVEFILE_NAME+".save", File.ModeFlags.Read);

        while(savefile.GetPosition() < savefile.GetLen())
        {
            SaveDataObject sdo = new SaveDataObject((SaveDataObject)JSON.Parse(savefile.GetLine()).Result);
            PackedScene newobjScene = (PackedScene)ResourceLoader.Load(sdo["Filename"].ToString());
            Node newObj = (Node)newobjScene.Instance();
            GetNode(sdo["Parent"].ToString()).AddChild(newObj);

            //if class has its own loader, use that.
            if (newObj.HasMethod("LoadSdo"))
            {
                newObj.Call("LoadSdo", sdo);
            }
            //else use this generic loader
            else
            {
                if(sdo.ContainsKey("PosX") && sdo.ContainsKey("PosY"))
                    newObj.Set("Position", new Vector2((float)sdo["PosX"], (float)sdo["PosY"]));
                foreach(SaveDataEntry entry in sdo)
                {
                    string key = entry.Key.ToString();
                    //ignore entries that require special handling. 
                    if (key == "Filename" || key == "Parent" || key == "PosX" || key == "PosY")
                        continue;
                    newObj.Set(key, entry.Value);
                }
            }
        }
        savefile.Close();
        GD.Print("save loaded");
    }
}
