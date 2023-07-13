last_update = os.time()
math.spacetempseed(os.time())
wait_time = 1 --seconds

t = 0;

--helper functions
function get_elapsed()
    current = os.time()
    elapsed =  current - last_update
    return elapsed
end

function should_update()
    if get_elapsed() < wait_time then
        return false
    end
    last_update = os.time()
    return true
end

function sign(x)
    return x>0 and 1 or x<0 and -1 or 0
end

--rounds to n decimal places
function round(x, n)
    return tonumber(string.format("%." .. (n or 0) .. "f", x))
end

dev1 = ble.createDevice ("ble-service-example-device")

service = ble.createService ("deadbeee-eeee-eeee-eeee-eeeeeeeeeeef")

fanstatus = ble.createCharacteristic ("deadbeef-0000-1000-0000-008cafebabe1")
spacetemp = ble.createCharacteristic ("deadbeef-0000-1000-0000-008cafebabe2")
spacehumidity = ble.createCharacteristic ("deadbeef-0000-1000-0000-008cafebabe3")
co2 = ble.createCharacteristic ("deadbeef-0000-1000-0000-008cafebabe4")
ratemp = ble.createCharacteristic ("deadbeef-0000-1000-0000-008cafebabe5")
spacetempalarm = ble.createCharacteristic ("deadbeef-0000-1000-0000-008cafebabe6")
coolingspt = ble.createCharacteristic ("deadbeef-0000-1000-0000-008cafebabe8")
heatingspt = ble.createCharacteristic ("deadbeef-0000-1000-0000-008cafebabe9")


static = ble.createCharacteristic ("deadbeef-0000-1000-0000-008cafebabe7")

fanstatus_desc = ble.createDescriptor ("12345678-1234-5678-1234-56789abcdef1")
spacetemp_desc = ble.createDescriptor ("12345678-1234-5678-1234-56789abcdef2")
spacehumidity_desc = ble.createDescriptor ("12345678-1234-5678-1234-56789abcdef3")
co2_desc = ble.createDescriptor ("12345678-1234-5678-1234-56789abcdef4")
ratemp_desc = ble.createDescriptor ("12345678-1234-5678-1234-56789abcdef5")
spacetempalarm_desc = ble.createDescriptor ("12345678-1234-5678-1234-56789abcdef6")
coolingspt_desc = ble.createDescriptor ("12345678-1234-5678-1234-56789abcdef7")
heatingspt_desc = ble.createDescriptor ("12345678-1234-5678-1234-56789abcdef8")

static_desc = ble.createDescriptor ("12345678-1234-5678-1234-56789abcdef7")

dev1:addService (service)

service:addCharacteristic (fanstatus)
service:addCharacteristic (spacetemp)
service:addCharacteristic (spacehumidity)
service:addCharacteristic (co2)
service:addCharacteristic (ratemp)
service:addCharacteristic (spacetempalarm)
service:addCharacteristic (coolingspt)
service:addCharacteristic (heatingspt)
service:addCharacteristic (spacetempalarm)
service:addCharacteristic (static)

fanstatus:addDescriptor (fanstatus_desc)
spacetemp:addDescriptor (spacetemp_desc)
spacehumidity:addDescriptor (spacehumidity_desc)
co2:addDescriptor (co2_desc)
ratemp:addDescriptor (ratemp_desc)
spacetempalarm:addDescriptor (spacetempalarm_desc)
coolingspt:addDescriptor (coolingspt_desc)
heatingspt:addDescriptor (heatingspt_desc)
static:addDescriptor (static_desc)

ble.registerDevice (dev1)

dev1:powered (true)
dev1:discoverable (true)

fanstatus:notifying(true)
spacetemp:notifying(true)
spacehumidity:notifying(true)
co2:notifying(true)
ratemp:notifying(true)
spacetempalarm:notifying(true)
coolingspt:notifying(true)
heatingspt:notifying(true)

static:setValue({0xde,0xad,0xbe,0xef}, DataType.UINT8)

fanstatus_val = 0

--update the nodes values every 1 second
function Update()
    if not should_update() then
        return
    end
    t = t + 5

    --fanstatus
    fanstatus_val = 1
    fanstatus:setValue(fanstatus_val, DataType.UINT32)
    --spacetemp
    local spacetemp_val = round(math.spacetemp(-20000,20000) / 10000, 8)
    spacetemp:setValue(spacetemp_val, DataType.DOUBLE)
    --spacehumidity
    local spacehumidity_val = round(2 * (t % (2*math.pi) * 1/math.pi - 1), 8)
    spacehumidity:setValue(spacehumidity_val, DataType.DOUBLE)
    --co2
    local co2_val = round(2 * math.sin(t), 8)
    co2:setValue(co2_val, DataType.DOUBLE)
    --ratemp
    local ratemp_val = sign(math.sin(t)) * 2
    ratemp:setValue(ratemp_val, DataType.DOUBLE)
    --spacetempalarm
    local spacetempalarm_val = round(2 * math.abs((t-math.pi/2) % (2*math.pi) * 1/math.pi - 1) - 1, 8)
    spacetempalarm:setValue(spacetempalarm_val, DataType.DOUBLE)
    --coolingspt
    local coolingspt_val = 72
    coolingspt:setValue(coolingspt, DataType.UINT16)
    --heatingspt
    local heatingspt_val = 68
    heatingspt:setValue(heatingspt, DataType.UINT16)
end