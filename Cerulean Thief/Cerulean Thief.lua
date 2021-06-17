ThiefPP = 40
SweetScentPP = 32
LastPokemonHealth = 12
CurrentPokemon = 0
Encounters = -1
ResetCount = 0
MankeyCount = 0
MeowthCount = 0
FixBushCount = 0
CycleCount = 0
PokemonID = 217669031 -- Change That, you get the Pokemon ID by enabling debugging and changing the Item
PokemonName = "MEOWTHEATER69"
AbilityName = "Frisk"
ItemCount = 0
SweetScentHotkey = "h9"
TeleportHotkey = "h8"
Cycles = 30 -- Cycles before reset, 10 Cycles = c.a. 30 minutes

--FIX BUSH IF FRESH LOGIN

function RelogReset()
	print("Resetting...")
	GoOutOfPC()
	sleep(500)
	CheckForWildEncounter()
	GoBackToPC()
	sleep(1500)
	Logout()
	sleepm(1)
	Login()
	sleep(2000)
		if(Trainer.GetMapID() == -1) then
			KeyTyped("A")
			sleep(4000)
			CheckForWildEncounter()
			GoBackToPC()
		end
	sleep(5000)
	ResetCount = ResetCount + 1
	print("Success... "..ResetCount.." Relog(s)")
end


function FixBush()
	print("Fixing Bush...")
	GoOutOfPC()
	sleep(500)
	GoToBush1()
	sleep(500)
	CutBush()
	sleep(5000)
	GoBackToPC()
	sleep(1500)
	FixBushCount = FixBushCount + 1
	print("Success... "..FixBushCount.." Fixed")
end


function HardReset()
	RelogReset()
	FixBush()
	Main()
end


function CheckPosition(X, Y)
	ErrorCorrection(X, Y)
	if(not (Trainer.GetX() == X and Trainer.GetY() == Y)) then
		print("Incorrect Position, Hard Resetting...")
		HardReset()
	end
end


function ErrorCorrection(X, Y)
	cX = Trainer.GetX()
	cY = Trainer.GetY()
	dX = X - cX
	dY = Y - cY

	if(not (dX < 5 and dX > -5) or not (dY < 5 and dY > -5)) then
		return
	end

	if(dX == 0 and dY == 0) then
		return
	end

	print("Correcting Position...")
	if(dX > 0) then
		while(Trainer.GetX() < X) do
			Trainer.MoveRight(true, 1)
		end
	end
	if(dX < 0) then
		while(Trainer.GetX() > X) do
			Trainer.MoveLeft(true, 1)
		end
	end
	if(dY > 0) then
		while(Trainer.GetY() < Y) do
			Trainer.MoveDown(true, 1)
		end
	end
	if(dY < 0) then
		while(Trainer.GetY() > Y) do
			Trainer.MoveUp(true, 1)
		end
	end
	sleep(500)
end


function GoOutOfPC()
	Trainer.MoveDown(true, 6)
	sleep(2000)
	while(Trainer.IsMovementBlocked()) do
		sleep(2000)
	end
end


function Regenerate()	
	sleep(2000)
	Trainer.TalkToNPC()
	sleep(1000)
	KeyTyped("a")
	sleep(1000)
	KeyTyped("a")
	sleep(1000)
	KeyTyped("a")
	sleep(1000)
	KeyTyped("a")
	sleep(1000)
	KeyTyped("a")
	sleep(1000)
	KeyTyped("a")
	ThiefPP = 40
	SweetScentPP = 32
	CurrentPokemon = 0
	GoOutOfPC();
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
	Trainer.TalkToNPC()
	sleep(1000)
	KeyTyped("a")
	sleep(1000)
	KeyTyped("a")
	sleep(1000)
	KeyTyped("a")
	sleep(2000)
end


function GoToRoute5()
	CheckPosition(22,20)
	choice = random(1,5)
	if(choice == 1) then
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
	CheckPosition(26,31)
	CutBush()
	Trainer.MoveDown(true, 5)
	sleep(1000)
	Trainer.MoveDown(true, 7)
	sleep(1000)
	CheckPosition(26,5)
end


function WaitToAttack()
	while(not Battle.CanAttack()) do
		sleep(500)
	end
end


function DoBattle()
	if(Battle.Active.GetPokemonRarity(1, 1) == "SHINY" or Battle.Active.GetPokemonRarity(1, 2) == "SHINY" or Battle.Active.GetPokemonRarity(1, 3) == "SHINY") then
		print(" ========== SHINY FOUND ==========")
		sleeph(24)
	end
	if(Battle.Active.GetPokemonID(1, 1) == 56) then
		print(" ========== Mankey Horde ==========")
		MankeyCount = MankeyCount + 1
		while (Trainer.IsInBattle()) do 
			LastPokemonHealth = Battle.Active.GetPokemonHealth(0,CurrentPokemon)
			WaitToAttack()
			Battle.DoAction(0,0,"RUN",0,0)
			while(Trainer.IsInBattle()) do
				sleep(200)
			end
			return
		end
	end
	MeowthCount = MeowthCount + 1
	WaitToAttack()
	sleep(1000)
	if(not Battle.Active.HasPokemonActiveAbility(PokemonName, AbilityName)) then
		print(" ========== Meowth Horde, No Item Found ==========")
		while (Trainer.IsInBattle()) do 
			LastPokemonHealth = Battle.Active.GetPokemonHealth(0,CurrentPokemon)
			WaitToAttack()
			Battle.DoAction(0,0,"RUN",0,0)
			while(Trainer.IsInBattle()) do
				sleep(200)
			end
		end
	else
		print(" ========== Meowth Horde, Item Found ==========")
		count = 0;
		WaitToAttack()
		while(count <= 2 and not (LastPokemonHealth == -1)) do
			LastPokemonHealth = Battle.Active.GetPokemonHealth(0,CurrentPokemon)
			if(count == 0) then
				Battle.DoAction(0,0,"SKILL",168,17)
				sleep(1000)
			end
			if(count == 1) then
				Battle.DoAction(0,0,"SKILL",168,33)
				sleep(1000)
			end
			if(count == 2) then
				
				Battle.DoAction(0,0,"SKILL",168,49)
				sleep(1000)
			end
			count = count + 1
			WaitToAttack()
			if(Battle.Active.HasItem(0,0)) then
				count = 4
			end
		end
		if(LastPokemonHealth == -1) then
			CurrentPokemon = CurrentPokemon + 1
			Battle.DoAction(0,0,"SWAP",CurrentPokemon,0)
			sleep(1000)
		end
		sleep(500)
		WaitToAttack()
		Battle.DoAction(0,0,"RUN",0,0)
		ThiefPP = ThiefPP - 3
		ItemCount = ItemCount + 1
		sleep(3000)
	end
end


function CheckForWildEncounter()
	if(Trainer.IsInBattle()) then
		print("Wild Encounter")
		if(Battle.Active.GetPokemonRarity(1, 0) == "SHINY") then
		print("SHINY FOUND")
		sleeph(24)
		end
		LastPokemonHealth = Battle.Active.GetPokemonHealth(0,CurrentPokemon)
		if(LastPokemonHealth == -1) then
			CurrentPokemon = CurrentPokemon + 1
			WaitToAttack()
			Battle.DoAction(0,0,"SWAP",CurrentPokemon,0)
			sleep(1000)
		end
		WaitToAttack()
		Battle.DoAction(0,0,"RUN",0,0)
		sleep(2000)
	end
end


function GoBackToPC()
	sleep(500)
	KeyTyped(TeleportHotkey)
	sleep(5000)
end


function UseSweetScent()
	KeyTyped(SweetScentHotkey)
	SweetScentPP = SweetScentPP - 5
	Encounters = Encounters + 1
	print("        Encounters : "..Encounters.."        Items : "..ItemCount.."\n        Mankeys : "..MankeyCount.."        Meowths : "..MeowthCount.."\n        Cycles : "..CycleCount.."        Resets : "..ResetCount)
	sleep(5000)
end


function FightRoutine()
	CheckForWildEncounter()
	while(true) do
		UseSweetScent()
		sleep(500)
		if(Trainer.IsInBattle()) then
			DoBattle()
		end
		sleep(1000)
		Trainer.DoItemChange(PokemonID,-1,"PARTY")
		if(SweetScentPP <= 5 or not (CurrentPokemon == 0) or ThiefPP <= 0) then
			break
		end
		sleep(500)
	end
end


function Main()
	for i=1,Cycles do
		Regenerate()
		GoToRoute5()
		FightRoutine()
		GoBackToPC()
		CycleCount = CycleCount + 1
	end
	sleep(1000)
	HardReset()
end

Main();