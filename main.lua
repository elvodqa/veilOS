
require "apps.test_app"

mouse_currently_down = false
mouse_down_x = 0
mouse_down_y = 0
mouse_release_x = 0
mouse_release_y = 0

function love.load()
    love.window.maximize( )
end


function love.update(dt)
    
end


function love.draw()
    render_app(test_app)
end

function render_app(app)
    --   |||||||||||||||||||||||[X]||
    --   |                          | 
    --   |                          |
    --   |                          |
    --   |       love.canvas        |
    --   |                          |
    --   |                          |
    --   |                          |
    --   ||||||||||||||||||||||||||||
    -- add ability to drag window from top bar (not just from top left corner)
    if mouse_currently_down then
        -- check if mouse is in top bar using mouse_down_x and mouse_down_y
        if not holded and love.mouse.getX() > app.window.x and love.mouse.getX() < app.window.x + app.window.width and love.mouse.getY() > app.window.y and love.mouse.getY() < app.window.y + 32 then
            offset_x = app.window.x - mouse_down_x
            offset_y = app.window.y - mouse_down_y
            holded = true
        end
        if love.mouse.isDown(1) and mouse_currently_down then
            if offset_x and offset_y then
                app.window.x = love.mouse.getX() + offset_x
                app.window.y = love.mouse.getY() + offset_y
            end
        end
        if love.mouse.isDown(1) == false then
            offset_x = nil
            offset_y = nil
            holded = false
        end
    end

    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.rectangle('fill', app.window.x, app.window.y, app.window.width, 32) -- top bar
    love.graphics.setColor(255, 0, 0, 255)
    love.graphics.rectangle('fill',
     app.window.x + app.window.width - 32,
     app.window.y,
     32, 32
    )
    love.graphics.setColor(0, 0, 0, 255)
    love.graphics.print(app.window.title, app.window.x + 10, app.window.y+10)

    love.graphics.setCanvas(app.window.canvas)
        love.graphics.clear()
        app.window.draw()
    love.graphics.setCanvas()
    love.graphics.draw(app.window.canvas, app.window.x, app.window.y+32)

    love.graphics.setColor(255, 255, 255, 255)
    love.graphics.rectangle('line', app.window.x, app.window.y+32, app.window.width, app.window.height)
end

function love.mousepressed( x, y, button )
    if button == 1 then
        mouse_currently_down = true
        mouse_down_x = x
        mouse_down_y = y
    end
end

function love.mousereleased(x, y, button)
    if button == 1 then 
        mouse_currently_down = false
        mouse_release_x = x
        mouse_release_y = y
    end
end

-- write a function that gets mouse position relative to given app. consider 32px top bar
function pos_relative_to_app(app)
    return love.mouse.getX() - app.window.x, love.mouse.getY() - app.window.y - 32
end