
using { /Fortnite.com/Devices }
using { /Verse.org/Simulation }
using { /UnrealEngine.com/Temporary/Diagnostics }
using { /UnrealEngine.com/Temporary/UI }
using { /Fortnite.com/UI }
using { /UnrealEngine.com/Temporary/SpatialMath }

# See https://dev.epicgames.com/documentation/en-us/uefn/create-your-own-device-in-verse for how to create a verse device.

# A Verse-authored creative device that can be placed in a level
trigger_counter := class(creative_device):
 
        @editable
        var TriggerManager :trigger_device = trigger_device{}
        var TriggerCount : int = 0
        var Players : [] player = array {}
        var UIButton : button_regular= button_regular{}

        TextForUI<localizes>(Hits : int) : message = "You captured the point: {Hits}"
#dsadasd
        OnBegin<override>()<suspends>:void=
            TriggerManager.TriggeredEvent.Subscribe(OnTriggered)
#asda
            set Players = GetPlayspace().GetPlayers()
            if(Player := Players[0]):
                CreateUI(Player)

    OnTriggered(Agent: ?agent) : void =
        set TriggerCount = TriggerCount+1
        Print ("You captured the point:{TriggerCount}")
        UIButton.SetText(TextForUI(TriggerCount))
         
    CreateUI (Player : player) : void=
        if(PlayerUI := GetPlayerUI [Player]):
            UIButton.SetText(TextForUI(0))
            MyCanvas : canvas = canvas:
                Slots := array:
                    canvas_slot:
                        Widget := UIButton
                        Anchors := anchors{Minimum := vector2 {X := 0.5, Y:= 0.0}, Maximum:= vector2 {X := 0.5, Y:= 0.0}}
                        Offsets := margin{Top := 50.0, Left := 50.0, Right := 50.0, Bottom := 50.0 }
                        Alignment :=vector2 {X := 0.5, Y:= 0.5}
                        SizeToContent := true
            PlayerUI.AddWidget (MyCanvas)            