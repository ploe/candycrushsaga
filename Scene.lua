local lib = {
	w = 1366,
	h = 480,
	x = 0,
	y = 0,
}

function lib:setViewport(x, y)
	local max_x = self.w - stage.w
	local max_y = self.h - stage.h

	if x <= 0 then self.x = 0
	elseif x >= max_x  then x = max_x
	else self.x = x end

	if y <= 0 then self.y = 0
	elseif y >= max_y  then self.y = max_y
	else self.y = y end
end

function lib:updateViewport()
	love.graphics.translate(-self.x, -self.y)
end

return lib
