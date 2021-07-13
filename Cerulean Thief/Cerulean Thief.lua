LastPokemonHealth = 12
CurrentPokemon = 0
Encounters = -1
Count = 0 -- For Shiny Encounters
ShinyCount = 0
ResetCount = 0
MankeyCount = 0
MeowthCount = 0
FixBushCount = 0
CycleCount = 0
ItemCount = 0
ThiefPP = 40
SweetScentPP = 32 -- Use 3 PP Up to get max efficiency
PokemonID = 200000000 -- Get your PokemonID by changing your Pokemon's items in Debugging Mode
PokemonName = "Shuppet" -- Set this to your Pokemon's name, nickname if applicable (ex. my Shuppet is named MEOWTHEATER69)
AbilityName = "Frisk"
CutHotkey = "h7" -- Put Cut on Hotkey 7
TeleportHotkey = "h8" -- Put Teleport on Hotkey 8
SweetScentHotkey = "h9" -- Put Sweet Scent on Hotkey 9
Cycles = 30 -- Cycles before the script relogs you to potentially help avoid detection, 10 Cycles is approximately 30 minutes (don't set this value too high)
SlowMode = 0 -- Increase this value if ur pc is a little bit slower
SlowModeDelay = 500 * SlowMode

-- Make sure to cut the bush once before starting (the script will perform a hard reset anyways if you get don't, but this bypasses one relog)
-- Also u will need some UltraBall s for Shiny catching

function RelogReset()
    print("Resetting...")
    GoOutOfPC()
    sleep(500)
    CheckForWildEncounter()
    GoBackToPC()
    sleep(1500 + SlowModeDelay)
    Logout()
    sleepm(1)
    Login()
    sleep(2000 + SlowModeDelay)
    if (Trainer.GetMapID() == -1) then
        KeyTyped("A")
        sleep(4000 + SlowModeDelay)
        CheckForWildEncounter()
        GoBackToPC()
    end
    sleep(5000 + SlowModeDelay)
    ResetCount = ResetCount + 1
    print("Success... " .. ResetCount .. " Relog(s)")
end

function FixBush()
    print("Fixing Bush...")
    GoOutOfPC()
    sleep(500 + SlowModeDelay)
    GoToBush1()
    sleep(500 + SlowModeDelay)
    CutBush()
    sleep(5000 + SlowModeDelay)
    GoBackToPC()
    sleep(1500 + SlowModeDelay)
    FixBushCount = FixBushCount + 1
    print("Success... " .. FixBushCount .. " Fixed")
end

function HardReset()
    RelogReset()
    FixBush()
    Main()
end

function CheckPosition(X, Y)
    ErrorCorrection(X, Y)
    if (not (Trainer.GetX() == X and Trainer.GetY() == Y)) then
        print("Incorrect Position, Hard Resetting...")
        HardReset()
    end
end

function ErrorCorrection(X, Y)
    cX = Trainer.GetX()
    cY = Trainer.GetY()
    dX = X - cX
    dY = Y - cY

    if (not (dX < 5 and dX > -5) or not (dY < 5 and dY > -5)) then
        return
    end

    if (dX == 0 and dY == 0) then
        return
    end

    print("Correcting Position...")
    if (dX > 0) then
        while (Trainer.GetX() < X) do
            Trainer.MoveRight(true, 1)
        end
    end
    if (dX < 0) then
        while (Trainer.GetX() > X) do
            Trainer.MoveLeft(true, 1)
        end
    end
    if (dY > 0) then
        while (Trainer.GetY() < Y) do
            Trainer.MoveDown(true, 1)
        end
    end
    if (dY < 0) then
        while (Trainer.GetY() > Y) do
            Trainer.MoveUp(true, 1)
        end
    end
    sleep(500)
end

function GoOutOfPC()
    Trainer.MoveDown(true, 6)
    sleep(2000 + SlowModeDelay)
    while (Trainer.IsMovementBlocked()) do
        sleep(2000)
    end
end

function Regenerate()
    sleep(2000)
    Trainer.TalkToNPC()
    sleep(1500 + SlowModeDelay)
    KeyTyped("a")
    sleep(1500 + SlowModeDelay)
    KeyTyped("a")
    sleep(1500 + SlowModeDelay)
    KeyTyped("a")
    sleep(1500 + SlowModeDelay)
    KeyTyped("a")
    sleep(1500 + SlowModeDelay)
    KeyTyped("a")
    sleep(1500 + SlowModeDelay)
    KeyTyped("a")
    ThiefPP = 40
    SweetScentPP = 32
    CurrentPokemon = 0
    GoOutOfPC()
end

function GoToBush1()
    Trainer.MoveDown(true, 4)
    CheckPosition(22, 24)
    Trainer.MoveLeft(true, 4)
    CheckPosition(19, 24)
    Trainer.MoveDown(true, 8)
    CheckPosition(19, 31)
    Trainer.MoveRight(true, 8)
    CheckPosition(26, 31)
    Trainer.MoveDown(true, 1)
end
function GoToBush2()
    Trainer.MoveLeft(true, 4)
    CheckPosition(19, 20)
    Trainer.MoveDown(true, 10)
    CheckPosition(19, 29)
    Trainer.MoveRight(true, 8)
    CheckPosition(26, 29)
    Trainer.MoveDown(true, 3)
end
function GoToBush3()
    Trainer.MoveDown(true, 2)
    CheckPosition(22, 22)
    Trainer.MoveLeft(true, 5)
    CheckPosition(18, 22)
    Trainer.MoveDown(true, 8)
    CheckPosition(18, 29)
    Trainer.MoveRight(true, 9)
    CheckPosition(26, 29)
    Trainer.MoveDown(true, 3)
end
function GoToBush4()
    Trainer.MoveDown(true, 3)
    CheckPosition(22, 23)
    Trainer.MoveLeft(true, 6)
    CheckPosition(17, 23)
    Trainer.MoveDown(true, 8)
    CheckPosition(17, 30)
    Trainer.MoveRight(true, 10)
    CheckPosition(26, 30)
    Trainer.MoveDown(true, 2)
end
function GoToBush5()
    Trainer.MoveDown(true, 1)
    CheckPosition(22, 21)
    Trainer.MoveLeft(true, 4)
    CheckPosition(19, 21)
    Trainer.MoveDown(true, 9)
    CheckPosition(19, 29)
    Trainer.MoveRight(true, 8)
    CheckPosition(26, 29)
    Trainer.MoveDown(true, 3)
end

function CutBush()
    KeyTyped(CutHotkey)
    sleep(2500 + SlowModeDelay)
end

function GoToRoute5()
    CheckPosition(22, 20)
    choice = random(1, 5)
    if (choice == 1) then
        GoToBush1()
    end
    if (choice == 2) then
        GoToBush2()
    end
    if (choice == 3) then
        GoToBush3()
    end
    if (choice == 4) then
        GoToBush4()
    end
    if (choice == 5) then
        GoToBush5()
    end
    CheckPosition(26, 31)
    CutBush()
    Trainer.MoveDown(true, 5)
    sleep(1000)
    Trainer.MoveDown(true, 7)
    sleep(1000)
    CheckPosition(26, 5)
end

function WaitToAttack()
    while (not Battle.CanAttack() and Trainer.IsInBattle()) do
        sleep(500)
    end
end

function CatchHordeShiny() --17, 33, 49
	ShinyCount = ShinyCount + 1
    print(" ========== HORDE SHINY FOUND ==========")
    if (Battle.Active.GetPokemonRarity(1, 1) == "SHINY") then
        count = 0
        WaitToAttack()
        while (count <= 5) do
            if (count == 0) then --swap to sixth slot Pokemon (needs damage, starmie)
                Battle.DoAction(0, 0, "SWAP", 5, 0)
                sleep(1000 + SlowModeDelay)
            end
            if (count == 1) then --thunderbolt on middle horde
                Battle.DoAction(0, 0, "SKILL", 85, 33)
                sleep(1000 + SlowModeDelay)
            end
            if (count == 2) then --thunderbolt on right horde
                Battle.DoAction(0, 0, "SKILL", 85, 49)
                sleep(1000 + SlowModeDelay)
            end
            if (count == 3) then --switch to second slot Pokemon (False Swipe)
                Battle.DoAction(0, 0, "SWAP", 1, 0)
                sleep(1000 + SlowModeDelay)
            end
            if (count == 4) then --use False Swipe on left HORDE
                Battle.DoAction(0, 0, "SKILL", 206, 17)
                sleep(1000 + SlowModeDelay)
            end
            if (count == 5) then --use Ball
                Battle.DoItemInteraction(0, 0, "ITEM", 5002, 0, -1) --UltraBall, not horde position reliant
                count = 4
                sleep(1000 + SlowModeDelay)
            end
            count = count + 1
            WaitToAttack()
            if (not Trainer.IsInBattle()) then
                print("Horde Shiny Captured!")
                return
            end
        end
    end
    if (Battle.Active.GetPokemonRarity(1, 2) == "SHINY") then
        count = 0
        WaitToAttack()
        while (count <= 5) do
            if (count == 0) then --swap to fifth slot Pokemon (needs damage, starmie)
                Battle.DoAction(0, 0, "SWAP", 5, 0)
                sleep(1000 + SlowModeDelay)
            end
            if (count == 1) then --thunderbolt on left horde
                Battle.DoAction(0, 0, "SKILL", 85, 17)
                sleep(1000 + SlowModeDelay)
            end
            if (count == 2) then --thunderbolt on right horde
                Battle.DoAction(0, 0, "SKILL", 85, 49)
                sleep(1000 + SlowModeDelay)
            end
            if (count == 3) then --switch to second slot Pokemon (False Swipe)
                Battle.DoAction(0, 0, "SWAP", 1, 0)
                sleep(1000 + SlowModeDelay)
            end
            if (count == 4) then --use False Swipe on middle HORDE
                Battle.DoAction(0, 0, "SKILL", 206, 33)
                sleep(1000 + SlowModeDelay)
            end
            if (count == 5) then --use Ball
                Battle.DoItemInteraction(0, 0, "ITEM", 5002, 0, -1) --UltraBall, not horde position reliant
                count = 4
                sleep(1000 + SlowModeDelay)
            end
            count = count + 1
            WaitToAttack()
            if (not Trainer.IsInBattle()) then
                print("Horde Shiny Captured!")
                return
            end
        end
    end
    if (Battle.Active.GetPokemonRarity(1, 3) == "SHINY") then
        count = 0
        WaitToAttack()
        while (count <= 5) do
            if (count == 0) then --swap to fifth slot Pokemon (needs damage, starmie)
                Battle.DoAction(0, 0, "SWAP", 5, 0)
                sleep(1000 + SlowModeDelay)
            end
            if (count == 1) then --thunderbolt on left horde
                Battle.DoAction(0, 0, "SKILL", 85, 17)
                sleep(1000 + SlowModeDelay)
            end
            if (count == 2) then --thunderbolt on middle horde
                Battle.DoAction(0, 0, "SKILL", 85, 33)
                sleep(1000 + SlowModeDelay)
            end
            if (count == 3) then --switch to second slot Pokemon (False Swipe)
                Battle.DoAction(0, 0, "SWAP", 1, 0)
                sleep(1000 + SlowModeDelay)
            end
            if (count == 4) then --use False Swipe on right HORDE
                Battle.DoAction(0, 0, "SKILL", 206, 49)
                sleep(1000 + SlowModeDelay)
            end
            if (count == 5) then --use Ball
                Battle.DoItemInteraction(0, 0, "ITEM", 5002, 0, -1) --UltraBall, not horde position reliant
                count = 4
                sleep(1000 + SlowModeDelay)
            end
            count = count + 1
            WaitToAttack()
            if (not Trainer.IsInBattle()) then
                print("Horde Shiny Captured!")
                return
            end
        end
    end
end

function CatchSingleShiny()
	ShinyCount = ShinyCount + 1
    print(" ========== Single SHINY FOUND ==========")
    if (Battle.Active.GetPokemonRarity(1, 0) == "SHINY") then
        count = 0
        WaitToAttack()
        while (count <= 2) do
            if (count == 0) then --swap to second Pokemon (Smeargle)
                Battle.DoAction(0, 0, "SWAP", 1, 0)
                sleep(1000 + SlowModeDelay)
            end
            if (count == 1) then --use FalseSwipe
                Battle.DoAction(0, 0, "SKILL", 206, 0)
                sleep(1000 + SlowModeDelay)
            end
            if (count == 2) then --use Ball
                Battle.DoItemInteraction(0, 0, "ITEM", 5002, 0, -1) --UltraBall
                count = 1
                sleep(1000 + SlowModeDelay)
            end
            count = count + 1
            WaitToAttack()
            if (not Trainer.IsInBattle()) then
                print("Single Shiny Captured!")
                return
            end
        end
    end
end

function DoBattle()
    if (Battle.Active.GetPokemonRarity(1, 1) == "SHINY" or Battle.Active.GetPokemonRarity(1, 2) == "SHINY" or Battle.Active.GetPokemonRarity(1, 3) == "SHINY") then
		print("HORDE SHINY FOUND")
		CatchHordeShiny()
		sleep(2000 + SlowModeDelay)
		return
    end
    if (Battle.Active.GetPokemonID(1, 1) == 56) then
        print(" ========== Mankey Horde ==========")
        MankeyCount = MankeyCount + 1
        while (Trainer.IsInBattle()) do
            LastPokemonHealth = Battle.Active.GetPokemonHealth(0, CurrentPokemon)
            WaitToAttack()
            Battle.DoAction(0, 0, "RUN", 0, 0)
            while (Trainer.IsInBattle()) do
                sleep(200)
            end
            return
        end
    end
    MeowthCount = MeowthCount + 1
    WaitToAttack()
    sleep(2000 + SlowModeDelay)
    if (not Battle.Active.HasPokemonActiveAbility(PokemonName, AbilityName)) then
        print(" ========== Meowth Horde, No Item Found ==========")
        while (Trainer.IsInBattle()) do
            LastPokemonHealth = Battle.Active.GetPokemonHealth(0, CurrentPokemon)
            WaitToAttack()
            Battle.DoAction(0, 0, "RUN", 0, 0)
            while (Trainer.IsInBattle()) do
                sleep(200)
            end
        end
    else
        print(" ========== Meowth Horde, Item Found ==========")
        count = 0
        WaitToAttack()
        while (count <= 2 and not (LastPokemonHealth == -1)) do
            LastPokemonHealth = Battle.Active.GetPokemonHealth(0, CurrentPokemon)
            if (count == 0) then
                Battle.DoAction(0, 0, "SKILL", 168, 17)
                sleep(1000 + SlowModeDelay)
            end
            if (count == 1) then
                Battle.DoAction(0, 0, "SKILL", 168, 33)
                sleep(1000 + SlowModeDelay)
            end
            if (count == 2) then
                Battle.DoAction(0, 0, "SKILL", 168, 49)
                sleep(1000 + SlowModeDelay)
            end
            count = count + 1
            WaitToAttack()
			if(Trainer.IsInBattle()) then
				if (Battle.Active.HasItem(0, 0)) then
					count = 4
				end
			else
				count = 4
			end
        end
        if (LastPokemonHealth == -1) then
            CurrentPokemon = CurrentPokemon + 1
            Battle.DoAction(0, 0, "SWAP", CurrentPokemon, 0)
            sleep(1000 + SlowModeDelay)
        end
        sleep(500)
        WaitToAttack()
        Battle.DoAction(0, 0, "RUN", 0, 0)
        ThiefPP = ThiefPP - 3
        ItemCount = ItemCount + 1
        sleep(3000 + SlowModeDelay)
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

function GoBackToPC()
    sleep(500)
    KeyTyped(TeleportHotkey)
    sleep(5000 + SlowModeDelay)
end

function UseSweetScent()
    KeyTyped(SweetScentHotkey)
    SweetScentPP = SweetScentPP - 5
    Encounters = Encounters + 1
    print(
        "        Encounters : " .. Encounters 	..	
        "        Items : " 			.. ItemCount 		..
        "\n        Mankeys : " 	.. MankeyCount 	..
        "        Meowths : " 		.. MeowthCount 	..
        "\n        Cycles : " 	.. CycleCount 	.. 
        "        Resets : " 		.. ResetCount 	..
		"        ShinyEnc : " 		.. ShinyCount
    )
    sleep(5000 + SlowModeDelay)
end

function FightRoutine()
    CheckForWildEncounter()
    while (true) do
        UseSweetScent()
        sleep(500 + SlowModeDelay)
        if (Trainer.IsInBattle()) then
            DoBattle()
        end
        sleep(1000 + SlowModeDelay)
        Trainer.DoItemChange(PokemonID, -1, "PARTY")
        if (SweetScentPP <= 5 or not (CurrentPokemon == 0) or ThiefPP <= 0) then
            break
        end
        sleep(500 + SlowModeDelay)
    end
end

function Main()
    for i = 1, Cycles do
        Regenerate()
        GoToRoute5()
        FightRoutine()
        GoBackToPC()
        CycleCount = CycleCount + 1
    end
    sleep(1000 + SlowModeDelay)
    HardReset()
end

Main()