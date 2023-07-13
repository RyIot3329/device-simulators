local priority = 16

local fanstatus = 1
local occsensor = 1
local window = 0

local fancmd = 1
local humcmd = 0

local occ = 1
local heatena = 1
local coolena = 1

local spacetemp = 70
local spacehumidity = 50
local datemp = 50
local ratemp = 72
local co2 = 100

local coolingspt = 72
local heatingspt = 68
local humspt = 40
local co2spt = 200

local humout = 0
local oadamper = 0
local capacity = 0

function sleep(time)
    local duration = os.time() + time
    while os.time() < duration do end
end

function Run()
  -- FANSTATUS, OCCSENSOR, WINDOWCONTACT
  bacnet.createBinaryInputs(3)
  bacnet.setBinaryInputName(0, "FANSTATUS")
  bacnet.setBinaryInputName(1, "OCCSENSOR")
  bacnet.setBinaryInputName(2, "WINDOWCONTACT")
  -- FANCMD, HUMCMD
  bacnet.createBinaryOutputs(2)
  bacnet.setBinaryOutputName(0, "FANCMD")
  bacnet.setBinaryOutputName(1, "HUMCMD")
  -- OCCUPANCY, HEATINGENABLED, COOLINGENABLED
  bacnet.createBinaryValues(3)
  bacnet.setBinaryValueName(0, "OCCUPANCY")
  bacnet.setBinaryValueName(1, "HEATINGENABLED")
  bacnet.setBinaryValueName(2, "COOLINGENABLED")
  -- SPACETEMP, SPACEHUM, DATEMP, RATEMP, SPACECO2
  bacnet.createAnalogInputs(5)
  bacnet.setAnalogInputName(0, "SPACETEMP")
  bacnet.setAnalogInputName(1, "SPACEHUMIDITY")
  bacnet.setAnalogInputName(2, "DATEMP")
  bacnet.setAnalogInputName(3, "RATEMP")
  bacnet.setAnalogInputName(4, "SPACECO2")
  -- COOLINGSPT, HEATINGSPT, HUMSPT, CO2SPT
  bacnet.createAnalogValues(4)
  bacnet.setAnalogValueName(0, "COOLINGSPT")
  bacnet.setAnalogValueName(1, "HEATINGSPT")
  bacnet.setAnalogValueName(2, "HUMSPT")
  bacnet.setAnalogValueName(3, "CO2SPT")
  -- HUMOUT, OADAMPER, CAPACITY
  bacnet.createAnalogOutputs(3)
  bacnet.setAnalogOutputName(0, "HUMOUT")
  bacnet.setAnalogOutputName(1, "OADAMPER")
  bacnet.setAnalogOutputName(2, "CAPACITY")


  while isBacnetRunning() do
    fanstatus = math.random(0,1)
    occsensor = math.random(0,1)
    window = math.random(0,1)

    fancmd = math.random(0,1)
    humcmd = math.random(0,1)

    spacetemp = math.random(65,75)
    spacehumidity = math.random(30,60)
    datemp = math.random(50,60)
    ratemp = math.random(68,78)
    co2 = math.random(0,250)

    humout = math.random(0,100)
    oadamper = math.random(0,100)
    capacity = math.random(0,100)

    bacnet.setBinaryInputPresentValue(0,fanstatus)
    bacnet.setBinaryInputPresentValue(1,occsensor)
    bacnet.setBinaryInputPresentValue(2,window)

    bacnet.setBinaryOutputPresentValue(0,fancmd, priority)
    bacnet.setBinaryOutputPresentValue(1,humcmd, priority)

    bacnet.setAnalogInputPresentValue(0, spacetemp)
    bacnet.setAnalogInputPresentValue(1, spacehumidity)
    bacnet.setAnalogInputPresentValue(2, datemp)
    bacnet.setAnalogInputPresentValue(3, ratemp)
    bacnet.setAnalogInputPresentValue(4, co2)

    bacnet.setAnalogOutputPresentValue(0,humout, priority)
    bacnet.setAnalogOutputPresentValue(1,oadamper, priority)
    bacnet.setAnalogOutputPresentValue(2,capacity, priority)

    sleep(10)
  end
end

function Update()

end