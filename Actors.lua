local actors = {}
local lib = {}

function lib.new(a)
	if type(a) ~= "table" or not a.tag then return nil end

	if not a.costume then return nil end
	local costume = love.graphics.newImage(a.costume)

	if not a.w or not a.h then return nil end
	local reel = 1
	local clip = 1
	local quad = love.graphics.newQuad(a.w * (clip-1), a.h *(reel-1), a.w, a.h, costume:getWidth(), costume:getHeight())

	function a:draw()
		quad:setViewport(a.w * (clip-1), a.h * (reel-1), a.w, a.h)
		if type(self.animate) ==  "function" then self.animate = self:animate() end
		love.graphics.draw(costume, quad, self.x, self.y)
	end

	function a:jumpReel(i)
		if reel ~= i then
			self.ticks = 0
			clip = 1 
			reel = i
		end
	end

	function a:jumpClip(i)
		clip = i
	end

	function a:prevClip()
		clip = clip - 1
	end

	function a:nextClip()
		clip = clip + 1
	end

	function a:setFocus()
		local x, y
		x = (self.x + self.w /2) - stage.w / 2 
		y = (self.y + self.h /2) - stage.h / 2
		Scene:setViewport(x, y)
	end

	table.insert(actors, a)
	return a
end

-- update is for AI

function lib.update()
	for k in ipairs(actors) do
		if actors[k].update then actors[k]:update() end	
	end
end

-- draw is for animation

function lib.draw()
	for k in ipairs(actors) do
		if actors[k].draw then actors[k]:draw() end			
	end
end

return lib
