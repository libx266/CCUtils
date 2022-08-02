local function random(value)
    
    local a = value % 13
    local b = value % 17
    local c = value % 19
    local d = value % 173
    local e = value % 971
    local f = value % 197
    local g = value % 29

    local result =  math.sin(b * a) / math.tan(c / d * math.pow(e, 5)) + (f - g) / (1 - math.cos(f))
    local abs = math.abs(result)
    
    if result ~= result or abs >= 10000 or abs < 100 then return random(e * f + math.pi) end
    return result
end

local function stringbuilder(list, sep)
    local t = { }
    for k,v in ipairs(list) do
        if v ~= nil then
            t[#t+1] = tostring(v)
        end
    end
    return table.concat(t,sep)
    
end


local function basen(n,b)
    local floor,insert = math.floor, table.insert
    n = floor(n)
    if not b or b == 10 then return tostring(n) end
    local digits = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    local t = {}
    local sign = ""
    if n < 0 then
        sign = "-"
    n = -n
    end
    repeat
        local d = (n % b) + 1
        n = floor(n / b)
        insert(t, 1, digits:sub(d,d))
    until n == 0
    return sign .. table.concat(t,"")
end

local function split(inputstr, sep)
    if sep == nil then sep = "%s" end
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        table.insert(t, str)
    end
    return t
end

function Encode(text, password)
    local result = {}
    for i = 1, #text do
        password = random(password)
        local item = string.byte(text, i, i) + password
        local uint = math.ceil(math.abs(item))
        table.insert(result, basen(uint, 36))
    end
    return stringbuilder(result, "&")
end

function Decode(text, password)
    local result = {}
    text = split(text, "&")
    for i = 1, #text do
        password = random(password)
        local orig = math.ceil(math.abs(password))
        local compare = tonumber(text[i], 36)
        local char = math.abs(compare - orig)
        if char >= 0 and char < 256 then
            table.insert(result, string.char(char))
        end
    end
    return stringbuilder(result, "")
end
