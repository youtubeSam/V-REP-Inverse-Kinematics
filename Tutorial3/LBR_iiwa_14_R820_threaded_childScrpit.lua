-- Velocity and acceleration on path
nominalVel = 0.25
nominalAcc = 0.5

-- Get object and script handles
target = sim.getObjectHandle("Target")
connector = sim.getObjectHandle("Connector")
belt1_script = sim.getScriptHandle("ConveyorBelt")

-- Initialize variables
pickupDummy = -1
releasePath = -1

function sysCall_threadmain()
    while sim.getSimulationState()~=sim.simulation_advancing_abouttostop do
	-- Pause script until a signal is applied on integer signal "objectAvailable"
        sim.waitForSignal("objectAvailable")
	-- Obtain current pickupPath-handle
        path = sim.getObjectHandle("pickupPath")
	-- Follow the pickupPath
        sim.followPath(target,path,3,0,nominalVel,nominalAcc)
	-- Wait one second to mimic a connection process
        sim.wait(1)
	-- Connect the connector to pickupDummy
        sim.setLinkDummy(connector,pickupDummy)
	-- Follow back the pickup path
        sim.followPath(target,path,3,1,-nominalVel,-nominalAcc)
	-- Follow release path
        sim.followPath(target,releasePath,3,0,nominalVel,nominalAcc)
	-- Wait 0.25 seconds 
        sim.wait(0.25)
	-- Disconnect pickupDummy from connector
        sim.setLinkDummy(connector,-1)
	-- Follow back releasePath to "idle" position
        sim.followPath(target,releasePath,3,1,-nominalVel,-nominalAcc)
    end
end


