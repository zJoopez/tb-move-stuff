-- -- Define a 3x3 rotation matrix for each axis
local function rotation_matrix_x(angle)
    local cos, sin = math.cos(angle), math.sin(angle)
    return {
        { 1, 0,   0 },
        { 0, cos, -sin },
        { 0, sin, cos }
    }
end

local function rotation_matrix_y(angle)
    local cos, sin = math.cos(angle), math.sin(angle)
    return {
        { cos,  0, sin },
        { 0,    1, 0 },
        { -sin, 0, cos }
    }
end

local function rotation_matrix_z(angle)
    local cos, sin = math.cos(angle), math.sin(angle)
    return {
        { cos, -sin, 0 },
        { sin, cos,  0 },
        { 0,   0,    1 }
    }
end

-- -- Matrix multiplication
local function matrix_multiply(a, b)
    local result = {}
    for i = 1, #a do
        result[i] = {}
        for j = 1, #b[1] do
            result[i][j] = 0
            for k = 1, #a[1] do
                result[i][j] = result[i][j] + a[i][k] * b[k][j]
            end
        end
    end
    return result
end

-- -- apply the rotation matrix to a point
function RotatePoint(point, rotationMatrix)
    local x = point[1] * rotationMatrix[1][1] + point[2] * rotationMatrix[1][2] + point[3] * rotationMatrix[1][3]
    local y = point[1] * rotationMatrix[2][1] + point[2] * rotationMatrix[2][2] + point[3] * rotationMatrix[2][3]
    local z = point[1] * rotationMatrix[3][1] + point[2] * rotationMatrix[3][2] + point[3] * rotationMatrix[3][3]
    return { x, y, z }
end

function GetDefaultRotationMatrix(rotangles)
    return matrix_multiply(rotation_matrix_z(rotangles[3]),
        matrix_multiply(rotation_matrix_y(rotangles[2]), rotation_matrix_x(rotangles[1])))
end

function GetRotatedPos(rotationMatrix, axisPoint, pos)
    -- Translate objects to origin
    pos = { pos[1] - axisPoint[1], pos[2] - axisPoint[2], pos[3] - axisPoint[3] }

    -- Rotate objects
    pos = RotatePoint(pos, rotationMatrix)

    -- Translate objects back
    pos = { pos[1] + axisPoint[1], pos[2] + axisPoint[2], pos[3] + axisPoint[3] }

    return pos
end

-- Normalize angle to keep within [0, 360)
local function normalizeAngle(angle)
    return angle % 360
end

-- Create a rotation matrix for a given axis
local function createRotationMatrix(axis, angle)
    local cosA = math.cos(angle)
    local sinA = math.sin(angle)
    local oneMinusCosA = 1 - cosA

    return {
        { cosA + axis[1] ^ 2 * oneMinusCosA,
            axis[1] * axis[2] * oneMinusCosA - axis[3] * sinA,
            axis[1] * axis[3] * oneMinusCosA + axis[2] * sinA },
        { axis[2] * axis[1] * oneMinusCosA + axis[3] * sinA,
            cosA + axis[2] ^ 2 * oneMinusCosA,
            axis[2] * axis[3] * oneMinusCosA - axis[1] * sinA },
        { axis[3] * axis[1] * oneMinusCosA - axis[2] * sinA,
            axis[3] * axis[2] * oneMinusCosA + axis[1] * sinA,
            cosA + axis[3] ^ 2 * oneMinusCosA }
    }
end

-- Apply rotation matrix to a vector
local function applyRotation(matrix, vector)
    return {
        matrix[1][1] * vector[1] + matrix[1][2] * vector[2] + matrix[1][3] * vector[3],
        matrix[2][1] * vector[1] + matrix[2][2] * vector[2] + matrix[2][3] * vector[3],
        matrix[3][1] * vector[1] + matrix[3][2] * vector[2] + matrix[3][3] * vector[3]
    }
end
-- Calculate new rotation values using axis point and indexed inputs
function CalcRotation(rot_angle_offsets, obj_rot, axis_point)
    -- Define the rotation axes in order: X, Y, Z
    local axes = {
        { 1, 0, 0 }, -- X-axis
        { 0, 1, 0 }, -- Y-axis
        { 0, 0, 1 } -- Z-axis
    }

    -- Convert object's rotation to a vector relative to the axis point
    local obj_vector = {
        obj_rot[1] - axis_point[1],
        obj_rot[2] - axis_point[2],
        obj_rot[3] - axis_point[3]
    }

    -- Apply rotations for each axis
    for i, axis in ipairs(axes) do
        local rotationMatrix = createRotationMatrix(axis, rot_angle_offsets[i])
        obj_vector = applyRotation(rotationMatrix, obj_vector)
    end

    -- Convert the rotated vector back to the correct position relative to the axis point
    local newRot = {
        obj_vector[1] + axis_point[1],
        obj_vector[2] + axis_point[2],
        obj_vector[3] + axis_point[3]
    }

    -- Normalize final angles
    newRot[1] = normalizeAngle(newRot[1])
    newRot[2] = normalizeAngle(newRot[2])
    newRot[3] = normalizeAngle(newRot[3])

    return newRot
end

-- local rot_angle_offsets = {math.rad(120), math.rad(-90), math.rad(75)} -- Rotation offsets (X, Y, Z) in radians
-- local obj_rot = {math.rad(45), math.rad(30), math.rad(15)} -- Initial rotation as indexed values
-- local axis_point = {10, -5, 2} -- Pivot point as indexed values

-- local newRot = CalcRotation({0,0,0}, {0,math.rad(45),0}, {0,0,0})

-- print(math.deg(newRot[1]), math.deg(newRot[2]), math.deg(newRot[3])) -- Outputs the corrected rotation in degrees
