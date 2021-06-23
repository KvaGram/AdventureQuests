using Godot;
using System;
using NodeCollection = Godot.Collections.Array;
using SaveDataObject = Godot.Collections.Dictionary<string, object>;
using SaveDataEntry = System.Collections.Generic.KeyValuePair<string, object>;
/*
    GameData is a static singleton. If more than one is initiated (runs _Ready)
    the last one is kept, scrapping any old ones. -NOTE: this behavior is inverse of MainGame
*/
public class GameData 
{
    //test features:
    public string lineText;

    //static singleton
    public static GameData DATA {get{
        if(_DATA == null)
            _DATA = new GameData();
        return _DATA;
    }}
    private static GameData _DATA;
    const string SAVEFILE_NAME = "tenebrae_quests_main";
    public void SaveGameData()
    {
        File savefile = new File();
        savefile.Open("user://"+SAVEFILE_NAME+".save", File.ModeFlags.Write);

        //save player data
        savefile.StoreLine(JSON.Print(PlayerSdo));
        //todo: store quest data

        savefile.Close();
    }
    public void LoadGameData()
    {
        File savefile = new File();
        if(!savefile.FileExists("user://"+SAVEFILE_NAME+".save"))
        {
            GD.Print("No main save data detected. Exiting LoadGameData function");
            return;
        }
        savefile.Open("user://"+SAVEFILE_NAME+".save", File.ModeFlags.Read);
        while(savefile.GetPosition() < savefile.GetLen())
        {
            SaveDataObject sdo = new SaveDataObject((Godot.Collections.Dictionary)JSON.Parse(savefile.GetLine()).Result);
            //var sdo = new Godot.Collections.Dictionary<string, object>((Godot.Collections.Dictionary)JSON.Parse(savefile.GetLine()).Result);
            //handle loading player data.
            if(sdo.ContainsKey("playername"))
            {
                PlayerSdo = sdo;
                continue;
            }
        }
        savefile.Close();
    }


    /* #region Player info save/load */
    private SaveDataObject PlayerSdo { get {return new SaveDataObject()
    {
        {"playername", lineText}
    };}
    set {
        //placeholder
        /*playername*/ lineText = (string)value["playername"];
    }}
    /* #endregion */
}