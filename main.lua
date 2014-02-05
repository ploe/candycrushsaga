Actors = require("Actors")
Scene = require("Scene")

start = love.timer.getTime()
JIFFY = 1/30

local FACE_RIGHT = 0
local FACE_LEFT = 1

myke = Actors.new { 
	test = "yes",
	tag = "myke",
	costume = "candyking.png",
	x = 100,
	y = 320,
	w = 100,
	h = 100,
	dir = FACE_RIGHT,
	ticks = 0,
}

local Mouse = {}

function myke:update()
	if Mouse["buttonl"] then
		self.puck = Mouse.x
		if self.puck < self.x or self.puck > self.x + self.w then
			if Mouse.x < self.x then self.dir = FACE_LEFT
			elseif Mouse.y > self.x + self.w then self.dir = FACE_RIGHT end
			self.animate = self.walk
		end
	end

	if Mouse["buttonr"] then
		self.animate = self.stood
	end
end

function myke:stood()
	self:jumpReel(1)
	self.ticks = self.ticks + 1/4
	if self.ticks == 1 then
		self:nextClip()
	elseif self.ticks == 2 then 
		self:prevClip()
		self.ticks = 0
	end

	self:setFocus()
	return self.stood
end

function myke:chat()
	self:jumpReel(2)
	self.ticks = self.ticks + 1/4
	if self.ticks ~= 4 then self:nextClip()
	else
		self:jumpClip(1)
		self.ticks = 0
	end

	self:setFocus() 
	return self.chat
end

function myke:walk()
	self:jumpReel(3+self.dir)
	local vector = 4
	if self.dir == FACE_LEFT then vector = -vector end

	self.ticks = self.ticks + 1/4
	self.x = self.x + vector
	if math.floor(self.ticks) == self.ticks then
		if self.ticks <= 2 then
			self:nextClip()
		elseif self.ticks <= 4 then 
			self:prevClip()
			if(self.ticks == 4) then self.ticks = 0 end
		end
	end

	self:setFocus()
	
	if self.puck > self.x and self.puck < self.x + self.w then return self.stood end
	return self.walk
end

myke.animate = myke.stood

local bunting1 = Actors.new {
	tag = "bunting",
	costume = "bunting.png",
	x = 0,
	y = 0,
	w = 446,
	h = 64,
}

local bunting2 = Actors.new {
	tag = "bunting",
	costume = "bunting2.png",
	x = 447,
	y = 0,
	w = 446,
	h = 64,
}

function bunting1:animate()
	self.ticks = self.ticks + 1/4

	if math.floor(self.ticks) == self.ticks  then
		if self.boil then 
			self:jumpReel(1)
			self.boil = false
		else
			self:jumpReel(2)
			self.boil = true
		end
	end

	return self.animate
end

bunting2.animate = bunting1.animate

function say(self)
	self.animate = self.chat
	love.graphics.setColor(0, 36, 189)
	love.graphics.rectangle("fill", Scene.x, self.y-32, stage.w, 32)
	love.graphics.setColor(255, 255, 255)
	love.graphics.printf(self.tag .. ": hello, world", Scene.x+8, self.y-32+8, stage.w-8, "left")
end

function love.update()
	Actors.update()
end

stage = {w = 640, h = 480}
love.window.setMode(stage.w, stage.h)
love.graphics.setBackgroundColor(251,149,134)
function love.draw()
	Scene:updateViewport()
	Actors.draw()
	if love.timer.getTime() <= start + JIFFY then love.timer.sleep(start + JIFFY - love.timer.getTime()) end
	start = love.timer.getTime()
end

function love.mousepressed(x, y, button)
	Mouse.x = love.mouse.getX() + Scene.x
	Mouse.y = love.mouse.getY() + Scene.y
	Mouse["button" .. button] = true
end

function love.mousereleased(x, y, button)
	Mouse["button" .. button] = false
end
