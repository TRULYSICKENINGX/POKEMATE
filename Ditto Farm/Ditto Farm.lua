FalseSwipePP = 48
AssistPP = 32
BikeHotkey = "h2"
TeleportHotkey = "h8"
DigHotkey = "h6"
DittosCaptured = 0
ThrownBalls = 0
BallsUsed = 0
Cycles = 99 --one cycle yields around 25 Dittos
DittoGoal = 999 --set this
TotalBalls = 150 --set this

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
	sleep(3000)
	while(Trainer.IsMovementBlocked()) do
		sleep(3000)
	end
end


function Regenerate()
	CheckPosition(7,4)
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
	sleep(1000)
	KeyTyped("a")
	FalseSwipePP = 48
	AssistPP = 32
	GoOutOfPC();
end


function GoToDitto1()
	Trainer.MoveLeft(true, 8)
	CheckPosition(7, 8)
	Trainer.MoveDown(true, 2)
	CheckPosition(7, 9)
	Trainer.MoveLeft(true, 19)
	CheckPosition(29, 9)
	Trainer.MoveUp(true, 5)
	sleep(3000)
	CheckPosition(4, 7)
	Trainer.MoveUp(true, 6)
	sleep(3000)
	CheckPosition(6, 25)
	Trainer.MoveUp(true, 19)
	CheckPosition(6, 6)
	Trainer.MoveLeft(true, 2)
	CheckPosition(5, 6)
	Trainer.MoveUp(true, 3)
	CheckPosition(5, 4)
	Trainer.MoveRight(true, 2)
	CheckPosition(6, 4)
	Trainer.MoveUp(true, 3)
	sleep(3000)
	CheckPosition(10, 12)
	Trainer.MoveUp(true, 2)
end
function GoToDitto2()
	Trainer.MoveLeft(true, 8)
	CheckPosition(7, 8)
	Trainer.MoveDown(true, 2)
	CheckPosition(7, 9)
	Trainer.MoveLeft(true, 19)
	CheckPosition(29, 9)
	Trainer.MoveUp(true, 5)
	sleep(3000)
	CheckPosition(4, 7)
	Trainer.MoveUp(true, 6)
	sleep(3000)
	CheckPosition(6, 25)
	Trainer.MoveUp(true, 19)
	CheckPosition(6, 6)
	Trainer.MoveLeft(true, 2)
	CheckPosition(5, 6)
	Trainer.MoveUp(true, 3)
	CheckPosition(5, 4)
	Trainer.MoveRight(true, 2)
	CheckPosition(6, 4)
	Trainer.MoveUp(true, 3)
	sleep(3000)
	CheckPosition(10, 12)
	Trainer.MoveUp(true, 2)
end
function GoToDitto3()
	Trainer.MoveLeft(true, 8)
	CheckPosition(7, 8)
	Trainer.MoveDown(true, 2)
	CheckPosition(7, 9)
	Trainer.MoveLeft(true, 19)
	CheckPosition(29, 9)
	Trainer.MoveUp(true, 5)
	sleep(3000)
	CheckPosition(4, 7)
	Trainer.MoveUp(true, 6)
	sleep(3000)
	CheckPosition(6, 25)
	Trainer.MoveUp(true, 19)
	CheckPosition(6, 6)
	Trainer.MoveLeft(true, 2)
	CheckPosition(5, 6)
	Trainer.MoveUp(true, 3)
	CheckPosition(5, 4)
	Trainer.MoveRight(true, 2)
	CheckPosition(6, 4)
	Trainer.MoveUp(true, 3)
	sleep(3000)
	CheckPosition(10, 12)
	Trainer.MoveUp(true, 2)
end


function GoToDitto()
	sleep(2000)
	KeyTyped(BikeHotkey)
	choice = random(1,3)
	if(choice == 1) then
		GoToDitto1()
	end
	if (choice == 2) then
		GoToDitto2()
	end
	if (choice == 3) then
		GoToDitto3()
	end
	sleep(300)
	CheckPosition(10,10)
	sleep(300)
end


function WaitToAttack()
    while(not Battle.CanAttack() and Trainer.IsInBattle()) do
        sleep(500)
    end
end


function DoBattle()
	if(Battle.Active.GetPokemonID(1, 0) ~= 132) then
		count = 0;
		while (Trainer.IsInBattle()) do

			WaitToAttack()

			Battle.DoAction(0,0,"RUN",0,0)
			print("Escaped!")
			while(Trainer.IsInBattle()) do
				sleep(1000)
			end
		end
	else
		count = 0;
		BallsUsed = 0;
		WaitToAttack()
		while(count <= 4) do
			if(count == 0) then --swap to Smeargle
				Battle.DoAction(0,0,"SWAP",1,0)
				sleep(1000)
			end
			if(count == 1) then --use FalseSwipe
				Battle.DoAction(0,0,"SKILL",206,0)
				FalseSwipePP = FalseSwipePP - 1
				sleep(1000)
			end
			if(count == 2) then --use Assist
				Battle.DoAction(0,0,"SKILL",274,0)
				AssistPP = AssistPP - 1
				sleep(1000)
			end
			if(count == 3) then --use Ball
				--Battle.DoItemInteraction(0,0,"ITEM",5002,0,-1) UltraBall
				Battle.DoItemInteraction(0,0,"ITEM",5009,0,-1) --RepeatBall
				ThrownBalls = ThrownBalls + 1
				BallsUsed = BallsUsed + 1
				sleep(1000)
			end
			if(count == 4) then --use Ball Two
				--Battle.DoItemInteraction(0,0,"ITEM",5002,0,-1) UltraBall
				Battle.DoItemInteraction(0,0,"ITEM",5009,0,-1) --RepeatBall
				ThrownBalls = ThrownBalls + 1
				BallsUsed = BallsUsed + 1
				count = 1
				sleep(1000)
			end
            count = count + 1
            WaitToAttack()
            if(not Trainer.IsInBattle()) then
                DittosCaptured = DittosCaptured + 1
				print("Captured! Used "..BallsUsed.." Ball(s).")
                return
            end

		end
	end
end


function GoBackToPC()
	KeyTyped(DigHotkey)
	sleep(5000)
	Trainer.MoveDown(true, 1)
	Trainer.MoveLeft(true, 2)
	Trainer.MoveDown(true, 3)
	Trainer.MoveRight(true, 2)
	Trainer.MoveDown(true, 21)
	sleep(3000)
	Trainer.MoveDown(true, 6)
	sleep(3000)
	KeyTyped(TeleportHotkey)
	sleep(5000)
end


function SearchBattle()
	print("Searching for a Battle")
	sleep(2000)
	if(Trainer.IsInBattle()) then
		return
	end
	RightGoing = false;
	while(true) do
		if(Trainer.IsInBattle()) then
			return
		end
		if(Trainer.GetX() <= 38 and RightGoing) then
			Trainer.MoveRight(true, 1)
		else
			RightGoing = false
			Trainer.MoveLeft(true, 1)
			if(Trainer.GetX() <= 9) then
				RightGoing = true
			end
		end
	end
end


function SearchForDitto()
	KeyTyped(BikeHotkey)
	while(true) do
		SearchBattle()
		sleep(1000)
		DoBattle()
		sleep(1000)

		--KeyTyped("b")

		print("Assist PP = "..AssistPP.." / FalseSwipe PP = "..FalseSwipePP.." / Available Balls = "..(TotalBalls-ThrownBalls).." / Catch Rate = "..(DittosCaptured/ThrownBalls*100).." / Ditto Goal = "..DittoGoal.." / Dittos = "..DittosCaptured)

		if(FalseSwipePP < 4 or AssistPP < 4) then
			break
		end
		sleep(500)
	end
	if(DittosCaptured==DittoGoal or ThrownBalls==TotalBalls) then --conditions to end farming
	Logout()
	sleeph(24)
	end
end


function Main()
	for i=1,Cycles do
		Regenerate()
		print("Healed")
		GoToDitto()
		print("Arrived at Ditto Cave")
		SearchForDitto()
		print("Out of PP")
		GoBackToPC()
		print("Arrived at PokeCenter")
	end
	Logout()
	Stop()
end

Main();
