Actors = require("Actors")

start = love.timer.getTime()
JIFFY = 1/7

myke = Actors.new { 
	test = "yes",
	tag = "myke",
	costume = "candyking.png",
	x = 100,
	y = 100,
	w = 100,
	h = 100,
}

function myke.animate(self)
	if self.tick == 1 then 
		self:prevClip()
		self.tick = 0
	else 
		self:nextClip()
		self.tick = 1
	end

	self.x = self.x + 1
	return self.animate
end

arse = Actors.new {
    test = "yes",
    tag = "myke",
    costume = "candyking.png",
    x = 100,
    y = 100,
    w = 100,
    h = 100,
}

love.window.setMode(640, 480)

function love.draw()
	Actors.draw()
	if love.timer.getTime() <= start + JIFFY then love.timer.sleep(start + JIFFY - love.timer.getTime()) end
	start = love.timer.getTime()
end
