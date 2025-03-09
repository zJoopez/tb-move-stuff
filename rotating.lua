-- Function to rotate a point around the X axis
local function rotateX(x, y, z, angle)
    local cosA, sinA = math.cos(angle), math.sin(angle)
    return x, cosA * y - sinA * z, sinA * y + cosA * z
end

-- Function to rotate a point around the Y axis
local function rotateY(x, y, z, angle)
    local cosA, sinA = math.cos(angle), math.sin(angle)
    return cosA * x + sinA * z, y, -sinA * x + cosA * z
end

-- Function to rotate a point around the Z axis
local function rotateZ(x, y, z, angle)
    local cosA, sinA = math.cos(angle), math.sin(angle)
    return cosA * x - sinA * y, sinA * x + cosA * y, z
end

function SetRotPos(obj, center, offset)
    -- Translate object to origin (relative to the center of rotation)
    local x, y, z = obj.x - center.x, obj.y - center.y, obj.z - center.z

    -- Apply rotations in 3D space
    x, y, z = rotateX(x, y, z, offset.x) -- Rotate around X axis
    x, y, z = rotateY(x, y, z, offset.y) -- Rotate around Y axis
    x, y, z = rotateZ(x, y, z, offset.z) -- Rotate around Z axis

    -- Translate object back to its new position
    obj.x, obj.y, obj.z = x + center.x, y + center.y, z + center.z
end

-- Function to rotate the group of objects in 3D
function SetRotOffset(rot, offset)
    -- Update the object's local rotation (pitch, yaw, roll)
    rot[1] = math.deg((rot[1] - offset.x)) % 360
    rot[2] = math.deg((rot[2] - offset.y)) % 360
    rot[3] = math.deg((rot[3] - offset.z)) % 360
end
