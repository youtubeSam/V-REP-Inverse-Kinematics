function sysCall_init() 
    -- Parameters
--    beltSpeed = 0.1

    -- Initialize auxiliary variables
--    boxList = {}
--    boxDummyList = {}

    -- Get object and script handles
    forwarder=sim.getObjectHandle('customizableConveyor_forwarder')
--    textureShape=sim.getObjectHandle('customizableConveyor_tableTop')

--    proximity1 = sim.getObjectHandle("Proximity_sensor_belt2_1")
--    proximity2 = sim.getObjectHandle("Proximity_sensor_belt2_2")

--    belt1_script = sim.getScriptHandle("ConveyorBelt")
    
    -- Set belt2 speed
--    sim.setScriptSimulationParameter(sim.handle_self,"conveyorBeltVelocity",beltSpeed)
end

function sysCall_cleanup() 
 
end 

function sysCall_actuation() 
--- THIS IS NOT PART OF THE TUTORIAL. IT COMES ALREADY WITH THE CONVEYOR BELT!
--- DO NOT MODIFY THIS FUNCTION!
    beltVelocity=sim.getScriptSimulationParameter(sim.handle_self,"conveyorBeltVelocity")
    
    -- We move the texture attached to the conveyor belt to give the impression of movement:
    t=sim.getSimulationTime()
    sim.setObjectFloatParameter(textureShape,sim.shapefloatparam_texture_x,t*beltVelocity)
    
    -- Here we "fake" the transportation pads with a single static rectangle that we dynamically reset
    -- at each simulation pass (while not forgetting to set its initial velocity vector) :
    relativeLinearVelocity={beltVelocity,0,0}
    -- Reset the dynamic rectangle from the simulation (it will be removed and added again)
    sim.resetDynamicObject(forwarder)
    -- Compute the absolute velocity vector:
    m=sim.getObjectMatrix(forwarder,-1)
    m[4]=0 -- Make sure the translation component is discarded
    m[8]=0 -- Make sure the translation component is discarded
    m[12]=0 -- Make sure the translation component is discarded
    absoluteLinearVelocity=sim.multiplyVector(m,relativeLinearVelocity)
    -- Now set the initial velocity of the dynamic rectangle:
    sim.setObjectFloatParameter(forwarder,sim.shapefloatparam_init_velocity_x,absoluteLinearVelocity[1])
    sim.setObjectFloatParameter(forwarder,sim.shapefloatparam_init_velocity_y,absoluteLinearVelocity[2])
    sim.setObjectFloatParameter(forwarder,sim.shapefloatparam_init_velocity_z,absoluteLinearVelocity[3])
end 


function sysCall_sensing()
    -- Read proximity sensors (0 = no detection, 1 = detected object)
--    local prox1 = sim.readProximitySensor(proximity1)
--    local prox2 = sim.readProximitySensor(proximity2)

    -- Start belt if object detectet by prox1, stop belt if no objet at prox2
--    if prox1==1 then
--        sim.setScriptSimulationParameter(sim.handle_self,"conveyorBeltVelocity",beltSpeed)
--    else
--        sim.setScriptSimulationParameter(sim.handle_self,"conveyorBeltVelocity",0)
--    end
    
    -- Remove object if detected by prox2
--    if prox2 == 1 then
--        removeObject()
--    end
end

function addObject(obj)
    -- Insert box and boxDummy handle at the end of tables
--    table.insert(boxList,obj[1])
--    table.insert(boxDummyList,obj[2])
end

function removeObject()
    -- Remove first objects from tables, then remove objects from scene
--    sim.removeObject(table.remove(boxList,1))
--    sim.removeObject(table.remove(boxDummyList,1))
end
