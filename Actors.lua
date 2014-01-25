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
		reel = i
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

	table.insert(actors, a)
	return a
end

function lib.draw()
	for k in ipairs(actors) do
		actors[k]:draw()			
	end
end

return lib
