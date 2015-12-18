keyboard = {}

function keyboard.pressed(key)
  keyboard[key] = true
end

function keyboard.released(key)
  keyboard[key] = false
end
