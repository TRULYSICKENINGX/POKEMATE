LeppaBerryHotkey = "h3" --put leppa berry on hotkey 3
Shinies = 0
PayDayPP = 0 --set by script, don't need to set anymore
Reward = 450 --estimate, given Smeargles are level 40-50 in Artisan Cave
Encounters = 0 --roughly 130 an hour
CycleCount = 0
StartMoney = 0 --used for calculating per battle payout
EndMoney = 0 --used for calculating per battle payout
MoneyX = Trainer.GetMoney() --used for calculating total runtime profit
Cycles = 15 --one cycle is roughly 30 encounters, relogs after set Cycles
SlowMode = 0 -- increas this value if ur pc is a little bit slower
SlowModeDelay = 500 * SlowMode
LeppaBerriesUsed = 0 --roughly 12 berries an hour
LeppaBerriesTotal = 2222 --set this (make sure your PayDay is full PP before starting, this will end 5 before your actual berry count to avoid bugs)

--you need a masterball to catch shinies

function WaitToAttack()
    while (not Battle.CanAttack() and Trainer.IsInBattle()) do
        sleep(500)
    end
end

function SearchBattle()
    if (Trainer.IsInBattle()) then
        return
    end
    RightGoing = false
    while (true) do
        if (Trainer.IsInBattle()) then
            return
        end
        if (Trainer.GetX() <= 37 and RightGoing) then
            Trainer.MoveRight(true, 1)
        else
            RightGoing = false
            Trainer.MoveLeft(true, 1)
            if (Trainer.GetX() <= 26) then
                RightGoing = true
            end
        end
    end
end

function DoBattle()
    StartMoney = Trainer.GetMoney()
    if (Battle.Active.GetPokemonRarity(1, 0) == "SHINY") then
        print("SHINY FOUND")
        MessageBox("SHINY ALERT", "The Bot found a shiny ^^")
        WaitToAttack()
        sleep(500 + SlowModeDelay)
        Battle.DoItemInteraction(0, 0, "ITEM", 5001, 0, -1) --Master Ball
        sleep(1500 + SlowModeDelay)
        KeyTyped("A")
        sleep(1500 + SlowModeDelay)
        WaitToAttack()
        if (not Trainer.IsInBattle()) then
            Shinies = Shinies + 1
            print("Captured Shiny!")
            return
        end
    end
    if (Battle.Active.GetPokemonID(1, 0) ~= 235 or Battle.GetBattleType() ~= "SINGLE_BATTLE") then
        while (Trainer.IsInBattle()) do
            WaitToAttack()
            Battle.DoAction(0, 0, "RUN", 0, 0)
            print(" Escaped!")
            while (Trainer.IsInBattle()) do
                sleep(1000)
            end
        end
    else
        Encounters = Encounters + 1
        while (Trainer.IsInBattle()) do
            WaitToAttack()
            sleep(1000 + SlowModeDelay)
            Battle.DoAction(0, 0, "SKILL", 6, 0)
            PayDayPP = Battle.Moves.GetPP(0, 0, 0)
            while (Trainer.IsInBattle()) do
                sleep(1000)
            end
        end
        EndMoney = Trainer.GetMoney()
        if (not Trainer.IsInBattle()) then
            print("       " .. PayDayPP .. " PP")
            print("       $" .. (EndMoney - MoneyX) .. " Earned")
            print("       " .. Encounters .. " Encounter(s)")
            --For some reason the below prints break the script; you can put these under other functions if you wish to use them still
            print("       $" .. (EndMoney - StartMoney) .. " Last Encounter")
            print("       " .. Shinies .. " Shinies")
            print(" ==================================================")
            return
        end
    end
end

function MainProcedure() --ONE
    while (true) do
        SearchBattle()
        sleep(1000 + SlowModeDelay)
        DoBattle()
        sleep(1000 + SlowModeDelay)
        if (PayDayPP <= 2) then
            break
        end
        if ((LeppaBerriesTotal - LeppaBerriesUsed) <= 5) then
            Logout()
            print("Out of Berries, Ending...")
            stop()
        end
    end
end

function Recovery() --TWO
    sleep(2000 + SlowModeDelay)
    for b = 1, 3 do
        KeyTyped(LeppaBerryHotkey)
        sleep(1000 + SlowModeDelay)
        KeyTyped("A")
        sleep(1000 + SlowModeDelay)
        KeyTyped("A")
        LeppaBerriesUsed = LeppaBerriesUsed + 1
        sleep(2000 + SlowModeDelay)
    end
end

function CheckForWildEncounter()
    if (Trainer.IsInBattle()) then
        print("Wild Encounter")
        if (Battle.Active.GetPokemonRarity(1, 0) == "SHINY") then
            print("SINGLE SHINY FOUND")
            CatchSingleShiny()
            sleep(2000 + SlowModeDelay)
            return
        end
        LastPokemonHealth = Battle.Active.GetPokemonHealth(0, CurrentPokemon)
        if (LastPokemonHealth == -1) then
            CurrentPokemon = CurrentPokemon + 1
            WaitToAttack()
            Battle.DoAction(0, 0, "SWAP", CurrentPokemon, 0)
            sleep(1000 + SlowModeDelay)
        end
        WaitToAttack()
        Battle.DoAction(0, 0, "RUN", 0, 0)
        sleep(2000 + SlowModeDelay)
    end
end

function Main()
    for i = 1, Cycles do
        print("Searching...")
        MainProcedure()
        print("Using Berries...")
        Recovery()
        CycleCount = CycleCount + 1
    end
    print("Resetting...")
    sleep(500)
    CheckForWildEncounter()
    sleep(1500 + SlowModeDelay)
    Logout()
    sleepm(1)
    Login()
    sleep(2000 + SlowModeDelay)
    if (Trainer.GetMapID() == -1) then
        KeyTyped("A")
        sleep(4000)
        CheckForWildEncounter()
    end
    sleep(5000 + SlowModeDelay)
    Main()
end

Main()
