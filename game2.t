%Version 2.0 -with shoot

View.Set ("title: Apollo's Conquest")
setscreen ("graphics:800;500")
View.Set ("nocursor")

var delayTime : int
var x : int := 297
var y : int := 235
var chars : array char of boolean
var mousex, mousey : int
var button : int := 0
var bulletx : int := 0
var bullety : int := 0

var numFrames1 := Pic.Frames ("apollo1.gif")
var pics1 : array 1 .. numFrames1 of int
Pic.FileNewFrames ("apollo1.gif", pics1, delayTime)
var sprite1 : int := Sprite.New (pics1 (1))
Sprite.SetPosition (sprite1, x, y, false)

var numFrames2 := Pic.Frames ("apollo2.gif")
var pics2 : array 1 .. numFrames2 of int
Pic.FileNewFrames ("apollo2.gif", pics2, delayTime)
var sprite2 : int := Sprite.New (pics2 (1))
Sprite.SetPosition (sprite2, x, y, false)

var numFrames3 := Pic.Frames ("apollo3.gif")
var pics3 : array 1 .. numFrames3 of int
Pic.FileNewFrames ("apollo3.gif", pics3, delayTime)
var sprite3 : int := Sprite.New (pics3 (1))
Sprite.SetPosition (sprite3, x, y, false)

var numFrames4 := Pic.Frames ("apollo4.gif")
var pics4 : array 1 .. numFrames4 of int
Pic.FileNewFrames ("apollo4.gif", pics4, delayTime)
var sprite4 : int := Sprite.New (pics4 (1))
Sprite.SetPosition (sprite4, x, y, false)

var pictCursor : int := Pic.FileNew ("target.bmp")
var spriteCursor : int := Sprite.New (pictCursor)

var money : int := 0
var intelligence, strength, defense, speed : int := 0
var range : int := 100

var pictWeaponright : int := Pic.FileNew ("arrow2.bmp")
var spriteWeaponright : int := Sprite.New (pictWeaponright)
Sprite.SetPosition (spriteWeaponright, bulletx, bullety, true)
var pictWeaponup : int := Pic.FileNew ("arrow1.bmp")
var spriteWeaponup : int := Sprite.New (pictWeaponup)
Sprite.SetPosition (spriteWeaponup, bulletx, bullety, true)
var pictWeapondown : int := Pic.FileNew ("arrow3.bmp")
var spriteWeapondown : int := Sprite.New (pictWeapondown)
Sprite.SetPosition (spriteWeapondown, bulletx, bullety, true)
var pictWeaponleft : int := Pic.FileNew ("arrow4.bmp")
var spriteWeaponleft : int := Sprite.New (pictWeaponleft)
Sprite.SetPosition (spriteWeaponleft, bulletx, bullety, true)

process shoot
    if button = 1 and mousex > x and mousey > y - 20 and mousey < y + 74 then
	var bulletx := x + 63
	var bullety := y + 23
	for i : bulletx .. bulletx + range by 5
	    Sprite.Show (spriteWeaponright)
	    Sprite.SetPosition (spriteWeaponright, i, bullety, true)
	    delay (1)
	    View.Update
	    exit when whatdotcolour (i + 16, bullety) = 15
	end for
	Sprite.Hide (spriteWeaponright)

    elsif button = 1 and mousex < x and mousey > y - 20 and mousey < y + 74 then
	var bulletx := x - 10
	var bullety := y + 23
	for decreasing i : bulletx .. bulletx - range by 5
	    Sprite.Show (spriteWeaponleft)
	    Sprite.SetPosition (spriteWeaponleft, i, bullety, true)
	    delay (1)
	    View.Update
	    exit when whatdotcolour (i - 16, bullety) = 15
	end for
	Sprite.Hide (spriteWeaponleft)

    elsif button = 1 and mousey > y then
	var bulletx := x + 24
	var bullety := y + 64
	for i : bullety .. bullety + range by 5
	    Sprite.Show (spriteWeaponup)
	    Sprite.SetPosition (spriteWeaponup, bulletx, i, true)
	    delay (1)
	    View.Update
	    exit when whatdotcolour (bulletx, i + 16) = 15
	end for
	Sprite.Hide (spriteWeaponup)

    elsif button = 1 and mousey < y then
	var bulletx := x + 24
	var bullety := y - 10
	for decreasing i : bullety .. bullety - range by 5
	    Sprite.Show (spriteWeapondown)
	    Sprite.SetPosition (spriteWeapondown, bulletx, i, true)
	    delay (1)
	    View.Update
	    exit when whatdotcolour (bulletx, i - 16) = 15
	end for
	Sprite.Hide (spriteWeapondown)
    end if
    View.Update
end shoot

procedure movement
    Input.KeyDown (chars)
    % for y : 8 .. maxx by 8
    if chars ('s') then
	y -= 3
	bullety -= 3
	Sprite.Show (sprite1)
	Sprite.Hide (sprite2)
	Sprite.Hide (sprite3)
	Sprite.Hide (sprite4)
	Sprite.Animate (sprite1, pics1 ((y div 8) mod numFrames1 + 1), x, y, false)
	delay (40)
    elsif chars ('w') then
	y += 3
	bullety += 3
	Sprite.Show (sprite2)
	Sprite.Hide (sprite1)
	Sprite.Hide (sprite3)
	Sprite.Hide (sprite4)
	Sprite.Animate (sprite2, pics2 ((y div 8) mod numFrames2 + 1), x, y, false)
	delay (40)

    elsif chars ('d') then
	x += 3
	bulletx += 3
	Sprite.Show (sprite3)
	Sprite.Hide (sprite1)
	Sprite.Hide (sprite2)
	Sprite.Hide (sprite4)
	Sprite.Animate (sprite3, pics3 ((x div 8) mod numFrames3 + 1), x, y, false)
	delay (40)

    elsif chars ('a') then
	x -= 3
	bulletx -= 3
	Sprite.Show (sprite4)
	Sprite.Hide (sprite1)
	Sprite.Hide (sprite2)
	Sprite.Hide (sprite3)
	Sprite.Animate (sprite4, pics4 ((x div 8) mod numFrames4 + 1), x, y, false)
	delay (40)
    end if
    View.Update
end movement

process sidebar
    if button = 1 and mousex > maxx - 185 and mousey > 225 and mousex < maxx - 160 and mousey < 240 and whatdotcolour (mousex, mousey) = 22 then
	drawfillbox (maxx - 185, 225, maxx - 160, 240, 18)
	drawfillbox (maxx - 215, 225, maxx - 190, 240, 22)
	drawfillbox (maxx - 10, 80, maxx - 215, 225, 18)
	%show stats and hide the item sprites
    end if

    if button = 1 and mousex > maxx - 215 and mousey > 225 and mousex < maxx - 190 and mousey < 240 and whatdotcolour (mousex, mousey) = 22 then
	drawfillbox (maxx - 185, 225, maxx - 160, 240, 22)
	drawfillbox (maxx - 215, 225, maxx - 190, 240, 18)
	drawfillbox (maxx - 10, 80, maxx - 215, 225, 18)
	drawfillbox (maxx - 215, 225, maxx - 190, 240, 18)
	drawfillbox (maxx - 203, 215, maxx - 162, 174, 22)
	drawfillbox (maxx - 157, 215, maxx - 116, 174, 22)
	drawfillbox (maxx - 111, 215, maxx - 70, 174, 22)
	drawfillbox (maxx - 65, 215, maxx - 24, 174, 22)
	drawfillbox (maxx - 203, 169, maxx - 162, 128, 22)
	drawfillbox (maxx - 157, 169, maxx - 116, 128, 22)
	drawfillbox (maxx - 111, 169, maxx - 70, 128, 22)
	drawfillbox (maxx - 65, 169, maxx - 24, 128, 22)
	drawfillbox (maxx - 203, 118, maxx - 116, 88, 22)
	drawfillbox (maxx - 111, 118, maxx - 24, 88, 22)
	%add on items as sprites/show them
    end if

    %addhealth pots and moving of items
    %arrays
end sidebar

procedure transition
    drawfillbox (0, 0, 575, 500, black)
    Sprite.Hide (sprite1)
    Sprite.Hide (sprite2)
    Sprite.Hide (sprite3)
    Sprite.Hide (sprite4)
    Sprite.Hide (sprite1)
    Sprite.Hide (spriteWeaponup)
    Sprite.Hide (spriteWeapondown)
    Sprite.Hide (spriteWeaponright)
    Sprite.Hide (spriteWeaponleft)
    delay (1000)
end transition

procedure wallrestrictions
    if whatdotcolour (x, y) = 15 or whatdotcolour (x + 48, y + 54) = 15 or whatdotcolour (x + 48, y) = 15 or whatdotcolour (x, y + 54) = 15 then
	if x < 288 then
	    x := x + 5
	    bulletx := bulletx + 5
	end if
	if x > 288 then
	    x := x - 5
	    bulletx := bulletx - 5
	end if
	if y > 250 then
	    y := y - 5
	    bullety := bullety - 5
	end if
	if y < 250 then
	    y := y + 5
	    bullety := bullety + 5
	end if
    end if
end wallrestrictions

process cursor
    Mouse.Where (mousex, mousey, button)
    Sprite.SetPosition (spriteCursor, mousex, mousey, true)
end cursor

%SIDE BAR
drawfillbox (maxx, 0, maxx - 225, maxy, 19)
drawfillbox (maxx - 10, 80, maxx - 215, 225, 18)
%inventory
drawfillbox (maxx - 215, 225, maxx - 190, 240, 18)
drawfillbox (maxx - 203, 215, maxx - 162, 174, 22)
drawfillbox (maxx - 157, 215, maxx - 116, 174, 22)
drawfillbox (maxx - 111, 215, maxx - 70, 174, 22)
drawfillbox (maxx - 65, 215, maxx - 24, 174, 22)
drawfillbox (maxx - 203, 169, maxx - 162, 128, 22)
drawfillbox (maxx - 157, 169, maxx - 116, 128, 22)
drawfillbox (maxx - 111, 169, maxx - 70, 128, 22)
drawfillbox (maxx - 65, 169, maxx - 24, 128, 22)
drawfillbox (maxx - 203, 118, maxx - 116, 88, 22)
drawfillbox (maxx - 111, 118, maxx - 24, 88, 22)
%equip
drawbox (maxx - 203, 291, maxx - 162, 250, 22)
drawbox (maxx - 157, 291, maxx - 116, 250, 22)
drawbox (maxx - 111, 291, maxx - 70, 250, 22)
drawbox (maxx - 65, 291, maxx - 24, 250, 22)

%stats
drawfillbox (maxx - 185, 225, maxx - 160, 240, 22)

Sprite.Show (sprite1)

loop
    %game
    Sprite.Show (spriteCursor)
    fork cursor
    if whatdotcolour (x, y) = black and whatdotcolour (bulletx, bullety) = black then
	Sprite.Hide (sprite1)
	Sprite.Hide (sprite2)
	Sprite.Hide (sprite3)
	Sprite.Hide (sprite4)
	Sprite.Hide (sprite1)
	Sprite.Hide (spriteWeaponup)
	Sprite.Hide (spriteWeapondown)
	Sprite.Hide (spriteWeaponright)
	Sprite.Hide (spriteWeaponleft)
	delay (10000)
    end if

    %TUTORIAL STAGES
    Pic.ScreenLoad ("stage1back.bmp", 0, 0, picMerge)
    loop
	movement
	fork sidebar
	%add more to sidebar****
	fork shoot
	fork cursor
	View.Update
	wallrestrictions
	exit when x < 0 and y > 200 and y < 400
    end loop
    drawfillbox (0, 0, 575, 500, black)
    
    x := 527
    y := 230
    Sprite.Show (sprite4)
    Pic.ScreenLoad ("stage2back.bmp", 0, 0, picMerge)
    loop
	movement
	fork sidebar
	fork shoot
	fork cursor
	View.Update
	wallrestrictions
	exit when x > 215 and x < 355 and y < 0
    end loop
    drawfillbox (0, 0, 575, 500, black)

end loop
