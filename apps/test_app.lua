
test_app = {
    window = {
        title = "Test App",
        x = 0,
        y = 0,
        width = 600,
        height = 400,
        canvas = love.graphics.newCanvas(600, 400)
    }
}


test_app.window.draw = function ()
    love.graphics.setColor(255, 255, 0, 255)
    love.graphics.print("This is a test", 1, 1)
    love.graphics.rectangle('fill', 100, 100, 40, 70)
end