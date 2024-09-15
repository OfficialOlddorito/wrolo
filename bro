-- This script shows every single text that uses luac, lua, luau, json and much more to work on server-sided base and keep in note this whole coregui, playergui and more to create a whole experience and this whole script is the only thing that makes clients
-- <roblox!> <olddorito!> <werrrolo!>

function sandbox(var,func)
	local env = getfenv(func)
	local newenv = setmetatable({},{
		__index = function(self,k)
			if k=="script" then
				return var
			else
				return env[k]
			end
		end,
	})
	setfenv(func,newenv)
	return func
end
cors = {}
mas = Instance.new("Model",game:GetService("Lighting"))
Model0 = Instance.new("Model")
LocalScript1 = Instance.new("LocalScript")
LocalScript2 = Instance.new("LocalScript")
ModuleScript3 = Instance.new("ModuleScript")
ModuleScript4 = Instance.new("ModuleScript")
ModuleScript5 = Instance.new("ModuleScript")
ModuleScript6 = Instance.new("ModuleScript")
ModuleScript7 = Instance.new("ModuleScript")
ModuleScript8 = Instance.new("ModuleScript")
ModuleScript9 = Instance.new("ModuleScript")
ModuleScript10 = Instance.new("ModuleScript")
ModuleScript11 = Instance.new("ModuleScript")
ModuleScript12 = Instance.new("ModuleScript")
ModuleScript13 = Instance.new("ModuleScript")
ModuleScript14 = Instance.new("ModuleScript")
ModuleScript15 = Instance.new("ModuleScript")
ModuleScript16 = Instance.new("ModuleScript")
ModuleScript17 = Instance.new("ModuleScript")
ModuleScript18 = Instance.new("ModuleScript")
ModuleScript19 = Instance.new("ModuleScript")
ModuleScript20 = Instance.new("ModuleScript")
ModuleScript21 = Instance.new("ModuleScript")
ModuleScript22 = Instance.new("ModuleScript")
ModuleScript23 = Instance.new("ModuleScript")
ModuleScript24 = Instance.new("ModuleScript")
ModuleScript25 = Instance.new("ModuleScript")
ModuleScript26 = Instance.new("ModuleScript")
StringValue27 = Instance.new("StringValue")
ModuleScript28 = Instance.new("ModuleScript")
ModuleScript29 = Instance.new("ModuleScript")
ModuleScript30 = Instance.new("ModuleScript")
ModuleScript31 = Instance.new("ModuleScript")
ModuleScript32 = Instance.new("ModuleScript")
ModuleScript33 = Instance.new("ModuleScript")
ModuleScript34 = Instance.new("ModuleScript")
ModuleScript35 = Instance.new("ModuleScript")
ModuleScript36 = Instance.new("ModuleScript")
ModuleScript37 = Instance.new("ModuleScript")
ModuleScript38 = Instance.new("ModuleScript")
ModuleScript39 = Instance.new("ModuleScript")
Model0.Name = "bypazz"
Model0.Parent = mas
LocalScript1.Name = "PlayerScriptsLoader"
LocalScript1.Parent = Model0
table.insert(cors,sandbox(LocalScript1,function()
--[[
	PlayerScriptsLoader - This script requires and instantiates the PlayerModule singleton

	2018 PlayerScripts Update - AllYourBlox
--]]

require(script.Parent:WaitForChild("PlayerModule"))

end))
LocalScript2.Name = "RbxCharacterSounds"
LocalScript2.Parent = LocalScript1
table.insert(cors,sandbox(LocalScript2,function()
--!nonstrict
-- Roblox character sound script

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local AtomicBinding = require(script:WaitForChild("AtomicBinding"))

local function loadFlag(flag: string)
	local success, result = pcall(function()
		return UserSettings():IsUserFeatureEnabled(flag)
	end)
	return success and result
end

local SOUND_DATA : { [string]: {[string]: any}} = {
	Climbing = {
		SoundId = "rbxasset://sounds/action_footsteps_plastic.mp3",
		Looped = true,
	},
	Died = {
		SoundId = "rbxasset://sounds/uuhhh.mp3",
	},
	FreeFalling = {
		SoundId = "rbxasset://sounds/action_falling.mp3",
		Looped = true,
	},
	GettingUp = {
		SoundId = "rbxasset://sounds/action_get_up.mp3",
	},
	Jumping = {
		SoundId = "rbxasset://sounds/action_jump.mp3",
	},
	Landing = {
		SoundId = "rbxasset://sounds/action_jump_land.mp3",
	},
	Running = {
		SoundId = "rbxasset://sounds/action_footsteps_plastic.mp3",
		Looped = true,
		Pitch = 1.85,
	},
	Splash = {
		SoundId = "rbxasset://sounds/impact_water.mp3",
	},
	Swimming = {
		SoundId = "rbxasset://sounds/action_swim.mp3",
		Looped = true,
		Pitch = 1.6,
	},
}

-- map a value from one range to another
local function map(x: number, inMin: number, inMax: number, outMin: number, outMax: number): number
	return (x - inMin)*(outMax - outMin)/(inMax - inMin) + outMin
end

local function playSound(sound: Sound)
	sound.TimePosition = 0
	sound.Playing = true
end

local function shallowCopy(t)
	local out = {}
	for k, v in pairs(t) do
		out[k] = v
	end
	return out
end

local function initializeSoundSystem(instances)
	local player = instances.player
	local humanoid = instances.humanoid
	local rootPart = instances.rootPart

	local sounds: {[string]: Sound} = {}

	-- initialize sounds
	for name: string, props: {[string]: any} in pairs(SOUND_DATA) do
		local sound: Sound = Instance.new("Sound")
		sound.Name = name

		-- set default values
		sound.Archivable = false
		sound.RollOffMinDistance = 5
		sound.RollOffMaxDistance = 150
		sound.Volume = 0.65

		for propName, propValue: any in pairs(props) do
			(sound :: any)[propName] = propValue
		end

		sound.Parent = rootPart
		sounds[name] = sound
	end

	local playingLoopedSounds: {[Sound]: boolean?} = {}

	local function stopPlayingLoopedSounds(except: Sound?)
		for sound in pairs(shallowCopy(playingLoopedSounds)) do
			if sound ~= except then
				sound.Playing = false
				playingLoopedSounds[sound] = nil
			end
		end
	end

	-- state transition callbacks.
	local stateTransitions: {[Enum.HumanoidStateType]: () -> ()} = {
		[Enum.HumanoidStateType.FallingDown] = function()
			stopPlayingLoopedSounds()
		end,

		[Enum.HumanoidStateType.GettingUp] = function()
			stopPlayingLoopedSounds()
			playSound(sounds.GettingUp)
		end,

		[Enum.HumanoidStateType.Jumping] = function()
			stopPlayingLoopedSounds()
			playSound(sounds.Jumping)
		end,

		[Enum.HumanoidStateType.Swimming] = function()
			local verticalSpeed = math.abs(rootPart.AssemblyLinearVelocity.Y)
			if verticalSpeed > 0.1 then
				sounds.Splash.Volume = math.clamp(map(verticalSpeed, 100, 350, 0.28, 1), 0, 1)
				playSound(sounds.Splash)
			end
			stopPlayingLoopedSounds(sounds.Swimming)
			sounds.Swimming.Playing = true
			playingLoopedSounds[sounds.Swimming] = true
		end,

		[Enum.HumanoidStateType.Freefall] = function()
			sounds.FreeFalling.Volume = 0
			stopPlayingLoopedSounds(sounds.FreeFalling)
			playingLoopedSounds[sounds.FreeFalling] = true
		end,

		[Enum.HumanoidStateType.Landed] = function()
			stopPlayingLoopedSounds()
			local verticalSpeed = math.abs(rootPart.AssemblyLinearVelocity.Y)
			if verticalSpeed > 75 then
				sounds.Landing.Volume = math.clamp(map(verticalSpeed, 50, 100, 0, 1), 0, 1)
				playSound(sounds.Landing)
			end
		end,

		[Enum.HumanoidStateType.Running] = function()
			stopPlayingLoopedSounds(sounds.Running)
			sounds.Running.Playing = true
			playingLoopedSounds[sounds.Running] = true
		end,

		[Enum.HumanoidStateType.Climbing] = function()
			local sound = sounds.Climbing
			if math.abs(rootPart.AssemblyLinearVelocity.Y) > 0.1 then
				sound.Playing = true
				stopPlayingLoopedSounds(sound)
			else
				stopPlayingLoopedSounds()
			end
			playingLoopedSounds[sound] = true
		end,

		[Enum.HumanoidStateType.Seated] = function()
			stopPlayingLoopedSounds()
		end,

		[Enum.HumanoidStateType.Dead] = function()
			stopPlayingLoopedSounds()
			playSound(sounds.Died)
		end,
	}

	-- updaters for looped sounds
	local loopedSoundUpdaters: {[Sound]: (number, Sound, Vector3) -> ()} = {
		[sounds.Climbing] = function(dt: number, sound: Sound, vel: Vector3)
			sound.Playing = vel.Magnitude > 0.1
		end,

		[sounds.FreeFalling] = function(dt: number, sound: Sound, vel: Vector3): ()
			if vel.Magnitude > 75 then
				sound.Volume = math.clamp(sound.Volume + 0.9*dt, 0, 1)
			else
				sound.Volume = 0
			end
		end,

		[sounds.Running] = function(dt: number, sound: Sound, vel: Vector3)
			sound.Playing = vel.Magnitude > 0.5 and humanoid.MoveDirection.Magnitude > 0.5
		end,
	}

	-- state substitutions to avoid duplicating entries in the state table
	local stateRemap: {[Enum.HumanoidStateType]: Enum.HumanoidStateType} = {
		[Enum.HumanoidStateType.RunningNoPhysics] = Enum.HumanoidStateType.Running,
	}

	local activeState: Enum.HumanoidStateType = stateRemap[humanoid:GetState()] or humanoid:GetState()

	local function transitionTo(state)
		local transitionFunc: () -> () = stateTransitions[state]

		if transitionFunc then
			transitionFunc()
		end

		activeState = state
	end

	transitionTo(activeState)

	local stateChangedConn = humanoid.StateChanged:Connect(function(_, state)
		state = stateRemap[state] or state

		if state ~= activeState then
			transitionTo(state)
		end
	end)

	local steppedConn = RunService.Stepped:Connect(function(_, worldDt: number)
		-- update looped sounds on stepped
		for sound in pairs(playingLoopedSounds) do
			local updater: (number, Sound, Vector3) -> () = loopedSoundUpdaters[sound]

			if updater then
				updater(worldDt, sound, rootPart.AssemblyLinearVelocity)
			end
		end
	end)

	local function terminate()
		stateChangedConn:Disconnect()
		steppedConn:Disconnect()

		-- Unparent all sounds and empty sounds table
		-- This is needed in order to support the case where initializeSoundSystem might be called more than once for the same player,
		-- which might happen in case player character is unparented and parented back on server and reset-children mechanism is active.
		for name: string, sound: Sound in pairs(sounds) do
			sound:Destroy()
		end
		table.clear(sounds)
	end

	return terminate
end

local binding = AtomicBinding.new({
	humanoid = "Humanoid",
	rootPart = "HumanoidRootPart",
}, initializeSoundSystem)

local playerConnections = {}

local function characterAdded(character)
	binding:bindRoot(character)
end

local function characterRemoving(character)
	binding:unbindRoot(character)
end

local function playerAdded(player: Player)
	local connections = playerConnections[player]
	if not connections then
		connections = {}
		playerConnections[player] = connections
	end

	if player.Character then
		characterAdded(player.Character)
	end
	table.insert(connections, player.CharacterAdded:Connect(characterAdded))
	table.insert(connections, player.CharacterRemoving:Connect(characterRemoving))
end

local function playerRemoving(player: Player)
	local connections = playerConnections[player]
	if connections then
		for _, conn in ipairs(connections) do
			conn:Disconnect()
		end
		playerConnections[player] = nil
	end

	if player.Character then
		characterRemoving(player.Character)
	end
end

for _, player in ipairs(Players:GetPlayers()) do
	task.spawn(playerAdded, player)
end
Players.PlayerAdded:Connect(playerAdded)
Players.PlayerRemoving:Connect(playerRemoving)

end))
ModuleScript3.Name = "AtomicBinding"
ModuleScript3.Parent = LocalScript2
table.insert(cors,sandbox(ModuleScript3,function()
--!nonstrict
local ROOT_ALIAS = "root"

local function parsePath(pathStr)
	local pathArray = string.split(pathStr, "/")
	for idx = #pathArray, 1, -1 do
		if pathArray[idx] == "" then
			table.remove(pathArray, idx)
		end
	end
	return pathArray
end

local function isManifestResolved(resolvedManifest, manifestSizeTarget)
	local manifestSize = 0
	for _ in pairs(resolvedManifest) do
		manifestSize += 1
	end

	assert(manifestSize <= manifestSizeTarget, manifestSize)
	return manifestSize == manifestSizeTarget
end

local function unbindNodeDescend(node, resolvedManifest)
	if node.instance == nil then
		return -- Do not try to unbind nodes that are already unbound
	end

	node.instance = nil

	local connections = node.connections
	if connections then
		for _, conn in ipairs(connections) do
			conn:Disconnect()
		end
		table.clear(connections)
	end

	if resolvedManifest and node.alias then
		resolvedManifest[node.alias] = nil
	end

	local children = node.children
	if children then
		for _, childNode in pairs(children) do
			unbindNodeDescend(childNode, resolvedManifest)
		end
	end
end

local AtomicBinding = {}
AtomicBinding.__index = AtomicBinding

function AtomicBinding.new(manifest, boundFn)
	local dtorMap = {} -- { [root] -> dtor }
	local connections = {} -- { Connection, ... }
	local rootInstToRootNode = {} -- { [root] -> rootNode }
	local rootInstToManifest = {} -- { [root] -> { [alias] -> instance } }

	local parsedManifest = {} -- { [alias] = {Name, ...} }
	local manifestSizeTarget = 1 -- Add 1 because root isn't explicitly on the manifest	
	
	for alias, rawPath in pairs(manifest) do
		parsedManifest[alias] = parsePath(rawPath)
		manifestSizeTarget += 1
	end

	return setmetatable({
		_boundFn = boundFn,
		_parsedManifest = parsedManifest,
		_manifestSizeTarget = manifestSizeTarget,
		
		_dtorMap = dtorMap,
		_connections = connections,
		_rootInstToRootNode = rootInstToRootNode,
		_rootInstToManifest = rootInstToManifest,
	}, AtomicBinding)
end

function AtomicBinding:_startBoundFn(root, resolvedManifest)
	local boundFn = self._boundFn
	local dtorMap = self._dtorMap
	
	local oldDtor = dtorMap[root]
	if oldDtor then
		oldDtor()
		dtorMap[root] = nil
	end

	local dtor = boundFn(resolvedManifest)
	if dtor then
		dtorMap[root] = dtor
	end
end

function AtomicBinding:_stopBoundFn(root)
	local dtorMap = self._dtorMap
	
	local dtor = dtorMap[root]
	if dtor then
		dtor()
		dtorMap[root] = nil
	end
end

function AtomicBinding:bindRoot(root)
	debug.profilebegin("AtomicBinding:BindRoot")
	
	local parsedManifest = self._parsedManifest
	local rootInstToRootNode = self._rootInstToRootNode
	local rootInstToManifest = self._rootInstToManifest
	local manifestSizeTarget = self._manifestSizeTarget
	
	assert(rootInstToManifest[root] == nil)

	local resolvedManifest = {}
	rootInstToManifest[root] = resolvedManifest

	debug.profilebegin("BuildTree")

	local rootNode = {}
	rootNode.alias = ROOT_ALIAS
	rootNode.instance = root
	if next(parsedManifest) then
		-- No need to assign child data if there are no children
		rootNode.children = {}
		rootNode.connections = {}
	end

	rootInstToRootNode[root] = rootNode

	for alias, parsedPath in pairs(parsedManifest) do
		local parentNode = rootNode

		for idx, childName in ipairs(parsedPath) do
			local leaf = idx == #parsedPath
			local childNode = parentNode.children[childName] or {}

			if leaf then
				if childNode.alias ~= nil then
					error("Multiple aliases assigned to one instance")
				end

				childNode.alias = alias

			else
				childNode.children = childNode.children or {}
				childNode.connections = childNode.connections or {}
			end

			parentNode.children[childName] = childNode
			parentNode = childNode
		end
	end

	debug.profileend() -- BuildTree

	-- Recursively descend into the tree, resolving each node.
	-- Nodes start out as empty and instance-less; the resolving process discovers instances to map to nodes.
	local function processNode(node)
		local instance = assert(node.instance)

		local children = node.children
		local alias = node.alias
		local isLeaf = not children

		if alias then
			resolvedManifest[alias] = instance
		end

		if not isLeaf then
			local function processAddChild(childInstance)
				local childName = childInstance.Name
				local childNode = children[childName]
				if not childNode or childNode.instance ~= nil then
					return
				end

				childNode.instance = childInstance
				processNode(childNode)
			end

			local function processDeleteChild(childInstance)
				-- Instance deletion - Parent A detects that child B is being removed
				--    1. A removes B from `children`
				--    2. A traverses down from B,
				--       i.  Disconnecting inputs
				--       ii. Removing nodes from the resolved manifest
				--    3. stopBoundFn is called because we know the tree is no longer complete, or at least has to be refreshed
				-- 	  4. We search A for a replacement for B, and attempt to re-resolve using that replacement if it exists.
				-- To support the above sanely, processAddChild needs to avoid resolving nodes that are already resolved.

				local childName = childInstance.Name
				local childNode = children[childName]

				if not childNode then
					return -- There's no child node corresponding to the deleted instance, ignore
				end

				if childNode.instance ~= childInstance then
					return -- A child was removed with the same name as a node instance, ignore
				end

				self:_stopBoundFn(root) -- Happens before the tree is unbound so the manifest is still valid in the destructor.
				unbindNodeDescend(childNode, resolvedManifest) -- Unbind the tree

				assert(childNode.instance == nil) -- If this triggers, unbindNodeDescend failed

				-- Search for a replacement
				local replacementChild = instance:FindFirstChild(childName)
				if replacementChild then
					processAddChild(replacementChild)
				end
			end

			for _, child in ipairs(instance:GetChildren()) do
				processAddChild(child)
			end

			table.insert(node.connections, instance.ChildAdded:Connect(processAddChild))
			table.insert(node.connections, instance.ChildRemoved:Connect(processDeleteChild))
		end

		if isLeaf and isManifestResolved(resolvedManifest, manifestSizeTarget) then
			self:_startBoundFn(root, resolvedManifest)
		end
	end

	debug.profilebegin("ResolveTree")
	processNode(rootNode)
	debug.profileend() -- ResolveTree
	
	debug.profileend() -- AtomicBinding:BindRoot
end

function AtomicBinding:unbindRoot(root)
	local rootInstToRootNode = self._rootInstToRootNode
	local rootInstToManifest = self._rootInstToManifest
	
	self:_stopBoundFn(root)

	local rootNode = rootInstToRootNode[root]
	if rootNode then
		local resolvedManifest = assert(rootInstToManifest[root])
		unbindNodeDescend(rootNode, resolvedManifest)
		rootInstToRootNode[root] = nil
	end

	rootInstToManifest[root] = nil
end

function AtomicBinding:destroy()
	debug.profilebegin("AtomicBinding:destroy")

	for _, dtor in pairs(self._dtorMap) do
		dtor:destroy()
	end
	table.clear(self._dtorMap)

	for _, conn in ipairs(self._connections) do
		conn:Disconnect()
	end
	table.clear(self._connections)

	local rootInstToManifest = self._rootInstToManifest
	for rootInst, rootNode in pairs(self._rootInstToRootNode) do
		local resolvedManifest = assert(rootInstToManifest[rootInst])
		unbindNodeDescend(rootNode, resolvedManifest)
	end
	table.clear(self._rootInstToManifest)
	table.clear(self._rootInstToRootNode)

	debug.profileend()
end

return AtomicBinding

end))
ModuleScript4.Name = "PlayerModule"
ModuleScript4.Parent = LocalScript1
table.insert(cors,sandbox(ModuleScript4,function()
--[[
	PlayerModule - This module requires and instantiates the camera and control modules,
	and provides getters for developers to access methods on these singletons without
	having to modify Roblox-supplied scripts.

	2018 PlayerScripts Update - AllYourBlox
--]]

local PlayerModule = {}
PlayerModule.__index = PlayerModule

function PlayerModule.new()
	local self = setmetatable({},PlayerModule)
	self.cameras = require(script:WaitForChild("CameraModule"))
	self.controls = require(script:WaitForChild("ControlModule"))
	return self
end

function PlayerModule:GetCameras()
	return self.cameras
end

function PlayerModule:GetControls()
	return self.controls
end

function PlayerModule:GetClickToMoveController()
	return self.controls:GetClickToMoveController()
end

return PlayerModule.new()

end))
ModuleScript5.Name = "CameraModule"
ModuleScript5.Parent = ModuleScript4
table.insert(cors,sandbox(ModuleScript5,function()
--!nonstrict
--[[
	CameraModule - This ModuleScript implements a singleton class to manage the
	selection, activation, and deactivation of the current camera controller,
	character occlusion controller, and transparency controller. This script binds to
	RenderStepped at Camera priority and calls the Update() methods on the active
	controller instances.

	The camera controller ModuleScripts implement classes which are instantiated and
	activated as-needed, they are no longer all instantiated up front as they were in
	the previous generation of PlayerScripts.

	2018 PlayerScripts Update - AllYourBlox
--]]

local CameraModule = {}
CameraModule.__index = CameraModule

-- NOTICE: Player property names do not all match their StarterPlayer equivalents,
-- with the differences noted in the comments on the right
local PLAYER_CAMERA_PROPERTIES =
{
	"CameraMinZoomDistance",
	"CameraMaxZoomDistance",
	"CameraMode",
	"DevCameraOcclusionMode",
	"DevComputerCameraMode",			-- Corresponds to StarterPlayer.DevComputerCameraMovementMode
	"DevTouchCameraMode",				-- Corresponds to StarterPlayer.DevTouchCameraMovementMode

	-- Character movement mode
	"DevComputerMovementMode",
	"DevTouchMovementMode",
	"DevEnableMouseLock",				-- Corresponds to StarterPlayer.EnableMouseLockOption
}

local USER_GAME_SETTINGS_PROPERTIES =
{
	"ComputerCameraMovementMode",
	"ComputerMovementMode",
	"ControlMode",
	"GamepadCameraSensitivity",
	"MouseSensitivity",
	"RotationType",
	"TouchCameraMovementMode",
	"TouchMovementMode",
}

--[[ Roblox Services ]]--
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local VRService = game:GetService("VRService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")

-- Static camera utils
local CameraUtils = require(script:WaitForChild("CameraUtils"))
local CameraInput = require(script:WaitForChild("CameraInput"))

-- Load Roblox Camera Controller Modules
local ClassicCamera = require(script:WaitForChild("ClassicCamera"))
local OrbitalCamera = require(script:WaitForChild("OrbitalCamera"))
local LegacyCamera = require(script:WaitForChild("LegacyCamera"))
local VehicleCamera = require(script:WaitForChild("VehicleCamera"))
-- New VR System Modules
local VRCamera = require(script:WaitForChild("VRCamera"))
local VRVehicleCamera = require(script:WaitForChild("VRVehicleCamera"))

-- Load Roblox Occlusion Modules
local Invisicam = require(script:WaitForChild("Invisicam"))
local Poppercam = require(script:WaitForChild("Poppercam"))

-- Load the near-field character transparency controller and the mouse lock "shift lock" controller
local TransparencyController = require(script:WaitForChild("TransparencyController"))
local MouseLockController = require(script:WaitForChild("MouseLockController"))

-- Table of camera controllers that have been instantiated. They are instantiated as they are used.
local instantiatedCameraControllers = {}
local instantiatedOcclusionModules = {}

-- Management of which options appear on the Roblox User Settings screen
do
	local PlayerScripts = Players.LocalPlayer:WaitForChild("PlayerScripts")

	PlayerScripts:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Default)
	PlayerScripts:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Follow)
	PlayerScripts:RegisterTouchCameraMovementMode(Enum.TouchCameraMovementMode.Classic)

	PlayerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Default)
	PlayerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Follow)
	PlayerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.Classic)
	PlayerScripts:RegisterComputerCameraMovementMode(Enum.ComputerCameraMovementMode.CameraToggle)
end


function CameraModule.new()
	local self = setmetatable({},CameraModule)

	-- Current active controller instances
	self.activeCameraController = nil
	self.activeOcclusionModule = nil
	self.activeTransparencyController = nil
	self.activeMouseLockController = nil

	self.currentComputerCameraMovementMode = nil

	-- Connections to events
	self.cameraSubjectChangedConn = nil
	self.cameraTypeChangedConn = nil

	-- Adds CharacterAdded and CharacterRemoving event handlers for all current players
	for _,player in pairs(Players:GetPlayers()) do
		self:OnPlayerAdded(player)
	end

	-- Adds CharacterAdded and CharacterRemoving event handlers for all players who join in the future
	Players.PlayerAdded:Connect(function(player)
		self:OnPlayerAdded(player)
	end)

	self.activeTransparencyController = TransparencyController.new()
	self.activeTransparencyController:Enable(true)

	if not UserInputService.TouchEnabled then
		self.activeMouseLockController = MouseLockController.new()
		local toggleEvent = self.activeMouseLockController:GetBindableToggleEvent()
		if toggleEvent then
			toggleEvent:Connect(function()
				self:OnMouseLockToggled()
			end)
		end
	end

	self:ActivateCameraController(self:GetCameraControlChoice())
	self:ActivateOcclusionModule(Players.LocalPlayer.DevCameraOcclusionMode)
	self:OnCurrentCameraChanged() -- Does initializations and makes first camera controller
	RunService:BindToRenderStep("cameraRenderUpdate", Enum.RenderPriority.Camera.Value, function(dt) self:Update(dt) end)

	-- Connect listeners to camera-related properties
	for _, propertyName in pairs(PLAYER_CAMERA_PROPERTIES) do
		Players.LocalPlayer:GetPropertyChangedSignal(propertyName):Connect(function()
			self:OnLocalPlayerCameraPropertyChanged(propertyName)
		end)
	end

	for _, propertyName in pairs(USER_GAME_SETTINGS_PROPERTIES) do
		UserGameSettings:GetPropertyChangedSignal(propertyName):Connect(function()
			self:OnUserGameSettingsPropertyChanged(propertyName)
		end)
	end
	game.Workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
		self:OnCurrentCameraChanged()
	end)

	return self
end

function CameraModule:GetCameraMovementModeFromSettings()
	local cameraMode = Players.LocalPlayer.CameraMode

	-- Lock First Person trumps all other settings and forces ClassicCamera
	if cameraMode == Enum.CameraMode.LockFirstPerson then
		return CameraUtils.ConvertCameraModeEnumToStandard(Enum.ComputerCameraMovementMode.Classic)
	end

	local devMode, userMode
	if UserInputService.TouchEnabled then
		devMode = CameraUtils.ConvertCameraModeEnumToStandard(Players.LocalPlayer.DevTouchCameraMode)
		userMode = CameraUtils.ConvertCameraModeEnumToStandard(UserGameSettings.TouchCameraMovementMode)
	else
		devMode = CameraUtils.ConvertCameraModeEnumToStandard(Players.LocalPlayer.DevComputerCameraMode)
		userMode = CameraUtils.ConvertCameraModeEnumToStandard(UserGameSettings.ComputerCameraMovementMode)
	end

	if devMode == Enum.DevComputerCameraMovementMode.UserChoice then
		-- Developer is allowing user choice, so user setting is respected
		return userMode
	end

	return devMode
end

function CameraModule:ActivateOcclusionModule(occlusionMode: Enum.DevCameraOcclusionMode)
	local newModuleCreator
	if occlusionMode == Enum.DevCameraOcclusionMode.Zoom then
		newModuleCreator = Poppercam
	elseif occlusionMode == Enum.DevCameraOcclusionMode.Invisicam then
		newModuleCreator = Invisicam
	else
		warn("CameraScript ActivateOcclusionModule called with unsupported mode")
		return
	end

	self.occlusionMode = occlusionMode

	-- First check to see if there is actually a change. If the module being requested is already
	-- the currently-active solution then just make sure it's enabled and exit early
	if self.activeOcclusionModule and self.activeOcclusionModule:GetOcclusionMode() == occlusionMode then
		if not self.activeOcclusionModule:GetEnabled() then
			self.activeOcclusionModule:Enable(true)
		end
		return
	end

	-- Save a reference to the current active module (may be nil) so that we can disable it if
	-- we are successful in activating its replacement
	local prevOcclusionModule = self.activeOcclusionModule

	-- If there is no active module, see if the one we need has already been instantiated
	self.activeOcclusionModule = instantiatedOcclusionModules[newModuleCreator]

	-- If the module was not already instantiated and selected above, instantiate it
	if not self.activeOcclusionModule then
		self.activeOcclusionModule = newModuleCreator.new()
		if self.activeOcclusionModule then
			instantiatedOcclusionModules[newModuleCreator] = self.activeOcclusionModule
		end
	end

	-- If we were successful in either selecting or instantiating the module,
	-- enable it if it's not already the currently-active enabled module
	if self.activeOcclusionModule then
		local newModuleOcclusionMode = self.activeOcclusionModule:GetOcclusionMode()
		-- Sanity check that the module we selected or instantiated actually supports the desired occlusionMode
		if newModuleOcclusionMode ~= occlusionMode then
			warn("CameraScript ActivateOcclusionModule mismatch: ",self.activeOcclusionModule:GetOcclusionMode(),"~=",occlusionMode)
		end

		-- Deactivate current module if there is one
		if prevOcclusionModule then
			-- Sanity check that current module is not being replaced by itself (that should have been handled above)
			if prevOcclusionModule ~= self.activeOcclusionModule then
				prevOcclusionModule:Enable(false)
			else
				warn("CameraScript ActivateOcclusionModule failure to detect already running correct module")
			end
		end

		-- Occlusion modules need to be initialized with information about characters and cameraSubject
		-- Invisicam needs the LocalPlayer's character
		-- Poppercam needs all player characters and the camera subject
		if occlusionMode == Enum.DevCameraOcclusionMode.Invisicam then
			-- Optimization to only send Invisicam what we know it needs
			if Players.LocalPlayer.Character then
				self.activeOcclusionModule:CharacterAdded(Players.LocalPlayer.Character, Players.LocalPlayer )
			end
		else
			-- When Poppercam is enabled, we send it all existing player characters for its raycast ignore list
			for _, player in pairs(Players:GetPlayers()) do
				if player and player.Character then
					self.activeOcclusionModule:CharacterAdded(player.Character, player)
				end
			end
			self.activeOcclusionModule:OnCameraSubjectChanged((game.Workspace.CurrentCamera :: Camera).CameraSubject)
		end

		-- Activate new choice
		self.activeOcclusionModule:Enable(true)
	end
end

function CameraModule:ShouldUseVehicleCamera()
	local camera = workspace.CurrentCamera
	if not camera then
		return false
	end

	local cameraType = camera.CameraType
	local cameraSubject = camera.CameraSubject

	local isEligibleType = cameraType == Enum.CameraType.Custom or cameraType == Enum.CameraType.Follow
	local isEligibleSubject = cameraSubject and cameraSubject:IsA("VehicleSeat") or false
	local isEligibleOcclusionMode = self.occlusionMode ~= Enum.DevCameraOcclusionMode.Invisicam

	return isEligibleSubject and isEligibleType and isEligibleOcclusionMode
end

-- When supplied, legacyCameraType is used and cameraMovementMode is ignored (should be nil anyways)
-- Next, if userCameraCreator is passed in, that is used as the cameraCreator
function CameraModule:ActivateCameraController(cameraMovementMode, legacyCameraType: Enum.CameraType?)
	local newCameraCreator = nil

	if legacyCameraType~=nil then
		--[[
			This function has been passed a CameraType enum value. Some of these map to the use of
			the LegacyCamera module, the value "Custom" will be translated to a movementMode enum
			value based on Dev and User settings, and "Scriptable" will disable the camera controller.
		--]]

		if legacyCameraType == Enum.CameraType.Scriptable then
			if self.activeCameraController then
				self.activeCameraController:Enable(false)
				self.activeCameraController = nil
			end
			return

		elseif legacyCameraType == Enum.CameraType.Custom then
			cameraMovementMode = self:GetCameraMovementModeFromSettings()

		elseif legacyCameraType == Enum.CameraType.Track then
			-- Note: The TrackCamera module was basically an older, less fully-featured
			-- version of ClassicCamera, no longer actively maintained, but it is re-implemented in
			-- case a game was dependent on its lack of ClassicCamera's extra functionality.
			cameraMovementMode = Enum.ComputerCameraMovementMode.Classic

		elseif legacyCameraType == Enum.CameraType.Follow then
			cameraMovementMode = Enum.ComputerCameraMovementMode.Follow

		elseif legacyCameraType == Enum.CameraType.Orbital then
			cameraMovementMode = Enum.ComputerCameraMovementMode.Orbital

		elseif legacyCameraType == Enum.CameraType.Attach or
			   legacyCameraType == Enum.CameraType.Watch or
			   legacyCameraType == Enum.CameraType.Fixed then
			newCameraCreator = LegacyCamera
		else
			warn("CameraScript encountered an unhandled Camera.CameraType value: ",legacyCameraType)
		end
	end

	if not newCameraCreator then
		if VRService.VREnabled then
			newCameraCreator = VRCamera
		elseif cameraMovementMode == Enum.ComputerCameraMovementMode.Classic or
			cameraMovementMode == Enum.ComputerCameraMovementMode.Follow or
			cameraMovementMode == Enum.ComputerCameraMovementMode.Default or
			cameraMovementMode == Enum.ComputerCameraMovementMode.CameraToggle then
			newCameraCreator = ClassicCamera
		elseif cameraMovementMode == Enum.ComputerCameraMovementMode.Orbital then
			newCameraCreator = OrbitalCamera
		else
			warn("ActivateCameraController did not select a module.")
			return
		end
	end

	local isVehicleCamera = self:ShouldUseVehicleCamera()
	if isVehicleCamera then
		if VRService.VREnabled then
			newCameraCreator = VRVehicleCamera
		else
			newCameraCreator = VehicleCamera
		end
	end

	-- Create the camera control module we need if it does not already exist in instantiatedCameraControllers
	local newCameraController
	if not instantiatedCameraControllers[newCameraCreator] then
		newCameraController = newCameraCreator.new()
		instantiatedCameraControllers[newCameraCreator] = newCameraController
	else
		newCameraController = instantiatedCameraControllers[newCameraCreator]
		if newCameraController.Reset then
			newCameraController:Reset()
		end
	end

	if self.activeCameraController then
		-- deactivate the old controller and activate the new one
		if self.activeCameraController ~= newCameraController then
			self.activeCameraController:Enable(false)
			self.activeCameraController = newCameraController
			self.activeCameraController:Enable(true)
		elseif not self.activeCameraController:GetEnabled() then
			self.activeCameraController:Enable(true)
		end
	elseif newCameraController ~= nil then
		-- only activate the new controller
		self.activeCameraController = newCameraController
		self.activeCameraController:Enable(true)
	end

	if self.activeCameraController then
		if cameraMovementMode~=nil then
			self.activeCameraController:SetCameraMovementMode(cameraMovementMode)
		elseif legacyCameraType~=nil then
			-- Note that this is only called when legacyCameraType is not a type that
			-- was convertible to a ComputerCameraMovementMode value, i.e. really only applies to LegacyCamera
			self.activeCameraController:SetCameraType(legacyCameraType)
		end
	end
end

-- Note: The active transparency controller could be made to listen for this event itself.
function CameraModule:OnCameraSubjectChanged()
	local camera = workspace.CurrentCamera
	local cameraSubject = camera and camera.CameraSubject

	if self.activeTransparencyController then
		self.activeTransparencyController:SetSubject(cameraSubject)
	end

	if self.activeOcclusionModule then
		self.activeOcclusionModule:OnCameraSubjectChanged(cameraSubject)
	end

	self:ActivateCameraController(nil, camera.CameraType)
end

function CameraModule:OnCameraTypeChanged(newCameraType: Enum.CameraType)
	if newCameraType == Enum.CameraType.Scriptable then
		if UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter then
			CameraUtils.restoreMouseBehavior()
		end
	end

	-- Forward the change to ActivateCameraController to handle
	self:ActivateCameraController(nil, newCameraType)
end

-- Note: Called whenever workspace.CurrentCamera changes, but also on initialization of this script
function CameraModule:OnCurrentCameraChanged()
	local currentCamera = game.Workspace.CurrentCamera
	if not currentCamera then return end

	if self.cameraSubjectChangedConn then
		self.cameraSubjectChangedConn:Disconnect()
	end

	if self.cameraTypeChangedConn then
		self.cameraTypeChangedConn:Disconnect()
	end

	self.cameraSubjectChangedConn = currentCamera:GetPropertyChangedSignal("CameraSubject"):Connect(function()
		self:OnCameraSubjectChanged(currentCamera.CameraSubject)
	end)

	self.cameraTypeChangedConn = currentCamera:GetPropertyChangedSignal("CameraType"):Connect(function()
		self:OnCameraTypeChanged(currentCamera.CameraType)
	end)

	self:OnCameraSubjectChanged(currentCamera.CameraSubject)
	self:OnCameraTypeChanged(currentCamera.CameraType)
end

function CameraModule:OnLocalPlayerCameraPropertyChanged(propertyName: string)
	if propertyName == "CameraMode" then
		-- CameraMode is only used to turn on/off forcing the player into first person view. The
		-- Note: The case "Classic" is used for all other views and does not correspond only to the ClassicCamera module
		if Players.LocalPlayer.CameraMode == Enum.CameraMode.LockFirstPerson then
			-- Locked in first person, use ClassicCamera which supports this
			if not self.activeCameraController or self.activeCameraController:GetModuleName() ~= "ClassicCamera" then
				self:ActivateCameraController(CameraUtils.ConvertCameraModeEnumToStandard(Enum.DevComputerCameraMovementMode.Classic))
			end

			if self.activeCameraController then
				self.activeCameraController:UpdateForDistancePropertyChange()
			end
		elseif Players.LocalPlayer.CameraMode == Enum.CameraMode.Classic then
			-- Not locked in first person view
			local cameraMovementMode = self:GetCameraMovementModeFromSettings()
			self:ActivateCameraController(CameraUtils.ConvertCameraModeEnumToStandard(cameraMovementMode))
		else
			warn("Unhandled value for property player.CameraMode: ",Players.LocalPlayer.CameraMode)
		end

	elseif propertyName == "DevComputerCameraMode" or
		   propertyName == "DevTouchCameraMode" then
		local cameraMovementMode = self:GetCameraMovementModeFromSettings()
		self:ActivateCameraController(CameraUtils.ConvertCameraModeEnumToStandard(cameraMovementMode))

	elseif propertyName == "DevCameraOcclusionMode" then
		self:ActivateOcclusionModule(Players.LocalPlayer.DevCameraOcclusionMode)

	elseif propertyName == "CameraMinZoomDistance" or propertyName == "CameraMaxZoomDistance" then
		if self.activeCameraController then
			self.activeCameraController:UpdateForDistancePropertyChange()
		end
	elseif propertyName == "DevTouchMovementMode" then
	elseif propertyName == "DevComputerMovementMode" then
	elseif propertyName == "DevEnableMouseLock" then
		-- This is the enabling/disabling of "Shift Lock" mode, not LockFirstPerson (which is a CameraMode)
		-- Note: Enabling and disabling of MouseLock mode is normally only a publish-time choice made via
		-- the corresponding EnableMouseLockOption checkbox of StarterPlayer, and this script does not have
		-- support for changing the availability of MouseLock at runtime (this would require listening to
		-- Player.DevEnableMouseLock changes)
	end
end

function CameraModule:OnUserGameSettingsPropertyChanged(propertyName: string)
	if propertyName == "ComputerCameraMovementMode" then
		local cameraMovementMode = self:GetCameraMovementModeFromSettings()
		self:ActivateCameraController(CameraUtils.ConvertCameraModeEnumToStandard(cameraMovementMode))
	end
end

--[[
	Main RenderStep Update. The camera controller and occlusion module both have opportunities
	to set and modify (respectively) the CFrame and Focus before it is set once on CurrentCamera.
	The camera and occlusion modules should only return CFrames, not set the CFrame property of
	CurrentCamera directly.
--]]
function CameraModule:Update(dt)
	if self.activeCameraController then
		self.activeCameraController:UpdateMouseBehavior()

		local newCameraCFrame, newCameraFocus = self.activeCameraController:Update(dt)

		if self.activeOcclusionModule then
			newCameraCFrame, newCameraFocus = self.activeOcclusionModule:Update(dt, newCameraCFrame, newCameraFocus)
		end

		-- Here is where the new CFrame and Focus are set for this render frame
		local currentCamera = game.Workspace.CurrentCamera :: Camera
		currentCamera.CFrame = newCameraCFrame
		currentCamera.Focus = newCameraFocus

		-- Update to character local transparency as needed based on camera-to-subject distance
		if self.activeTransparencyController then
			self.activeTransparencyController:Update(dt)
		end

		if CameraInput.getInputEnabled() then
			CameraInput.resetInputForFrameEnd()
		end
	end
end

-- Formerly getCurrentCameraMode, this function resolves developer and user camera control settings to
-- decide which camera control module should be instantiated. The old method of converting redundant enum types
function CameraModule:GetCameraControlChoice()
	local player = Players.LocalPlayer

	if player then
		if UserInputService:GetLastInputType() == Enum.UserInputType.Touch or UserInputService.TouchEnabled then
			-- Touch
			if player.DevTouchCameraMode == Enum.DevTouchCameraMovementMode.UserChoice then
				return CameraUtils.ConvertCameraModeEnumToStandard( UserGameSettings.TouchCameraMovementMode )
			else
				return CameraUtils.ConvertCameraModeEnumToStandard( player.DevTouchCameraMode )
			end
		else
			-- Computer
			if player.DevComputerCameraMode == Enum.DevComputerCameraMovementMode.UserChoice then
				local computerMovementMode = CameraUtils.ConvertCameraModeEnumToStandard(UserGameSettings.ComputerCameraMovementMode)
				return CameraUtils.ConvertCameraModeEnumToStandard(computerMovementMode)
			else
				return CameraUtils.ConvertCameraModeEnumToStandard(player.DevComputerCameraMode)
			end
		end
	end
end

function CameraModule:OnCharacterAdded(char, player)
	if self.activeOcclusionModule then
		self.activeOcclusionModule:CharacterAdded(char, player)
	end
end

function CameraModule:OnCharacterRemoving(char, player)
	if self.activeOcclusionModule then
		self.activeOcclusionModule:CharacterRemoving(char, player)
	end
end

function CameraModule:OnPlayerAdded(player)
	player.CharacterAdded:Connect(function(char)
		self:OnCharacterAdded(char, player)
	end)
	player.CharacterRemoving:Connect(function(char)
		self:OnCharacterRemoving(char, player)
	end)
end

function CameraModule:OnMouseLockToggled()
	if self.activeMouseLockController then
		local mouseLocked = self.activeMouseLockController:GetIsMouseLocked()
		local mouseLockOffset = self.activeMouseLockController:GetMouseLockOffset()
		if self.activeCameraController then
			self.activeCameraController:SetIsMouseLocked(mouseLocked)
			self.activeCameraController:SetMouseLockOffset(mouseLockOffset)
		end
	end
end

local cameraModuleObject = CameraModule.new()

return {}

end))
ModuleScript6.Name = "VRBaseCamera"
ModuleScript6.Parent = ModuleScript5
table.insert(cors,sandbox(ModuleScript6,function()
--!nonstrict
--[[
	VRBaseCamera - Base class for VR camera
	2021 Roblox VR
--]]

--[[ Local Constants ]]--
local VR_ANGLE = math.rad(15)
local VR_PANEL_SIZE = 512
local VR_ZOOM = 7
local VR_FADE_SPEED = 10 -- 1/10 second
local VR_SCREEN_EGDE_BLEND_TIME = 0.14
local VR_SEAT_OFFSET = Vector3.new(0,4,0)

local FFlagUserVRVehicleCamera
do
	local success, result = pcall(function()
		return UserSettings():IsUserFeatureEnabled("UserVRVehicleCamera2")
	end)
	FFlagUserVRVehicleCamera = success and result
end

local VRService = game:GetService("VRService")

local CameraInput = require(script.Parent:WaitForChild("CameraInput"))
local ZoomController = require(script.Parent:WaitForChild("ZoomController"))

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")

local UserGameSettings = UserSettings():GetService("UserGameSettings")

--[[ The Module ]]--
local BaseCamera = require(script.Parent:WaitForChild("BaseCamera"))
local VRBaseCamera = setmetatable({}, BaseCamera)
VRBaseCamera.__index = VRBaseCamera

function VRBaseCamera.new()
	local self = setmetatable(BaseCamera.new(), VRBaseCamera)
	
	-- zoom levels cycles when pressing R3 on a gamepad, not multiplied by headscale yet
	self.gamepadZoomLevels = {0, VR_ZOOM}
	
	-- need to save headscale value to respond to changes
	self.headScale = 1

	self:SetCameraToSubjectDistance(VR_ZOOM)

	-- VR screen effect
	self.VRFadeResetTimer = 0
	self.VREdgeBlurTimer = 0

	-- initialize vr specific variables
	self.gamepadResetConnection = nil
	self.needsReset = true
	self.recentered = false
	
	-- timer for step rotation
	self:Reset()
	
	return self
end

function VRBaseCamera:Reset()
	self.stepRotateTimeout = 0
end

function VRBaseCamera:GetModuleName()
	return "VRBaseCamera"
end

function VRBaseCamera:GamepadZoomPress()
	BaseCamera.GamepadZoomPress(self)

	-- don't want the spring animation in VR, may cause motion sickness
	self:GamepadReset()
	self:ResetZoom()
end

function VRBaseCamera:GamepadReset()
	self.stepRotateTimeout = 0
	self.needsReset = true
end

function VRBaseCamera:ResetZoom()
	ZoomController.SetZoomParameters(self.currentSubjectDistance, 0)
	ZoomController.ReleaseSpring()
end

function VRBaseCamera:OnEnabledChanged()
	BaseCamera.OnEnabledChanged(self)

	if self.enabled then
		self.gamepadResetConnection = CameraInput.gamepadReset:Connect(function()
			self:GamepadReset()
		end)
		
		-- reset on options change
		self.thirdPersonOptionChanged = VRService:GetPropertyChangedSignal("ThirdPersonFollowCamEnabled"):Connect(function()
			if FFlagUserVRVehicleCamera then
				self:Reset()
			else
				-- only need to reset third person options if in third person
				if not self:IsInFirstPerson() then
					self:Reset()
				end 
			end
		end)
		
		self.vrRecentered = VRService.UserCFrameChanged:Connect(function(userCFrame, _)
			if userCFrame == Enum.UserCFrame.Floor then
				self.recentered = true
			end
		end)
	else
		-- make sure zoom is reset when switching to another camera
		if self.inFirstPerson then
			self:GamepadZoomPress()
		end

		-- disconnect connections
		if self.thirdPersonOptionChanged then
			self.thirdPersonOptionChanged:Disconnect()
			self.thirdPersonOptionChanged = nil
		end

		if self.vrRecentered then
			self.vrRecentered:Disconnect()
			self.vrRecentered = nil
		end
		
		if self.cameraHeadScaleChangedConn then
			self.cameraHeadScaleChangedConn:Disconnect()
			self.cameraHeadScaleChangedConn = nil
		end

		if self.gamepadResetConnection then
			self.gamepadResetConnection:Disconnect()
			self.gamepadResetConnection = nil
		end

		-- reset VR effects
		self.VREdgeBlurTimer = 0
		self:UpdateEdgeBlur(player, 1)
		local VRFade = Lighting:FindFirstChild("VRFade")
		if VRFade then
			VRFade.Brightness = 0
		end
	end
end

function VRBaseCamera:OnCurrentCameraChanged()
	BaseCamera.OnCurrentCameraChanged(self)

	-- disconnect connections to reestablish on new camera
	if self.cameraHeadScaleChangedConn then
		self.cameraHeadScaleChangedConn:Disconnect()
		self.cameraHeadScaleChangedConn = nil
	end
	
	-- add new connections if camera is valid
	local camera = workspace.CurrentCamera :: Camera
	if camera then
		self.cameraHeadScaleChangedConn = camera:GetPropertyChangedSignal("HeadScale"):Connect(function() self:OnHeadScaleChanged() end)
		self:OnHeadScaleChanged()
	end
end

function VRBaseCamera:OnHeadScaleChanged()

	local camera = workspace.CurrentCamera :: Camera
	local newHeadScale = camera.HeadScale
	
	-- scale zoom levels by headscale
	for i, zoom in self.gamepadZoomLevels do
		self.gamepadZoomLevels[i] = zoom * newHeadScale / self.headScale
	end
		
	-- rescale current distance
	self:SetCameraToSubjectDistance(self:GetCameraToSubjectDistance()  * newHeadScale / self.headScale)
	self.headScale = newHeadScale
end

-- defines subject and height of VR camera
function VRBaseCamera:GetVRFocus(subjectPosition, timeDelta)
	local lastFocus = self.lastCameraFocus or subjectPosition

	self.cameraTranslationConstraints = Vector3.new(
		self.cameraTranslationConstraints.x,
		math.min(1, self.cameraTranslationConstraints.y + timeDelta),
		self.cameraTranslationConstraints.z)

	local cameraHeightDelta = Vector3.new(0, self:GetCameraHeight(), 0)
	local newFocus = CFrame.new(Vector3.new(subjectPosition.x, lastFocus.y, subjectPosition.z):
			Lerp(subjectPosition + cameraHeightDelta, self.cameraTranslationConstraints.y))

	return newFocus
end

-- (VR) Screen effects --------------
function VRBaseCamera:StartFadeFromBlack()
	if UserGameSettings.VignetteEnabled == false then
		return
	end

	local VRFade = Lighting:FindFirstChild("VRFade")
	if not VRFade then
		VRFade = Instance.new("ColorCorrectionEffect")
		VRFade.Name = "VRFade"
		VRFade.Parent = Lighting
	end
	VRFade.Brightness = -1
	self.VRFadeResetTimer = 0.1
end

function VRBaseCamera:UpdateFadeFromBlack(timeDelta: number)
	local VRFade = Lighting:FindFirstChild("VRFade")
	if self.VRFadeResetTimer > 0  then
		self.VRFadeResetTimer = math.max(self.VRFadeResetTimer - timeDelta, 0)

		local VRFade = Lighting:FindFirstChild("VRFade")
		if VRFade and VRFade.Brightness < 0 then
			VRFade.Brightness = math.min(VRFade.Brightness + timeDelta * VR_FADE_SPEED, 0)
		end
	else
		if VRFade then -- sanity check, VRFade off
			VRFade.Brightness = 0
		end
	end
end

function VRBaseCamera:StartVREdgeBlur(player)
	if UserGameSettings.VignetteEnabled == false then
		return
	end

	local blurPart = nil
	blurPart = (workspace.CurrentCamera :: Camera):FindFirstChild("VRBlurPart")
	if not blurPart then
		local basePartSize = Vector3.new(0.44,0.47,1)
		blurPart = Instance.new("Part")
		blurPart.Name = "VRBlurPart"
		blurPart.Parent = workspace.CurrentCamera
		blurPart.CanTouch = false
		blurPart.CanCollide = false
		blurPart.CanQuery = false
		blurPart.Anchored = true
		blurPart.Size = basePartSize
		blurPart.Transparency = 1
		blurPart.CastShadow = false

		RunService.RenderStepped:Connect(function(step)
			local userHeadCF = VRService:GetUserCFrame(Enum.UserCFrame.Head)

			local vrCF = (workspace.CurrentCamera :: Camera).CFrame * (CFrame.new(userHeadCF.p * (workspace.CurrentCamera :: Camera).HeadScale) * (userHeadCF - userHeadCF.p))
			blurPart.CFrame = (vrCF * CFrame.Angles(0, math.rad(180), 0)) + vrCF.LookVector * (1.05 * (workspace.CurrentCamera :: Camera).HeadScale)
			blurPart.Size = basePartSize * (workspace.CurrentCamera :: Camera).HeadScale
		end)
	end

	local VRScreen = player.PlayerGui:FindFirstChild("VRBlurScreen")
	local VRBlur = nil
	if VRScreen then
		VRBlur = VRScreen:FindFirstChild("VRBlur")
	end

	if not VRBlur then
		if not VRScreen then
			VRScreen = Instance.new("SurfaceGui") or Instance.new("ScreenGui")
		end

		VRScreen.Name = "VRBlurScreen"
		VRScreen.Parent = player.PlayerGui

		VRScreen.Adornee = blurPart

		VRBlur = Instance.new("ImageLabel")
		VRBlur.Name = "VRBlur"
		VRBlur.Parent = VRScreen

		VRBlur.Image = "rbxasset://textures/ui/VR/edgeBlur.png"
		VRBlur.AnchorPoint = Vector2.new(0.5, 0.5)
		VRBlur.Position = UDim2.new(0.5, 0, 0.5, 0)

		-- this computes the ratio between the GUI 3D panel and the VR viewport
		-- adding 15% overshoot for edges on 2 screen headsets
		local ratioX = (workspace.CurrentCamera :: Camera).ViewportSize.X * 2.3 / VR_PANEL_SIZE
		local ratioY = (workspace.CurrentCamera :: Camera).ViewportSize.Y * 2.3 / VR_PANEL_SIZE

		VRBlur.Size = UDim2.fromScale(ratioX, ratioY)
		VRBlur.BackgroundTransparency = 1
		VRBlur.Active = true
		VRBlur.ScaleType = Enum.ScaleType.Stretch
	end

	VRBlur.Visible = true
	VRBlur.ImageTransparency = 0
	self.VREdgeBlurTimer = VR_SCREEN_EGDE_BLEND_TIME
end

function VRBaseCamera:UpdateEdgeBlur(player, timeDelta)
	local VRScreen = player.PlayerGui:FindFirstChild("VRBlurScreen")
	local VRBlur = nil
	if VRScreen then
		VRBlur = VRScreen:FindFirstChild("VRBlur")
	end

	if VRBlur then
		if self.VREdgeBlurTimer > 0 then
			self.VREdgeBlurTimer = self.VREdgeBlurTimer - timeDelta

			local VRScreen = player.PlayerGui:FindFirstChild("VRBlurScreen")
			if VRScreen then
				local VRBlur = VRScreen:FindFirstChild("VRBlur")
				if VRBlur then
					VRBlur.ImageTransparency = 1.0 - math.clamp(self.VREdgeBlurTimer, 0.01,
						VR_SCREEN_EGDE_BLEND_TIME) * (1/VR_SCREEN_EGDE_BLEND_TIME)
				end
			end
		else
			VRBlur.Visible = false
		end
	end
end

function VRBaseCamera:GetCameraHeight()
	if not self.inFirstPerson then
		return math.sin(VR_ANGLE) * self.currentSubjectDistance
	end
	return 0
end

function VRBaseCamera:GetSubjectCFrame(): CFrame
	local result = BaseCamera.GetSubjectCFrame(self)
	local camera = workspace.CurrentCamera
	local cameraSubject = camera and camera.CameraSubject

	if not cameraSubject then
		return result
	end

	-- new VR system overrides
	if cameraSubject:IsA("Humanoid") then
		local humanoid = cameraSubject
		local humanoidIsDead = humanoid:GetState() == Enum.HumanoidStateType.Dead

		if humanoidIsDead and humanoid == self.lastSubject then
			result = self.lastSubjectCFrame
		end
	end

	if result then
		self.lastSubjectCFrame = result
	end

	return result
end

function VRBaseCamera:GetSubjectPosition(): Vector3?
	local result = BaseCamera.GetSubjectPosition(self)

	-- new VR system overrides
	local camera = game.Workspace.CurrentCamera
	local cameraSubject = camera and camera.CameraSubject
	if cameraSubject then
		if cameraSubject:IsA("Humanoid") then
			local humanoid = cameraSubject
			local humanoidIsDead = humanoid:GetState() == Enum.HumanoidStateType.Dead

			if  humanoidIsDead and humanoid == self.lastSubject then
				result = self.lastSubjectPosition
			end
		elseif cameraSubject:IsA("VehicleSeat") then
			local offset = VR_SEAT_OFFSET
			result = cameraSubject.CFrame.p + cameraSubject.CFrame:vectorToWorldSpace(offset)
		end
	else
		return nil
	end

	self.lastSubjectPosition = result

	return result
end

-- gets the desired rotation accounting for smooth rotation. Manages fades and resets resulting 
-- from rotation
function VRBaseCamera:getRotation(dt)
	local rotateInput = CameraInput.getRotation()
	local yawDelta = 0
	
	if UserGameSettings.VRSmoothRotationEnabled then
		yawDelta = rotateInput.X * 40 * dt
	else
		
		if math.abs(rotateInput.X) > 0.03 then
			if self.stepRotateTimeout > 0 then
				self.stepRotateTimeout -= dt
			end
			
			if self.stepRotateTimeout <= 0 then
				yawDelta = 1
				if rotateInput.X < 0 then
					yawDelta = -1
				end
				
				yawDelta *= math.rad(30)
				self:StartFadeFromBlack()
				self.stepRotateTimeout = 0.25
			end
		elseif math.abs(rotateInput.X) < 0.02 then
			self.stepRotateTimeout = 0 -- allow fast rotation when spamming input
		end
	end
	
	return yawDelta

end

-----------------------------

return VRBaseCamera
end))
ModuleScript7.Name = "TransparencyController"
ModuleScript7.Parent = ModuleScript5
table.insert(cors,sandbox(ModuleScript7,function()
--!nonstrict
--[[
	TransparencyController - Manages transparency of player character at close camera-to-subject distances
	2018 Camera Update - AllYourBlox
--]]

local FFlagUserVRAvatarGestures
do
	local success, result = pcall(function()
		return UserSettings():IsUserFeatureEnabled("UserVRAvatarGestures")
	end)
	FFlagUserVRAvatarGestures = success and result
end

local VRService = game:GetService("VRService")
local MAX_TWEEN_RATE = 2.8 -- per second

local Util = require(script.Parent:WaitForChild("CameraUtils"))

--[[ The Module ]]--
local TransparencyController = {}
TransparencyController.__index = TransparencyController

function TransparencyController.new()
	local self = setmetatable({}, TransparencyController)

	self.transparencyDirty = false
	self.enabled = false
	self.lastTransparency = nil

	self.descendantAddedConn, self.descendantRemovingConn = nil, nil
	self.toolDescendantAddedConns = {}
	self.toolDescendantRemovingConns = {}
	self.cachedParts = {}

	return self
end


function TransparencyController:HasToolAncestor(object: Instance)
	if object.Parent == nil then return false end
	assert(object.Parent, "")
	return object.Parent:IsA('Tool') or self:HasToolAncestor(object.Parent)
end

function TransparencyController:IsValidPartToModify(part: BasePart)
	if part:IsA('BasePart') or part:IsA('Decal') then
		return not self:HasToolAncestor(part)
	end
	return false
end

function TransparencyController:CachePartsRecursive(object)
	if object then
		if self:IsValidPartToModify(object) then
			self.cachedParts[object] = true
			self.transparencyDirty = true
		end
		for _, child in pairs(object:GetChildren()) do
			self:CachePartsRecursive(child)
		end
	end
end

function TransparencyController:TeardownTransparency()
	for child, _ in pairs(self.cachedParts) do
		child.LocalTransparencyModifier = 0
	end
	self.cachedParts = {}
	self.transparencyDirty = true
	self.lastTransparency = nil

	if self.descendantAddedConn then
		self.descendantAddedConn:disconnect()
		self.descendantAddedConn = nil
	end
	if self.descendantRemovingConn then
		self.descendantRemovingConn:disconnect()
		self.descendantRemovingConn = nil
	end
	for object, conn in pairs(self.toolDescendantAddedConns) do
		conn:Disconnect()
		self.toolDescendantAddedConns[object] = nil
	end
	for object, conn in pairs(self.toolDescendantRemovingConns) do
		conn:Disconnect()
		self.toolDescendantRemovingConns[object] = nil
	end
end

function TransparencyController:SetupTransparency(character)
	self:TeardownTransparency()

	if self.descendantAddedConn then self.descendantAddedConn:disconnect() end
	self.descendantAddedConn = character.DescendantAdded:Connect(function(object)
		-- This is a part we want to invisify
		if self:IsValidPartToModify(object) then
			self.cachedParts[object] = true
			self.transparencyDirty = true
		-- There is now a tool under the character
		elseif object:IsA('Tool') then
			if self.toolDescendantAddedConns[object] then self.toolDescendantAddedConns[object]:Disconnect() end
			self.toolDescendantAddedConns[object] = object.DescendantAdded:Connect(function(toolChild)
				self.cachedParts[toolChild] = nil
				if toolChild:IsA('BasePart') or toolChild:IsA('Decal') then
					-- Reset the transparency
					toolChild.LocalTransparencyModifier = 0
				end
			end)
			if self.toolDescendantRemovingConns[object] then self.toolDescendantRemovingConns[object]:disconnect() end
			self.toolDescendantRemovingConns[object] = object.DescendantRemoving:Connect(function(formerToolChild)
				wait() -- wait for new parent
				if character and formerToolChild and formerToolChild:IsDescendantOf(character) then
					if self:IsValidPartToModify(formerToolChild) then
						self.cachedParts[formerToolChild] = true
						self.transparencyDirty = true
					end
				end
			end)
		end
	end)
	if self.descendantRemovingConn then self.descendantRemovingConn:disconnect() end
	self.descendantRemovingConn = character.DescendantRemoving:connect(function(object)
		if self.cachedParts[object] then
			self.cachedParts[object] = nil
			-- Reset the transparency
			object.LocalTransparencyModifier = 0
		end
	end)
	self:CachePartsRecursive(character)
end


function TransparencyController:Enable(enable: boolean)
	if self.enabled ~= enable then
		self.enabled = enable
	end
end

function TransparencyController:SetSubject(subject)
	local character = nil
	if subject and subject:IsA("Humanoid") then
		character = subject.Parent
	end
	if subject and subject:IsA("VehicleSeat") and subject.Occupant then
		character = subject.Occupant.Parent
	end
	if character then
		self:SetupTransparency(character)
	else
		self:TeardownTransparency()
	end
end

function TransparencyController:Update(dt)
	local currentCamera = workspace.CurrentCamera

	if currentCamera and self.enabled then
		-- calculate goal transparency based on distance
		local distance = (currentCamera.Focus.p - currentCamera.CoordinateFrame.p).magnitude
		local transparency = (distance<2) and (1.0-(distance-0.5)/1.5) or 0 -- (7 - distance) / 5
		if transparency < 0.5 then -- too far, don't control transparency
			transparency = 0
		end

		-- tween transparency if the goal is not fully transparent and the subject was not fully transparent last frame
		if self.lastTransparency and transparency < 1 and self.lastTransparency < 0.95 then
			local deltaTransparency = transparency - self.lastTransparency
			local maxDelta = MAX_TWEEN_RATE * dt
			deltaTransparency = math.clamp(deltaTransparency, -maxDelta, maxDelta)
			transparency = self.lastTransparency + deltaTransparency
		else
			self.transparencyDirty = true
		end

		transparency = math.clamp(Util.Round(transparency, 2), 0, 1)

		-- update transparencies 
		if self.transparencyDirty or self.lastTransparency ~= transparency then
			for child, _ in pairs(self.cachedParts) do
				if FFlagUserVRAvatarGestures and VRService.VREnabled and VRService.AvatarGestures then
					-- keep the arms visible in VR
					local hiddenAccessories = {
						    [Enum.AccessoryType.Hat] = true,
    						[Enum.AccessoryType.Hair] = true,
    						[Enum.AccessoryType.Face] = true,
    						[Enum.AccessoryType.Eyebrow] = true,
 						   [Enum.AccessoryType.Eyelash] = true,
					}
					if (child.Parent:IsA("Accessory") and hiddenAccessories[child.Parent.AccessoryType]) or child.Name == "Head" then
						child.LocalTransparencyModifier = transparency
					else
						-- body should always be visible in VR
						child.LocalTransparencyModifier = 0
					end
				else
					child.LocalTransparencyModifier = transparency
				end
			end
			self.transparencyDirty = false
			self.lastTransparency = transparency
		end
	end
end

return TransparencyController

end))
ModuleScript8.Name = "BaseOcclusion"
ModuleScript8.Parent = ModuleScript5
table.insert(cors,sandbox(ModuleScript8,function()
--[[
	BaseOcclusion - Abstract base class for character occlusion control modules
	2018 Camera Update - AllYourBlox
--]]

--[[ The Module ]]--
local BaseOcclusion: any = {}
BaseOcclusion.__index = BaseOcclusion
setmetatable(BaseOcclusion, {
	__call = function(_, ...)
		return BaseOcclusion.new(...)
	end
})

function BaseOcclusion.new()
	local self = setmetatable({}, BaseOcclusion)
	return self
end

-- Called when character is added
function BaseOcclusion:CharacterAdded(char: Model, player: Player)
end

-- Called when character is about to be removed
function BaseOcclusion:CharacterRemoving(char: Model, player: Player)
end

function BaseOcclusion:OnCameraSubjectChanged(newSubject)
end

--[[ Derived classes are required to override and implement all of the following functions ]]--
function BaseOcclusion:GetOcclusionMode(): Enum.DevCameraOcclusionMode?
	-- Must be overridden in derived classes to return an Enum.DevCameraOcclusionMode value
	warn("BaseOcclusion GetOcclusionMode must be overridden by derived classes")
	return nil
end

function BaseOcclusion:Enable(enabled: boolean)
	warn("BaseOcclusion Enable must be overridden by derived classes")
end

function BaseOcclusion:Update(dt: number, desiredCameraCFrame: CFrame, desiredCameraFocus: CFrame)
	warn("BaseOcclusion Update must be overridden by derived classes")
	return desiredCameraCFrame, desiredCameraFocus
end

return BaseOcclusion

end))
ModuleScript9.Name = "VRVehicleCamera"
ModuleScript9.Parent = ModuleScript5
table.insert(cors,sandbox(ModuleScript9,function()
--!nonstrict
--[[
	VRVehicleCamera - Roblox VR vehicle camera control module
	2021 Roblox VR
--]]

local FFlagUserVRVehicleCamera
do
	local success, result = pcall(function()
		return UserSettings():IsUserFeatureEnabled("UserVRVehicleCamera2")
	end)
	FFlagUserVRVehicleCamera = success and result
end

local EPSILON = 1e-3
local MIN_ASSEMBLY_RADIUS = 5
local PITCH_LIMIT = math.rad(80)
local YAW_DEFAULT = math.rad(0)
local ZOOM_MINIMUM = 0.5
local ZOOM_SENSITIVITY_CURVATURE = 0.5
local TP_FOLLOW_DIST = 200
local TP_FOLLOW_ANGLE_DOT = 0.56
-- assume an assembly radius of 10
local DEFAULT_GAMEPAD_ZOOM_LEVELS = {0, 30}

local UserGameSettings = UserSettings():GetService("UserGameSettings")

local VRBaseCamera = require(script.Parent:WaitForChild("VRBaseCamera"))
local CameraInput = require(script.Parent:WaitForChild("CameraInput"))
local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"))
local VehicleCamera = require(script.Parent:WaitForChild("VehicleCamera"))
local VehicleCameraCore =  require(script.Parent.VehicleCamera:FindFirstChild("VehicleCameraCore")) :: any
local VehicleCameraConfig = require(script.Parent.VehicleCamera:FindFirstChild("VehicleCameraConfig")) :: any
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local VRService = game:GetService("VRService")

local localPlayer = Players.LocalPlayer
local Spring = CameraUtils.Spring
local mapClamp = CameraUtils.mapClamp
local sanitizeAngle = CameraUtils.sanitizeAngle

local ZERO_VECTOR3 = Vector3.new(0,0,0)

-- pitch-axis rotational velocity of a part with a given CFrame and total RotVelocity
local function pitchVelocity(rotVel, cf)
	return math.abs(cf.XVector:Dot(rotVel))
end

-- yaw-axis rotational velocity of a part with a given CFrame and total RotVelocity
local function yawVelocity(rotVel, cf)
	return math.abs(cf.YVector:Dot(rotVel))
end

local worldDt = 1/60
local VRVehicleCamera = setmetatable({}, VRBaseCamera)
VRVehicleCamera.__index = VRVehicleCamera

function VRVehicleCamera.new()
	local self = setmetatable(VRBaseCamera.new(), VRVehicleCamera)
	self:Reset()

	-- track physics solver time delta separately from the render loop to correctly synchronize time delta
	RunService.Stepped:Connect(function(_, _worldDt)
		worldDt = _worldDt
	end)

	return self
end

-- Reset member function is for initialization, not for camera snaps or transitions 
function VRVehicleCamera:Reset()
	self.vehicleCameraCore = VehicleCameraCore.new(self:GetSubjectCFrame())
	if FFlagUserVRVehicleCamera then
		self.pitchSpring = Spring.new(0, 0)
	else
		self.pitchSpring = Spring.new(0, -math.rad(VehicleCameraConfig.pitchBaseAngle))
	end
	self.yawSpring = Spring.new(0, YAW_DEFAULT)

	if FFlagUserVRVehicleCamera then
		self.lastPanTick = 0
		self.currentDriftAngle = 0
		self.needsReset = true
	end

	local camera = workspace.CurrentCamera
	local cameraSubject = camera and camera.CameraSubject

	assert(camera, "VRVehicleCamera initialization error")
	assert(cameraSubject)
	assert(cameraSubject:IsA("VehicleSeat"))

	local assemblyParts = cameraSubject:GetConnectedParts(true) -- passing true to recursively get all assembly parts
	local assemblyPosition, assemblyRadius = CameraUtils.getLooseBoundingSphere(assemblyParts)

	-- limit min assembly radius to 5 to prevent extremely small zooms
	assemblyRadius = math.max(assemblyRadius, MIN_ASSEMBLY_RADIUS)

	self.assemblyRadius = assemblyRadius
	self.assemblyOffset = cameraSubject.CFrame:Inverse()*assemblyPosition -- seat-space offset of the assembly bounding sphere center

	-- scale zoom levels by car radius and headscale
	self.gamepadZoomLevels = {}
	for i, zoom in DEFAULT_GAMEPAD_ZOOM_LEVELS do
		table.insert(self.gamepadZoomLevels, zoom * self.headScale * self.assemblyRadius / 10)
	end
	self.lastCameraFocus = nil
	self:SetCameraToSubjectDistance(self.gamepadZoomLevels[#self.gamepadZoomLevels])
end

function VRVehicleCamera:_StepRotation(dt, vdotz): CFrame
	local yawSpring = self.yawSpring
	local pitchSpring = self.pitchSpring

	local rotationInput = self:getRotation(dt)
	local dYaw = -rotationInput

	yawSpring.pos = sanitizeAngle(yawSpring.pos + dYaw)
	pitchSpring.pos = sanitizeAngle(math.clamp(pitchSpring.pos, -PITCH_LIMIT, PITCH_LIMIT))

	if CameraInput.getRotationActivated() then
		self.lastPanTick = os.clock()
	end

	local pitchBaseAngle = 0
	local pitchDeadzoneAngle = math.rad(VehicleCameraConfig.pitchDeadzoneAngle)

	if os.clock() - self.lastPanTick > VehicleCameraConfig.autocorrectDelay then
		-- adjust autocorrect response based on forward velocity
		local autocorrectResponse = mapClamp(
			vdotz,
			VehicleCameraConfig.autocorrectMinCarSpeed,
			VehicleCameraConfig.autocorrectMaxCarSpeed,
			0,
			VehicleCameraConfig.autocorrectResponse
		)

		yawSpring.freq = autocorrectResponse
		pitchSpring.freq = autocorrectResponse

		-- zero out response under a threshold
		if yawSpring.freq < EPSILON then
			yawSpring.vel = 0
		end

		if pitchSpring.freq < EPSILON then
			pitchSpring.vel = 0
		end

		if math.abs(sanitizeAngle(pitchBaseAngle - pitchSpring.pos)) <= pitchDeadzoneAngle then
			-- do nothing within the deadzone
			pitchSpring.goal = pitchSpring.pos
		else
			pitchSpring.goal = pitchBaseAngle
		end
	else
		yawSpring.freq = 0
		yawSpring.vel = 0

		pitchSpring.freq = 0
		pitchSpring.vel = 0

		pitchSpring.goal = pitchBaseAngle
	end

	return CFrame.fromEulerAnglesYXZ(
		pitchSpring:step(dt),
		yawSpring:step(dt),
		0
	)
end

-- offset from the subject which describes where on the vehicle should be focused. This is not the offset of the camera
-- from the vehicle subject position.
function VRVehicleCamera:_GetThirdPersonLocalOffset()
	return self.assemblyOffset + Vector3.new(0, self.assemblyRadius*VehicleCameraConfig.verticalCenterOffset, 0)
end

function VRVehicleCamera:_GetFirstPersonLocalOffset(subjectCFrame: CFrame)
	local character = localPlayer.Character

	if character and character.Parent then
		local head = character:FindFirstChild("Head")

		if head and head:IsA("BasePart") then
			return subjectCFrame:Inverse() * head.Position
		end
	end

	return self:_GetThirdPersonLocalOffset()
end

function VRVehicleCamera:Update()

	if FFlagUserVRVehicleCamera then
		local dt = worldDt
		worldDt = 0

		-- update fade from black
		self:UpdateFadeFromBlack(dt)
		self:UpdateEdgeBlur(localPlayer, dt)

		local camera, focus
		if VRService.ThirdPersonFollowCamEnabled then
			camera, focus = self:UpdateStepRotation(dt)
		else
			camera, focus = self:UpdateComfortCamera(dt)
		end

		return camera, focus
	else
		return self:UpdateComfortCamera()
	end
end

function VRVehicleCamera:addDrift(currentCamera, focus)
	local function NormalizeAngle(angle): number
		angle = (angle + math.pi*4) % (math.pi*2)
		if angle > math.pi then
			angle = angle - math.pi*2
		end
		return angle
	end


	local camera = workspace.CurrentCamera

	local zoom = self:GetCameraToSubjectDistance()
	local subjectVel: Vector3 = self:GetSubjectVelocity()
	local subjectCFrame: CFrame = self:GetSubjectCFrame()
	local controlModule = require(localPlayer:WaitForChild("PlayerScripts").PlayerModule:WaitForChild("ControlModule"))

	-- while moving, slowly adjust camera so the avatar is in front of your head
	if subjectVel.Magnitude > 0.1 then -- is the subject moving?

		local headOffset = VRService:GetUserCFrame(Enum.UserCFrame.Head)
		--local headOffset = controlModule:GetEstimatedVRTorsoFrame()

		-- account for headscale
		headOffset = headOffset.Rotation + headOffset.Position * camera.HeadScale
		local headCframe = camera.CFrame * headOffset

		local _, headAngle, _ = headCframe:ToEulerAnglesYXZ()
		local _, carAngle, _ = subjectCFrame:ToEulerAnglesYXZ()
		local headAngleRelativeToCurrentAngle = NormalizeAngle(headAngle - self.currentDriftAngle)
        local carAngleRelativeToCurrentAngle = NormalizeAngle(carAngle - self.currentDriftAngle)

        local minimumValidAngle = math.min(carAngleRelativeToCurrentAngle, headAngleRelativeToCurrentAngle)
        local maximumValidAngle = math.max(carAngleRelativeToCurrentAngle, headAngleRelativeToCurrentAngle)

        local relativeAngleToUse = 0
        if minimumValidAngle > 0 then
            relativeAngleToUse = minimumValidAngle
        elseif maximumValidAngle < 0 then
            relativeAngleToUse = maximumValidAngle
        end

        self.currentDriftAngle = relativeAngleToUse + self.currentDriftAngle
		local angleCFrame = CFrame.fromEulerAnglesYXZ(0, self.currentDriftAngle, 0)
		local angleLook = angleCFrame.LookVector

		local headVectorDirection = Vector3.new(angleLook.X, 0, angleLook.Z).Unit * zoom
		local goalHeadPosition = focus.Position - headVectorDirection
		
		-- place the camera at currentposition + difference between goalHead and currentHead 
		local moveGoalCameraCFrame = CFrame.new(camera.CFrame.Position + goalHeadPosition - headCframe.Position) * camera.CFrame.Rotation 

		currentCamera = currentCamera:Lerp(moveGoalCameraCFrame, 0.01)
	end

	return currentCamera, focus
end

function VRVehicleCamera:UpdateRotationCamera(dt)
	local camera = workspace.CurrentCamera
	local cameraSubject = camera and camera.CameraSubject
	local vehicleCameraCore = self.vehicleCameraCore

	assert(camera)
	assert(cameraSubject)
	assert(cameraSubject:IsA("VehicleSeat"))

	-- consume the physics solver time delta to account for mismatched physics/render cycles
	-- get subject info
	local subjectCFrame: CFrame = self:GetSubjectCFrame()
	local subjectVel: Vector3 = self:GetSubjectVelocity()
	local subjectRotVel = self:GetSubjectRotVelocity()

	-- measure the local-to-world-space forward velocity of the vehicle
	local vDotZ = math.abs(subjectVel:Dot(subjectCFrame.ZVector))
	local yawVel = yawVelocity(subjectRotVel, subjectCFrame)
	local pitchVel = pitchVelocity(subjectRotVel, subjectCFrame)

	local zoom = self:GetCameraToSubjectDistance()

	-- mix third and first person offsets in local space
	local firstPerson = mapClamp(zoom, ZOOM_MINIMUM, self.assemblyRadius, 1, 0)

	local tpOffset = self:_GetThirdPersonLocalOffset()
	local fpOffset = self:_GetFirstPersonLocalOffset(subjectCFrame)
	local localOffset = tpOffset:Lerp(fpOffset, firstPerson)

	-- step core forward
	vehicleCameraCore:setTransform(subjectCFrame)
	local processedRotation = vehicleCameraCore:step(dt, pitchVel, yawVel, firstPerson)


	local objectRotation = self:_StepRotation(dt, vDotZ)

	local focus = self:GetVRFocus(subjectCFrame*localOffset, dt)*processedRotation*objectRotation
	local cf = focus*CFrame.new(0, 0, zoom)

	-- vignette
	if subjectVel.Magnitude > 0.1 then
		self:StartVREdgeBlur(localPlayer)
	end

	return cf, focus
end

function VRVehicleCamera:UpdateStepRotation(dt)
	local cf, focus

	local camera = workspace.CurrentCamera

	-- get subject info
	local lastSubjectCFrame = self.lastSubjectCFrame
	local subjectCFrame: CFrame = self:GetSubjectCFrame()
	local subjectVel: Vector3 = self:GetSubjectVelocity()

	local zoom = self:GetCameraToSubjectDistance()

	-- mix third and first person offsets in local space
	local firstPerson = mapClamp(zoom, ZOOM_MINIMUM, self.assemblyRadius, 1, 0)

	local tpOffset = self:_GetThirdPersonLocalOffset()
	local fpOffset = self:_GetFirstPersonLocalOffset(subjectCFrame)
	local localOffset = tpOffset:Lerp(fpOffset, firstPerson)
	local offsetSubject = subjectCFrame * localOffset

	focus = self:GetVRFocus(offsetSubject, dt)

	-- maintain the offset of the camera from the subject (ignoring subject rotation)
	cf = focus:ToWorldSpace(self:GetVRFocus(lastSubjectCFrame * localOffset, dt):ToObjectSpace(camera.CFrame))

	cf, focus = self:addDrift(cf, focus)

	local yawDelta = self:getRotation(dt)
	if math.abs(yawDelta) > 0 then

		local cameraOffset = focus:ToObjectSpace(cf)
		local rotatedCamera = focus * CFrame.Angles(0, -yawDelta, 0)* cameraOffset

		-- when using step rotation, the snapping should lock the VR player's head to the car's forward
		if not UserGameSettings.VRSmoothRotationEnabled then
			-- get the head's location in world space
			local headOffset = VRService:GetUserCFrame(Enum.UserCFrame.Head)

			-- account for headscale
			headOffset = headOffset.Rotation + headOffset.Position * camera.HeadScale
			local focusWithRotation = focus * subjectCFrame.Rotation

			local headOffsetCurrent = focusWithRotation:ToObjectSpace(cf * headOffset) -- current offset without rotation applied
			local currentVector = Vector3.new(headOffsetCurrent.X, 0, headOffsetCurrent.Z).Unit -- don't care about Y angle
			local currentAngleFromBack = math.acos(currentVector:Dot(Vector3.new(0, 0, 1)))

			local headOffsetRotated = focusWithRotation:ToObjectSpace(rotatedCamera * headOffset) -- where the head would be after rotation
			local rotatedVector = Vector3.new(headOffsetRotated.X, 0, headOffsetRotated.Z).Unit -- don't care about Y angle
			local rotatedAngleFromBack = math.acos(rotatedVector:Dot(Vector3.new(0, 0, 1)))

			-- if the player is rotating towards the back of the car
			if rotatedAngleFromBack < currentAngleFromBack then
				if yawDelta < 0 then
					currentAngleFromBack *= -1
				end
				rotatedCamera = focus * CFrame.Angles(0, -currentAngleFromBack, 0) * cameraOffset
			end

		end

		cf = rotatedCamera
	end

	-- vignette
	if subjectVel.Magnitude > 0.1 then
		self:StartVREdgeBlur(localPlayer)
	end

	if self.needsReset then

		self.needsReset = false
		VRService:RecenterUserHeadCFrame()
		self:StartFadeFromBlack()
		self:ResetZoom()
	end
	
	if self.recentered then
		focus *= subjectCFrame.Rotation
		cf = focus * CFrame.new(0, 0, zoom)

		self.recentered = false
	end

	return cf, cf * CFrame.new(0, 0, -zoom)
end

function VRVehicleCamera:UpdateComfortCamera(dt)
	local camera = workspace.CurrentCamera
	local cameraSubject = camera and camera.CameraSubject
	local vehicleCameraCore = self.vehicleCameraCore

	assert(camera)
	assert(cameraSubject)
	assert(cameraSubject:IsA("VehicleSeat"))

	if not FFlagUserVRVehicleCamera then
		-- consume the physics solver time delta to account for mismatched physics/render cycles
		dt = worldDt
		worldDt = 0
	end

	-- get subject info
	local subjectCFrame: CFrame = self:GetSubjectCFrame()
	local subjectVel: Vector3 = self:GetSubjectVelocity()
	local subjectRotVel = self:GetSubjectRotVelocity()

	-- measure the local-to-world-space forward velocity of the vehicle
	local vDotZ = math.abs(subjectVel:Dot(subjectCFrame.ZVector))
	local yawVel = yawVelocity(subjectRotVel, subjectCFrame)
	local pitchVel = pitchVelocity(subjectRotVel, subjectCFrame)

	-- step camera components forward
	local zoom = self:StepZoom()

	-- mix third and first person offsets in local space
	local firstPerson = mapClamp(zoom, ZOOM_MINIMUM, self.assemblyRadius, 1, 0)

	local tpOffset = self:_GetThirdPersonLocalOffset()
	local fpOffset = self:_GetFirstPersonLocalOffset(subjectCFrame)
	local localOffset = tpOffset:Lerp(fpOffset, firstPerson)

	-- step core forward
	vehicleCameraCore:setTransform(subjectCFrame)
	local processedRotation = vehicleCameraCore:step(dt, pitchVel, yawVel, firstPerson)

	-- end product of this function
	local focus = nil
	local cf = nil

	if not FFlagUserVRVehicleCamera then
		-- update fade from black
		self:UpdateFadeFromBlack(dt)
	end

	if not self:IsInFirstPerson() then
		-- third person comfort camera
		focus = CFrame.new(subjectCFrame * localOffset) * processedRotation
		cf = focus * CFrame.new(0, 0, zoom)

		if not self.lastCameraFocus then
			self.lastCameraFocus = focus
			self.needsReset = true
		end

		local curCameraDir = focus.Position - camera.CFrame.Position
		local curCameraDist = curCameraDir.magnitude
		curCameraDir = curCameraDir.Unit
		local cameraDot = curCameraDir:Dot(camera.CFrame.LookVector)
		if cameraDot > TP_FOLLOW_ANGLE_DOT and curCameraDist < TP_FOLLOW_DIST and not self.needsReset then -- vehicle in view
			-- keep old focus
			focus = self.lastCameraFocus

			-- new cf result
			local cameraFocusP = focus.p
			local cameraLookVector = self:GetCameraLookVector()
			cameraLookVector = Vector3.new(cameraLookVector.X, 0, cameraLookVector.Z).Unit
			local newLookVector = self:CalculateNewLookVectorFromArg(cameraLookVector, Vector2.new(0, 0))
			cf = CFrame.new(cameraFocusP - (zoom * newLookVector), cameraFocusP)
		else
			-- new focus / teleport
			self.lastCameraFocus = self:GetVRFocus(subjectCFrame.Position, dt)
			self.needsReset = false
			self:StartFadeFromBlack()
			self:ResetZoom()
		end

		if not FFlagUserVRVehicleCamera then
			self:UpdateEdgeBlur(localPlayer, dt)
		end

	else
		-- first person in vehicle : lock orientation for stable camera
		local dir = Vector3.new(processedRotation.LookVector.X, 0, processedRotation.LookVector.Z).Unit
		local planarRotation = CFrame.new(processedRotation.Position, dir)

		-- this removes the pitch to reduce motion sickness
		focus = CFrame.new(subjectCFrame * localOffset) * planarRotation
		cf = focus * CFrame.new(0, 0, zoom)

		if FFlagUserVRVehicleCamera then
			if subjectVel.Magnitude > 0.1 then
				self:StartVREdgeBlur(localPlayer)
			end
		else
				self:StartVREdgeBlur(localPlayer)
		end
	end

	return cf, focus
end

return VRVehicleCamera

end))
ModuleScript10.Name = "Poppercam"
ModuleScript10.Parent = ModuleScript5
table.insert(cors,sandbox(ModuleScript10,function()
--!nonstrict
--[[
	Poppercam - Occlusion module that brings the camera closer to the subject when objects are blocking the view.
--]]

local ZoomController =  require(script.Parent:WaitForChild("ZoomController"))

local TransformExtrapolator = {} do
	TransformExtrapolator.__index = TransformExtrapolator

	local CF_IDENTITY = CFrame.new()

	local function cframeToAxis(cframe: CFrame): Vector3
		local axis: Vector3, angle: number = cframe:ToAxisAngle()
		return axis*angle
	end

	local function axisToCFrame(axis: Vector3): CFrame
		local angle: number = axis.Magnitude
		if angle > 1e-5 then
			return CFrame.fromAxisAngle(axis, angle)
		end
		return CF_IDENTITY
	end

	local function extractRotation(cf: CFrame): CFrame
		local _, _, _, xx, yx, zx, xy, yy, zy, xz, yz, zz = cf:GetComponents()
		return CFrame.new(0, 0, 0, xx, yx, zx, xy, yy, zy, xz, yz, zz)
	end

	function TransformExtrapolator.new()
		return setmetatable({
			lastCFrame = nil,
		}, TransformExtrapolator)
	end

	function TransformExtrapolator:Step(dt: number, currentCFrame: CFrame)
		local lastCFrame = self.lastCFrame or currentCFrame
		self.lastCFrame = currentCFrame

		local currentPos = currentCFrame.Position
		local currentRot = extractRotation(currentCFrame)

		local lastPos = lastCFrame.p
		local lastRot = extractRotation(lastCFrame)

		-- Estimate velocities from the delta between now and the last frame
		-- This estimation can be a little noisy.
		local dp = (currentPos - lastPos)/dt
		local dr = cframeToAxis(currentRot*lastRot:inverse())/dt

		local function extrapolate(t)
			local p = dp*t + currentPos
			local r = axisToCFrame(dr*t)*currentRot
			return r + p
		end

		return {
			extrapolate = extrapolate,
			posVelocity = dp,
			rotVelocity = dr,
		}
	end

	function TransformExtrapolator:Reset()
		self.lastCFrame = nil
	end
end

--[[ The Module ]]--
local BaseOcclusion = require(script.Parent:WaitForChild("BaseOcclusion"))
local Poppercam = setmetatable({}, BaseOcclusion)
Poppercam.__index = Poppercam

function Poppercam.new()
	local self = setmetatable(BaseOcclusion.new(), Poppercam)
	self.focusExtrapolator = TransformExtrapolator.new()
	return self
end

function Poppercam:GetOcclusionMode()
	return Enum.DevCameraOcclusionMode.Zoom
end

function Poppercam:Enable(enable)
	self.focusExtrapolator:Reset()
end

function Poppercam:Update(renderDt, desiredCameraCFrame, desiredCameraFocus, cameraController)
	local rotatedFocus = CFrame.new(desiredCameraFocus.p, desiredCameraCFrame.p)*CFrame.new(
		0, 0, 0,
		-1, 0, 0,
		0, 1, 0,
		0, 0, -1
	)
	local extrapolation = self.focusExtrapolator:Step(renderDt, rotatedFocus)
	local zoom = ZoomController.Update(renderDt, rotatedFocus, extrapolation)
	return rotatedFocus*CFrame.new(0, 0, zoom), desiredCameraFocus
end

-- Called when character is added
function Poppercam:CharacterAdded(character, player)
end

-- Called when character is about to be removed
function Poppercam:CharacterRemoving(character, player)
end

function Poppercam:OnCameraSubjectChanged(newSubject)
end

return Poppercam

end))
ModuleScript11.Name = "CameraUI"
ModuleScript11.Parent = ModuleScript5
table.insert(cors,sandbox(ModuleScript11,function()
--!nonstrict
local StarterGui = game:GetService("StarterGui")

local initialized = false

local CameraUI: any = {}

do
	-- Instantaneously disable the toast or enable for opening later on. Used when switching camera modes.
	function CameraUI.setCameraModeToastEnabled(enabled: boolean)
		if not enabled and not initialized then
			return
		end

		if not initialized then
			initialized = true
		end
		
		if not enabled then
			CameraUI.setCameraModeToastOpen(false)
		end
	end

	function CameraUI.setCameraModeToastOpen(open: boolean)
		assert(initialized)

		if open then
			StarterGui:SetCore("SendNotification", {
				Title = "Camera Control Enabled",
				Text = "Right click to toggle",
				Duration = 3,
			})
		end
	end
end

return CameraUI

end))
ModuleScript12.Name = "VRCamera"
ModuleScript12.Parent = ModuleScript5
table.insert(cors,sandbox(ModuleScript12,function()
--!nonstrict
--[[
	VRCamera - Roblox VR camera control module
	2021 Roblox VR
--]]

--[[ Services ]]--

local FFlagUserVRAvatarGestures
do
	local success, result = pcall(function()
		return UserSettings():IsUserFeatureEnabled("UserVRAvatarGestures")
	end)
	FFlagUserVRAvatarGestures = success and result
end

local PlayersService = game:GetService("Players")
local VRService = game:GetService("VRService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")

-- Local private variables and constants
local CAMERA_BLACKOUT_TIME = 0.1
local FP_ZOOM = 0.5
local TORSO_FORWARD_OFFSET_RATIO = 1/8
local NECK_OFFSET = -0.7

-- requires
local CameraInput = require(script.Parent:WaitForChild("CameraInput"))
local Util = require(script.Parent:WaitForChild("CameraUtils"))

--[[ The Module ]]--
local VRBaseCamera = require(script.Parent:WaitForChild("VRBaseCamera"))
local VRCamera = setmetatable({}, VRBaseCamera)
VRCamera.__index = VRCamera

function VRCamera.new()
	local self = setmetatable(VRBaseCamera.new(), VRCamera)

	self.lastUpdate = tick()
	self.focusOffset = CFrame.new()
	self:Reset()

	if FFlagUserVRAvatarGestures then
		self.controlModule = require(PlayersService.LocalPlayer:WaitForChild("PlayerScripts").PlayerModule:WaitForChild("ControlModule"))
		self.savedAutoRotate = true 
	end

	return self
end

function VRCamera:Reset()
	self.needsReset = true
	self.needsBlackout = true
	self.motionDetTime = 0.0
	self.blackOutTimer = 0
	self.lastCameraResetPosition = nil
	VRBaseCamera.Reset(self)
end

function VRCamera:Update(timeDelta)
	local camera = workspace.CurrentCamera
	local newCameraCFrame = camera.CFrame
	local newCameraFocus = camera.Focus

	local player = PlayersService.LocalPlayer
	local humanoid = self:GetHumanoid()
	local cameraSubject = camera.CameraSubject

	if self.lastUpdate == nil or timeDelta > 1 then
		self.lastCameraTransform = nil
	end

	-- update fullscreen effects
	self:UpdateFadeFromBlack(timeDelta)
	self:UpdateEdgeBlur(player, timeDelta)

	local lastSubjPos = self.lastSubjectPosition
	local subjectPosition: Vector3 = self:GetSubjectPosition()
	-- transition from another camera or from spawn
	if self.needsBlackout then 
		self:StartFadeFromBlack()

		local dt = math.clamp(timeDelta, 0.0001, 0.1)
		self.blackOutTimer += dt
		if self.blackOutTimer > CAMERA_BLACKOUT_TIME and game:IsLoaded() then
			self.needsBlackout = false
			self.needsReset = true
		end
	end

	if subjectPosition and player and camera then
		newCameraFocus = self:GetVRFocus(subjectPosition, timeDelta)
		-- update camera cframe based on first/third person
		if self:IsInFirstPerson() then
			if FFlagUserVRAvatarGestures and VRService.AvatarGestures then
				-- the immersion camera better aligns the player with the avatar
				newCameraCFrame, newCameraFocus = self:UpdateImmersionCamera(
					timeDelta,newCameraCFrame, newCameraFocus, lastSubjPos, subjectPosition)
			else
				newCameraCFrame, newCameraFocus = self:UpdateFirstPersonTransform(
					timeDelta,newCameraCFrame, newCameraFocus, lastSubjPos, subjectPosition)
			end
		else -- 3rd person
			if VRService.ThirdPersonFollowCamEnabled then
				newCameraCFrame, newCameraFocus = self:UpdateThirdPersonFollowTransform(
					timeDelta, newCameraCFrame, newCameraFocus, lastSubjPos, subjectPosition)
			else
				newCameraCFrame, newCameraFocus = self:UpdateThirdPersonComfortTransform(
					timeDelta, newCameraCFrame, newCameraFocus, lastSubjPos, subjectPosition)
			end
		end

		self.lastCameraTransform = newCameraCFrame
		self.lastCameraFocus = newCameraFocus
	end

	self.lastUpdate = tick()
	return newCameraCFrame, newCameraFocus
end

-- returns where the floor should be placed given the camera subject, nil if anything is invalid
function VRCamera:GetAvatarFeetWorldYValue(): number?
	local camera = workspace.CurrentCamera
	local cameraSubject = camera.CameraSubject
	if not cameraSubject then
		return nil
	end

	if cameraSubject:IsA("Humanoid") and cameraSubject.RootPart then
		local rootPart = cameraSubject.RootPart
		return rootPart.Position.Y - rootPart.Size.Y / 2 - cameraSubject.HipHeight
	end

	return nil
end

function VRCamera:UpdateFirstPersonTransform(timeDelta, newCameraCFrame, newCameraFocus, lastSubjPos, subjectPosition)
	-- transition from TP to FP
	if self.needsReset then
		self:StartFadeFromBlack()
		self.needsReset = false
	end

	-- blur screen edge during movement
	local player = PlayersService.LocalPlayer
	local subjectDelta = lastSubjPos - subjectPosition
	if subjectDelta.magnitude > 0.01 then
		self:StartVREdgeBlur(player)
	end
	-- straight view, not angled down
	local cameraFocusP = newCameraFocus.p
	local cameraLookVector = self:GetCameraLookVector()
	cameraLookVector = Vector3.new(cameraLookVector.X, 0, cameraLookVector.Z).Unit

	local yawDelta = self:getRotation(timeDelta)

	local newLookVector = self:CalculateNewLookVectorFromArg(cameraLookVector, Vector2.new(yawDelta, 0))
	newCameraCFrame = CFrame.new(cameraFocusP - (FP_ZOOM * newLookVector), cameraFocusP)

	return newCameraCFrame, newCameraFocus
end

function VRCamera:UpdateImmersionCamera(timeDelta, newCameraCFrame, newCameraFocus, lastSubjPos, subjectPosition)
	local subjectCFrame = self:GetSubjectCFrame()
	local curCamera = workspace.CurrentCamera :: Camera

	-- character rotation details
	local character = PlayersService.LocalPlayer.Character
	local humanoid = self:GetHumanoid()
	if not humanoid then
		return curCamera.CFrame, curCamera.Focus
	end
	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
	if not humanoidRootPart then 
		return curCamera.CFrame, curCamera.Focus
	end
	self.characterOrientation = humanoidRootPart:FindFirstChild("CharacterAlignOrientation")
	if not self.characterOrientation then
		local rootAttachment = humanoidRootPart:FindFirstChild("RootAttachment")
		if not rootAttachment then
			return
		end
		self.characterOrientation= Instance.new("AlignOrientation")
		self.characterOrientation.Name = "CharacterAlignOrientation"
		self.characterOrientation.Mode = Enum.OrientationAlignmentMode.OneAttachment
		self.characterOrientation.Attachment0 = rootAttachment
		self.characterOrientation.RigidityEnabled = true
		self.characterOrientation.Parent = humanoidRootPart
	end
	if self.characterOrientation.Enabled == false then
		self.characterOrientation.Enabled = true
	end

	-- just entered first person, or need to reset camera
	if self.needsReset then
		self.needsReset = false
		
		self.savedAutoRotate = humanoid.AutoRotate
		humanoid.AutoRotate = false

		if self.NoRecenter then
			self.NoRecenter = false
			VRService:RecenterUserHeadCFrame()
		end
		
		self:StartFadeFromBlack()

		-- place the VR head at the subject's CFrame
		newCameraCFrame = subjectCFrame
	else
		-- keep character rotation with torso
		local torsoRotation = self.controlModule:GetEstimatedVRTorsoFrame()
		self.characterOrientation.CFrame = curCamera.CFrame * torsoRotation 

		-- The character continues moving for a brief moment after the moveVector stops. Continue updating the camera.
		if self.controlModule.inputMoveVector.Magnitude > 0 then
			self.motionDetTime = 0.1
		end

		if self.controlModule.inputMoveVector.Magnitude > 0 or self.motionDetTime > 0 then
			self.motionDetTime -= timeDelta

			-- Add an edge blur if the subject moved
			self:StartVREdgeBlur(PlayersService.LocalPlayer)
			
			-- moving by input, so we should align the vrHead with the character
			local vrHeadOffset = VRService:GetUserCFrame(Enum.UserCFrame.Head) 
			vrHeadOffset = vrHeadOffset.Rotation + vrHeadOffset.Position * curCamera.HeadScale
			
			-- the location of the character's body should be "below" the head. Directly below if the player is looking 
			-- forward, but further back if they are looking down
			local hrp = character.HumanoidRootPart
			local neck_offset = NECK_OFFSET * hrp.Size.Y / 2
			local neckWorld = curCamera.CFrame * vrHeadOffset * CFrame.new(0, neck_offset, 0)
			local hrpLook = hrp.CFrame.LookVector
			neckWorld -= Vector3.new(hrpLook.X, 0, hrpLook.Z).Unit * hrp.Size.Y * TORSO_FORWARD_OFFSET_RATIO
			
			-- the camera must remain stable relative to the humanoid root part or the IK calculations will look jittery
			local goalCameraPosition = subjectPosition - neckWorld.Position + curCamera.CFrame.Position

			-- maintain the Y value
			goalCameraPosition = Vector3.new(goalCameraPosition.X, subjectPosition.Y, goalCameraPosition.Z)
			
			newCameraCFrame = curCamera.CFrame.Rotation + goalCameraPosition
		else
			-- don't change x, z position, follow the y value
			newCameraCFrame = curCamera.CFrame.Rotation + Vector3.new(curCamera.CFrame.Position.X, subjectPosition.Y, curCamera.CFrame.Position.Z)
		end
		
		local yawDelta = self:getRotation(timeDelta)
		if math.abs(yawDelta) > 0 then
			-- The head location in world space
			local vrHeadOffset = VRService:GetUserCFrame(Enum.UserCFrame.Head) 
			vrHeadOffset = vrHeadOffset.Rotation + vrHeadOffset.Position * curCamera.HeadScale
			local VRheadWorld = newCameraCFrame * vrHeadOffset

			local desiredVRHeadCFrame = CFrame.new(VRheadWorld.Position) * CFrame.Angles(0, -math.rad(yawDelta * 90), 0) * VRheadWorld.Rotation

			-- set the camera to place the VR head at the correct location
			newCameraCFrame = desiredVRHeadCFrame * vrHeadOffset:Inverse()
		end
	end

	return newCameraCFrame, newCameraCFrame * CFrame.new(0, 0, -FP_ZOOM)
end

function VRCamera:UpdateThirdPersonComfortTransform(timeDelta, newCameraCFrame, newCameraFocus, lastSubjPos, subjectPosition)
	local zoom = self:GetCameraToSubjectDistance()
	if zoom < 0.5 then
		zoom = 0.5
	end

	if lastSubjPos ~= nil and self.lastCameraFocus ~= nil then
		-- compute delta of subject since last update
		local player = PlayersService.LocalPlayer
		local subjectDelta = lastSubjPos - subjectPosition
		local moveVector
		if FFlagUserVRAvatarGestures then
			self.controlModule:GetMoveVector()
		else
			moveVector = require(player:WaitForChild("PlayerScripts").PlayerModule:WaitForChild("ControlModule")):GetMoveVector()
		end

		-- is the subject still moving?
		local isMoving = subjectDelta.magnitude > 0.01 or moveVector.magnitude > 0.01
		if isMoving then
			self.motionDetTime = 0.1
		end

		self.motionDetTime = self.motionDetTime - timeDelta
		if self.motionDetTime > 0 then
			isMoving = true
		end

		if isMoving and not self.needsReset then
			-- if subject moves keep old camera focus
			newCameraFocus = self.lastCameraFocus

			-- if the focus subject stopped, time to reset the camera
			self.VRCameraFocusFrozen = true
		else
			local subjectMoved = self.lastCameraResetPosition == nil or (subjectPosition - self.lastCameraResetPosition).Magnitude > 1

			-- compute offset for 3rd person camera rotation
			local yawDelta = self:getRotation(timeDelta)
			if math.abs(yawDelta) > 0 then
				local cameraOffset = newCameraFocus:ToObjectSpace(newCameraCFrame)
				newCameraCFrame = newCameraFocus * CFrame.Angles(0, -yawDelta, 0) * cameraOffset
			end

			-- recenter the camera on teleport
			if (self.VRCameraFocusFrozen and subjectMoved) or self.needsReset then
				VRService:RecenterUserHeadCFrame()

				self.VRCameraFocusFrozen = false
				self.needsReset = false
				self.lastCameraResetPosition = subjectPosition

				self:ResetZoom()
				self:StartFadeFromBlack()

				-- get player facing direction
				local humanoid = self:GetHumanoid()
				local forwardVector = humanoid.Torso and humanoid.Torso.CFrame.lookVector or Vector3.new(1,0,0)
				-- adjust camera height
				local vecToCameraAtHeight = Vector3.new(forwardVector.X, 0, forwardVector.Z)
				local newCameraPos = newCameraFocus.Position - vecToCameraAtHeight * zoom
				-- compute new cframe at height level to subject
				local lookAtPos = Vector3.new(newCameraFocus.Position.X, newCameraPos.Y, newCameraFocus.Position.Z)

				newCameraCFrame = CFrame.new(newCameraPos, lookAtPos)
			end
		end
	end

	return newCameraCFrame, newCameraFocus
end

function VRCamera:UpdateThirdPersonFollowTransform(timeDelta, newCameraCFrame, newCameraFocus, lastSubjPos, subjectPosition)
	local camera = workspace.CurrentCamera :: Camera
	local zoom = self:GetCameraToSubjectDistance()
	local vrFocus = self:GetVRFocus(subjectPosition, timeDelta)

	if self.needsReset then

		self.needsReset = false

		VRService:RecenterUserHeadCFrame()
		self:ResetZoom()
		self:StartFadeFromBlack()
	end
	
	if self.recentered then
		local subjectCFrame = self:GetSubjectCFrame()
		if not subjectCFrame then -- can't perform a reset until the subject is valid
			return camera.CFrame, camera.Focus
		end
		
		-- set the camera and focus to zoom distance behind the subject
		newCameraCFrame = vrFocus * subjectCFrame.Rotation * CFrame.new(0, 0, zoom)

		self.focusOffset = vrFocus:ToObjectSpace(newCameraCFrame) -- GetVRFocus returns a CFrame with no rotation
		
		self.recentered = false
		return newCameraCFrame, vrFocus
	end

	local trackCameraCFrame = vrFocus:ToWorldSpace(self.focusOffset)
	
	-- figure out if the player is moving
	local player = PlayersService.LocalPlayer
	local subjectDelta = lastSubjPos - subjectPosition
	local controlModule
	if FFlagUserVRAvatarGestures then
		controlModule = self.controlModule
	else
		controlModule = require(player:WaitForChild("PlayerScripts").PlayerModule:WaitForChild("ControlModule"))
	end
	local moveVector = controlModule:GetMoveVector()

	-- while moving, slowly adjust camera so the avatar is in front of your head
	if subjectDelta.magnitude > 0.01 or moveVector.magnitude > 0 then -- is the subject moving?

		local headOffset = controlModule:GetEstimatedVRTorsoFrame()

		-- account for headscale
		headOffset = headOffset.Rotation + headOffset.Position * camera.HeadScale
		local headCframe = camera.CFrame * headOffset
		local headLook = headCframe.LookVector

		local headVectorDirection = Vector3.new(headLook.X, 0, headLook.Z).Unit * zoom
		local goalHeadPosition = vrFocus.Position - headVectorDirection
		
		-- place the camera at currentposition + difference between goalHead and currentHead 
		local moveGoalCameraCFrame = CFrame.new(camera.CFrame.Position + goalHeadPosition - headCframe.Position) * trackCameraCFrame.Rotation 

		newCameraCFrame = trackCameraCFrame:Lerp(moveGoalCameraCFrame, 0.01)
	else
		newCameraCFrame = trackCameraCFrame
	end

	-- compute offset for 3rd person camera rotation
	local yawDelta = self:getRotation(timeDelta)
	if math.abs(yawDelta) > 0 then
		local cameraOffset = vrFocus:ToObjectSpace(newCameraCFrame)
		newCameraCFrame = vrFocus * CFrame.Angles(0, -yawDelta, 0) * cameraOffset
	end

	self.focusOffset = vrFocus:ToObjectSpace(newCameraCFrame) -- GetVRFocus returns a CFrame with no rotation

	-- focus is always in front of the camera
	newCameraFocus = newCameraCFrame * CFrame.new(0, 0, -zoom)

	-- vignette
	if (newCameraFocus.Position - camera.Focus.Position).Magnitude > 0.01 then
		self:StartVREdgeBlur(PlayersService.LocalPlayer)
	end

	return newCameraCFrame, newCameraFocus
end

function VRCamera:LeaveFirstPerson()
	VRBaseCamera.LeaveFirstPerson(self)
	
	self.needsReset = true
	if self.VRBlur then
		self.VRBlur.Visible = false
	end

	if FFlagUserVRAvatarGestures then
		if self.characterOrientation then
			self.characterOrientation.Enabled = false

		end
		local humanoid = self:GetHumanoid()
		if humanoid then
			humanoid.AutoRotate = self.savedAutoRotate
		end
	end
end

return VRCamera
end))
ModuleScript13.Name = "CameraUtils"
ModuleScript13.Parent = ModuleScript5
table.insert(cors,sandbox(ModuleScript13,function()
--[[
	CameraUtils - Math utility functions shared by multiple camera scripts
	2018 Camera Update - AllYourBlox
--]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")

local CameraUtils = {}

local function round(num: number)
	return math.floor(num + 0.5)
end

-- Critically damped spring class for fluid motion effects
local Spring = {} do
	Spring.__index = Spring

	-- Initialize to a given undamped frequency and default position
	function Spring.new(freq, pos)
		return setmetatable({
			freq = freq,
			goal = pos,
			pos = pos,
			vel = 0,
		}, Spring)
	end

	-- Advance the spring simulation by `dt` seconds
	function Spring:step(dt: number)
		local f: number = self.freq::number * 2.0 * math.pi
		local g: Vector3 = self.goal
		local p0: Vector3 = self.pos
		local v0: Vector3 = self.vel

		local offset = p0 - g
		local decay = math.exp(-f*dt)

		local p1 = (offset*(1 + f*dt) + v0*dt)*decay + g
		local v1 = (v0*(1 - f*dt) - offset*(f*f*dt))*decay

		self.pos = p1
		self.vel = v1

		return p1
	end
end

CameraUtils.Spring = Spring

-- map a value from one range to another
function CameraUtils.map(x: number, inMin: number, inMax: number, outMin: number, outMax: number): number
	return (x - inMin)*(outMax - outMin)/(inMax - inMin) + outMin
end

-- maps a value from one range to another, clamping to the output range. order does not matter
function CameraUtils.mapClamp(x: number, inMin: number, inMax: number, outMin: number, outMax: number): number
	return math.clamp(
		(x - inMin)*(outMax - outMin)/(inMax - inMin) + outMin,
		math.min(outMin, outMax),
		math.max(outMin, outMax)
	)
end

-- Ritter's loose bounding sphere algorithm
function CameraUtils.getLooseBoundingSphere(parts: {BasePart})
	local points = table.create(#parts)
	for idx, part in pairs(parts) do
		points[idx] = part.Position
	end

	-- pick an arbitrary starting point
	local x = points[1]

	-- get y, the point furthest from x
	local y = x
	local yDist = 0

	for _, p in ipairs(points) do
		local pDist = (p - x).Magnitude

		if pDist > yDist then
			y = p
			yDist = pDist
		end
	end

	-- get z, the point furthest from y
	local z = y
	local zDist = 0

	for _, p in ipairs(points) do
		local pDist = (p - y).Magnitude

		if pDist > zDist then
			z = p
			zDist = pDist
		end
	end

	-- use (y, z) as the initial bounding sphere
	local sc = (y + z)*0.5
	local sr = (y - z).Magnitude*0.5

	-- expand sphere to fit any outlying points
	for _, p in ipairs(points) do
		local pDist = (p - sc).Magnitude

		if pDist > sr then
			-- shift to midpoint
			sc = sc + (pDist - sr)*0.5*(p - sc).Unit

			-- expand
			sr = (pDist + sr)*0.5
		end
	end

	return sc, sr
end

-- canonicalize an angle to +-180 degrees
function CameraUtils.sanitizeAngle(a: number): number
	return (a + math.pi)%(2*math.pi) - math.pi
end

-- From TransparencyController
function CameraUtils.Round(num: number, places: number): number
	local decimalPivot = 10^places
	return math.floor(num * decimalPivot + 0.5) / decimalPivot
end

function CameraUtils.IsFinite(val: number): boolean
	return val == val and val ~= math.huge and val ~= -math.huge
end

function CameraUtils.IsFiniteVector3(vec3: Vector3): boolean
	return CameraUtils.IsFinite(vec3.X) and CameraUtils.IsFinite(vec3.Y) and CameraUtils.IsFinite(vec3.Z)
end

-- Legacy implementation renamed
function CameraUtils.GetAngleBetweenXZVectors(v1: Vector3, v2: Vector3): number
	return math.atan2(v2.X*v1.Z-v2.Z*v1.X, v2.X*v1.X+v2.Z*v1.Z)
end

function CameraUtils.RotateVectorByAngleAndRound(camLook: Vector3, rotateAngle: number, roundAmount: number): number
	if camLook.Magnitude > 0 then
		camLook = camLook.Unit
		local currAngle = math.atan2(camLook.Z, camLook.X)
		local newAngle = round((math.atan2(camLook.Z, camLook.X) + rotateAngle) / roundAmount) * roundAmount
		return newAngle - currAngle
	end
	return 0
end

-- K is a tunable parameter that changes the shape of the S-curve
-- the larger K is the more straight/linear the curve gets
local k = 0.35
local lowerK = 0.8
local function SCurveTranform(t: number)
	t = math.clamp(t, -1, 1)
	if t >= 0 then
		return (k*t) / (k - t + 1)
	end
	return -((lowerK*-t) / (lowerK + t + 1))
end

local DEADZONE = 0.1
local function toSCurveSpace(t: number)
	return (1 + DEADZONE) * (2*math.abs(t) - 1) - DEADZONE
end

local function fromSCurveSpace(t: number)
	return t/2 + 0.5
end

function CameraUtils.GamepadLinearToCurve(thumbstickPosition: Vector2)
	local function onAxis(axisValue)
		local sign = 1
		if axisValue < 0 then
			sign = -1
		end
		local point = fromSCurveSpace(SCurveTranform(toSCurveSpace(math.abs(axisValue))))
		point = point * sign
		return math.clamp(point, -1, 1)
	end
	return Vector2.new(onAxis(thumbstickPosition.X), onAxis(thumbstickPosition.Y))
end

-- This function converts 4 different, redundant enumeration types to one standard so the values can be compared
function CameraUtils.ConvertCameraModeEnumToStandard(enumValue:
		Enum.TouchCameraMovementMode |
		Enum.ComputerCameraMovementMode |
		Enum.DevTouchCameraMovementMode |
		Enum.DevComputerCameraMovementMode): Enum.ComputerCameraMovementMode | Enum.DevComputerCameraMovementMode
	if enumValue == Enum.TouchCameraMovementMode.Default then
		return Enum.ComputerCameraMovementMode.Follow
	end

	if enumValue == Enum.ComputerCameraMovementMode.Default then
		return Enum.ComputerCameraMovementMode.Classic
	end

	if enumValue == Enum.TouchCameraMovementMode.Classic or
		enumValue == Enum.DevTouchCameraMovementMode.Classic or
		enumValue == Enum.DevComputerCameraMovementMode.Classic or
		enumValue == Enum.ComputerCameraMovementMode.Classic then
		return Enum.ComputerCameraMovementMode.Classic
	end

	if enumValue == Enum.TouchCameraMovementMode.Follow or
		enumValue == Enum.DevTouchCameraMovementMode.Follow or
		enumValue == Enum.DevComputerCameraMovementMode.Follow or
		enumValue == Enum.ComputerCameraMovementMode.Follow then
		return Enum.ComputerCameraMovementMode.Follow
	end

	if enumValue == Enum.TouchCameraMovementMode.Orbital or
		enumValue == Enum.DevTouchCameraMovementMode.Orbital or
		enumValue == Enum.DevComputerCameraMovementMode.Orbital or
		enumValue == Enum.ComputerCameraMovementMode.Orbital then
		return Enum.ComputerCameraMovementMode.Orbital
	end

	if enumValue == Enum.ComputerCameraMovementMode.CameraToggle or
		enumValue == Enum.DevComputerCameraMovementMode.CameraToggle then
		return Enum.ComputerCameraMovementMode.CameraToggle
	end

	-- Note: Only the Dev versions of the Enums have UserChoice as an option
	if enumValue == Enum.DevTouchCameraMovementMode.UserChoice or
		enumValue == Enum.DevComputerCameraMovementMode.UserChoice then
		return Enum.DevComputerCameraMovementMode.UserChoice
	end

	-- For any unmapped options return Classic camera
	return Enum.ComputerCameraMovementMode.Classic
end

local function getMouse()
	local localPlayer = Players.LocalPlayer
	if not localPlayer then
		Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
		localPlayer = Players.LocalPlayer
	end
	assert(localPlayer)
	return localPlayer:GetMouse()
end

local savedMouseIcon: string = ""
local lastMouseIconOverride: string? = nil
function CameraUtils.setMouseIconOverride(icon: string)
	local mouse = getMouse()
	-- Only save the icon if it was written by another script.
	if mouse.Icon ~= lastMouseIconOverride then
		savedMouseIcon = mouse.Icon
	end

	mouse.Icon = icon
	lastMouseIconOverride = icon
end

function CameraUtils.restoreMouseIcon()
	local mouse = getMouse()
	-- Only restore if it wasn't overwritten by another script.
	if mouse.Icon == lastMouseIconOverride then
		mouse.Icon = savedMouseIcon
	end
	lastMouseIconOverride = nil
end

local savedMouseBehavior: Enum.MouseBehavior = Enum.MouseBehavior.Default
local lastMouseBehaviorOverride: Enum.MouseBehavior? = nil
function CameraUtils.setMouseBehaviorOverride(value: Enum.MouseBehavior)
	if UserInputService.MouseBehavior ~= lastMouseBehaviorOverride then
		savedMouseBehavior = UserInputService.MouseBehavior
	end

	UserInputService.MouseBehavior = value
	lastMouseBehaviorOverride = value
end

function CameraUtils.restoreMouseBehavior()
	if UserInputService.MouseBehavior == lastMouseBehaviorOverride then
		UserInputService.MouseBehavior = savedMouseBehavior
	end
	lastMouseBehaviorOverride = nil
end

local savedRotationType: Enum.RotationType = Enum.RotationType.MovementRelative
local lastRotationTypeOverride: Enum.RotationType? = nil
function CameraUtils.setRotationTypeOverride(value: Enum.RotationType)
	if UserGameSettings.RotationType ~= lastRotationTypeOverride then
		savedRotationType = UserGameSettings.RotationType
	end

	UserGameSettings.RotationType = value
	lastRotationTypeOverride = value
end

function CameraUtils.restoreRotationType()
	if UserGameSettings.RotationType == lastRotationTypeOverride then
		UserGameSettings.RotationType = savedRotationType
	end
	lastRotationTypeOverride = nil
end

return CameraUtils


end))
ModuleScript14.Name = "CameraInput"
ModuleScript14.Parent = ModuleScript5
table.insert(cors,sandbox(ModuleScript14,function()
--!nonstrict
local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserGameSettings = UserSettings():GetService("UserGameSettings")
local VRService = game:GetService("VRService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer

local CAMERA_INPUT_PRIORITY = Enum.ContextActionPriority.Medium.Value
local MB_TAP_LENGTH = 0.3 -- (s) length of time for a short mouse button tap to be registered

local ROTATION_SPEED_KEYS = math.rad(120) -- (rad/s)
local ROTATION_SPEED_MOUSE = Vector2.new(1, 0.77)*math.rad(0.5) -- (rad/s)
local ROTATION_SPEED_POINTERACTION = Vector2.new(1, 0.77)*math.rad(7) -- (rad/s)
local ROTATION_SPEED_TOUCH = Vector2.new(1, 0.66)*math.rad(1) -- (rad/s)
local ROTATION_SPEED_GAMEPAD = Vector2.new(1, 0.77)*math.rad(4) -- (rad/s)

local ZOOM_SPEED_MOUSE = 1 -- (scaled studs/wheel click)
local ZOOM_SPEED_KEYS = 0.1 -- (studs/s)
local ZOOM_SPEED_TOUCH = 0.04 -- (scaled studs/DIP %)

local MIN_TOUCH_SENSITIVITY_FRACTION = 0.25 -- 25% sensitivity at 90°

local FFlagUserResetTouchStateOnMenuOpen
do
	local success, result = pcall(function()
		return UserSettings():IsUserFeatureEnabled("UserResetTouchStateOnMenuOpen")
	end)
	FFlagUserResetTouchStateOnMenuOpen = success and result
end

local FFlagUserClearPanOnCameraDisable
do
	local success, result = pcall(function()
		return UserSettings():IsUserFeatureEnabled("UserClearPanOnCameraDisable")
	end)
	FFlagUserClearPanOnCameraDisable = success and result
end

-- right mouse button up & down events
local rmbDown, rmbUp do
	local rmbDownBindable = Instance.new("BindableEvent")
	local rmbUpBindable = Instance.new("BindableEvent")

	rmbDown = rmbDownBindable.Event
	rmbUp = rmbUpBindable.Event

	UserInputService.InputBegan:Connect(function(input, gpe)
		if not gpe and input.UserInputType == Enum.UserInputType.MouseButton2 then
			rmbDownBindable:Fire()
		end
	end)

	UserInputService.InputEnded:Connect(function(input, gpe)
		if input.UserInputType == Enum.UserInputType.MouseButton2 then
			rmbUpBindable:Fire()
		end
	end)
end

local thumbstickCurve do
	local K_CURVATURE = 2 -- amount of upwards curvature (0 is flat)
	local K_DEADZONE = 0.1 -- deadzone

	function thumbstickCurve(x)
		-- remove sign, apply linear deadzone
		local fDeadzone = (math.abs(x) - K_DEADZONE)/(1 - K_DEADZONE)
		
		-- apply exponential curve and scale to fit in [0, 1]
		local fCurve = (math.exp(K_CURVATURE*fDeadzone) - 1)/(math.exp(K_CURVATURE) - 1)
		
		-- reapply sign and clamp
		return math.sign(x)*math.clamp(fCurve, 0, 1)
	end
end

-- Adjust the touch sensitivity so that sensitivity is reduced when swiping up
-- or down, but stays the same when swiping towards the middle of the screen
local function adjustTouchPitchSensitivity(delta: Vector2): Vector2
	local camera = workspace.CurrentCamera

	if not camera then
		return delta
	end
	
	-- get the camera pitch in world space
	local pitch = camera.CFrame:ToEulerAnglesYXZ()
	
	if delta.Y*pitch >= 0 then
		-- do not reduce sensitivity when pitching towards the horizon
		return delta
	end
	
	-- set up a line to fit:
	-- 1 = f(0)
	-- 0 = f(±pi/2)
	local curveY = 1 - (2*math.abs(pitch)/math.pi)^0.75

	-- remap curveY from [0, 1] -> [MIN_TOUCH_SENSITIVITY_FRACTION, 1]
	local sensitivity = curveY*(1 - MIN_TOUCH_SENSITIVITY_FRACTION) + MIN_TOUCH_SENSITIVITY_FRACTION

	return Vector2.new(1, sensitivity)*delta
end

local function isInDynamicThumbstickArea(pos: Vector3): boolean
	local playerGui = player:FindFirstChildOfClass("PlayerGui")
	local touchGui = playerGui and playerGui:FindFirstChild("TouchGui")
	local touchFrame = touchGui and touchGui:FindFirstChild("TouchControlFrame")
	local thumbstickFrame = touchFrame and touchFrame:FindFirstChild("DynamicThumbstickFrame")

	if not thumbstickFrame then
		return false
	end
	
	if not touchGui.Enabled then
		return false
	end

	local posTopLeft = thumbstickFrame.AbsolutePosition
	local posBottomRight = posTopLeft + thumbstickFrame.AbsoluteSize

	return
		pos.X >= posTopLeft.X and
		pos.Y >= posTopLeft.Y and
		pos.X <= posBottomRight.X and
		pos.Y <= posBottomRight.Y
end

local worldDt = 1/60
RunService.Stepped:Connect(function(_, _worldDt)
	worldDt = _worldDt
end)

local CameraInput = {}

do
	local connectionList = {}
	local panInputCount = 0

	local function incPanInputCount()
		panInputCount = math.max(0, panInputCount + 1)
	end

	local function decPanInputCount()
		panInputCount = math.max(0, panInputCount - 1)
	end

	local function resetPanInputCount()
		panInputCount = 0
	end

	local touchPitchSensitivity = 1
	local gamepadState = {
		Thumbstick2 = Vector2.new(),
	}
	local keyboardState = {
		Left = 0,
		Right = 0,
		I = 0,
		O = 0
	}
	local mouseState = {
		Movement = Vector2.new(),
		Wheel = 0, -- PointerAction
		Pan = Vector2.new(), -- PointerAction
		Pinch = 0, -- PointerAction
	}
	local touchState = {
		Move = Vector2.new(),
		Pinch = 0,
	}
	
	local gamepadZoomPressBindable = Instance.new("BindableEvent")
	CameraInput.gamepadZoomPress = gamepadZoomPressBindable.Event

	local gamepadResetBindable = VRService.VREnabled and Instance.new("BindableEvent") or nil
	if VRService.VREnabled then
		CameraInput.gamepadReset = gamepadResetBindable.Event
	end
	
	function CameraInput.getRotationActivated(): boolean
		return panInputCount > 0 or gamepadState.Thumbstick2.Magnitude > 0
	end
	
	function CameraInput.getRotation(disableKeyboardRotation: boolean?): Vector2
		local inversionVector = Vector2.new(1, UserGameSettings:GetCameraYInvertValue())

		-- keyboard input is non-coalesced, so must account for time delta
		local kKeyboard = Vector2.new(keyboardState.Right - keyboardState.Left, 0)*worldDt
		local kGamepad = gamepadState.Thumbstick2
		local kMouse = mouseState.Movement
		local kPointerAction = mouseState.Pan
		local kTouch = adjustTouchPitchSensitivity(touchState.Move)

		if disableKeyboardRotation then
			kKeyboard = Vector2.new()
		end

		local result =
			kKeyboard*ROTATION_SPEED_KEYS +
			kGamepad*ROTATION_SPEED_GAMEPAD +
			kMouse*ROTATION_SPEED_MOUSE +
			kPointerAction*ROTATION_SPEED_POINTERACTION +
			kTouch*ROTATION_SPEED_TOUCH

		return result*inversionVector
	end
	
	function CameraInput.getZoomDelta(): number
		local kKeyboard = keyboardState.O - keyboardState.I
		local kMouse = -mouseState.Wheel + mouseState.Pinch
		local kTouch = -touchState.Pinch
		return kKeyboard*ZOOM_SPEED_KEYS + kMouse*ZOOM_SPEED_MOUSE + kTouch*ZOOM_SPEED_TOUCH
	end

	do
		local function thumbstick(action, state, input)
			local position = input.Position
			gamepadState[input.KeyCode.Name] = Vector2.new(thumbstickCurve(position.X), -thumbstickCurve(position.Y))
			return Enum.ContextActionResult.Pass
		end

		local function mouseMovement(input)
			local delta = input.Delta
			mouseState.Movement = Vector2.new(delta.X, delta.Y)
		end
		
		local function mouseWheel(action, state, input)
			mouseState.Wheel = input.Position.Z
			return Enum.ContextActionResult.Pass
		end
		
		local function keypress(action, state, input)
			keyboardState[input.KeyCode.Name] = state == Enum.UserInputState.Begin and 1 or 0
		end
		
		local function gamepadZoomPress(action, state, input)
			if state == Enum.UserInputState.Begin then
				gamepadZoomPressBindable:Fire()
			end
		end

		local function gamepadReset(action, state, input)
			if state == Enum.UserInputState.Begin then
				gamepadResetBindable:Fire()
			end
		end
		
		local function resetInputDevices()
			for _, device in pairs({
				gamepadState,
				keyboardState,
				mouseState,
				touchState,
			}) do
				for k, v in pairs(device) do
					if type(v) == "boolean" then
						device[k] = false
					else
						device[k] *= 0 -- Mul by zero to preserve vector types
					end
				end
			end
			
			if FFlagUserClearPanOnCameraDisable then
				resetPanInputCount()
			end
		end

		local touchBegan, touchChanged, touchEnded, resetTouchState do
			-- Use TouchPan & TouchPinch when they work in the Studio emulator

			local touches: {[InputObject]: boolean?} = {} -- {[InputObject] = sunk}
			local dynamicThumbstickInput: InputObject? -- Special-cased 
			local lastPinchDiameter: number?

			function touchBegan(input: InputObject, sunk: boolean)
				assert(input.UserInputType == Enum.UserInputType.Touch)
				assert(input.UserInputState == Enum.UserInputState.Begin)
				
				if dynamicThumbstickInput == nil and isInDynamicThumbstickArea(input.Position) and not sunk then
					-- any finger down starting in the dynamic thumbstick area should always be
					-- ignored for camera purposes. these must be handled specially from all other
					-- inputs, as the DT does not sink inputs by itself
					dynamicThumbstickInput = input
					return
				end
				
				if not sunk then
					incPanInputCount()
				end
				
				-- register the finger
				touches[input] = sunk
			end

			function touchEnded(input: InputObject, sunk: boolean)
				assert(input.UserInputType == Enum.UserInputType.Touch)
				assert(input.UserInputState == Enum.UserInputState.End)
				
				-- reset the DT input
				if input == dynamicThumbstickInput then
					dynamicThumbstickInput = nil
				end
				
				-- reset pinch state if one unsunk finger lifts
				if touches[input] == false then
					lastPinchDiameter = nil
					decPanInputCount()
				end
				
				-- unregister input
				touches[input] = nil
			end

			function touchChanged(input, sunk)
				assert(input.UserInputType == Enum.UserInputType.Touch)
				assert(input.UserInputState == Enum.UserInputState.Change)
				
				-- ignore movement from the DT finger
				if input == dynamicThumbstickInput then
					return
				end
				
				-- fixup unknown touches
				if touches[input] == nil then
					touches[input] = sunk
				end
				
				-- collect unsunk touches
				local unsunkTouches = {}
				for touch, sunk in pairs(touches) do
					if not sunk then
						table.insert(unsunkTouches, touch)
					end
				end
				
				-- 1 finger: pan
				if #unsunkTouches == 1 then
					if touches[input] == false then
						local delta = input.Delta
						touchState.Move += Vector2.new(delta.X, delta.Y) -- total touch pan movement (reset at end of frame)
					end
				end
				
				-- 2 fingers: pinch
				if #unsunkTouches == 2 then
					local pinchDiameter = (unsunkTouches[1].Position - unsunkTouches[2].Position).Magnitude
					
					if lastPinchDiameter then
						touchState.Pinch += pinchDiameter - lastPinchDiameter
					end
					
					lastPinchDiameter = pinchDiameter
				else
					lastPinchDiameter = nil
				end
			end

			function resetTouchState()
				touches = {}
				dynamicThumbstickInput = nil
				lastPinchDiameter = nil
				if FFlagUserResetTouchStateOnMenuOpen then
					resetPanInputCount()
				end
			end
		end

		local function pointerAction(wheel, pan, pinch, gpe)
			if not gpe then
				mouseState.Wheel = wheel
				mouseState.Pan = pan
				mouseState.Pinch = -pinch
			end
		end

		local function inputBegan(input, sunk)
			if input.UserInputType == Enum.UserInputType.Touch then
				touchBegan(input, sunk)

			elseif input.UserInputType == Enum.UserInputType.MouseButton2 and not sunk then
				incPanInputCount()
			end
		end

		local function inputChanged(input, sunk)
			if input.UserInputType == Enum.UserInputType.Touch then
				touchChanged(input, sunk)

			elseif input.UserInputType == Enum.UserInputType.MouseMovement then
				mouseMovement(input)
			end
		end

		local function inputEnded(input, sunk)
			if input.UserInputType == Enum.UserInputType.Touch then
				touchEnded(input, sunk)

			elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
				decPanInputCount()
			end
		end

		local inputEnabled = false

		function CameraInput.setInputEnabled(_inputEnabled)
			if inputEnabled == _inputEnabled then
				return
			end
			inputEnabled = _inputEnabled

			resetInputDevices()
			resetTouchState()

			if inputEnabled then -- enable
				ContextActionService:BindActionAtPriority(
					"RbxCameraThumbstick",
					thumbstick,
					false,
					CAMERA_INPUT_PRIORITY,
					Enum.KeyCode.Thumbstick2
				)

				ContextActionService:BindActionAtPriority(
					"RbxCameraKeypress",
					keypress,
					false,
					CAMERA_INPUT_PRIORITY,
					Enum.KeyCode.Left,
					Enum.KeyCode.Right,
					Enum.KeyCode.I,
					Enum.KeyCode.O
				)

				if VRService.VREnabled then
					ContextActionService:BindAction(
						"RbxCameraGamepadReset",
						gamepadReset,
						false,
						Enum.KeyCode.ButtonL3
					)
				end
				
				ContextActionService:BindAction(
					"RbxCameraGamepadZoom",
					gamepadZoomPress,
					false,
					Enum.KeyCode.ButtonR3
				)
				
				table.insert(connectionList, UserInputService.InputBegan:Connect(inputBegan))
				table.insert(connectionList, UserInputService.InputChanged:Connect(inputChanged))
				table.insert(connectionList, UserInputService.InputEnded:Connect(inputEnded))
				table.insert(connectionList, UserInputService.PointerAction:Connect(pointerAction))
				if FFlagUserResetTouchStateOnMenuOpen then
					local GuiService = game:GetService("GuiService")
					table.insert(connectionList, GuiService.MenuOpened:connect(resetTouchState))
				end

			else -- disable
				ContextActionService:UnbindAction("RbxCameraThumbstick")
				ContextActionService:UnbindAction("RbxCameraMouseMove")
				ContextActionService:UnbindAction("RbxCameraMouseWheel")
				ContextActionService:UnbindAction("RbxCameraKeypress")

				ContextActionService:UnbindAction("RbxCameraGamepadZoom")
				if VRService.VREnabled then
					ContextActionService:UnbindAction("RbxCameraGamepadReset")
				end 

				for _, conn in pairs(connectionList) do
					conn:Disconnect()
				end
				connectionList = {}
			end
		end

		function CameraInput.getInputEnabled()
			return inputEnabled
		end
		
		function CameraInput.resetInputForFrameEnd()
			mouseState.Movement = Vector2.new()
			touchState.Move = Vector2.new()
			touchState.Pinch = 0

			mouseState.Wheel = 0 -- PointerAction
			mouseState.Pan = Vector2.new() -- PointerAction
			mouseState.Pinch = 0 -- PointerAction
		end

		UserInputService.WindowFocused:Connect(resetInputDevices)
		UserInputService.WindowFocusReleased:Connect(resetInputDevices)
	end
end

-- Toggle pan
do
	local holdPan = false
	local togglePan = false
	local lastRmbDown = 0 -- tick() timestamp of the last right mouse button down event
	
	function CameraInput.getHoldPan(): boolean
		return holdPan
	end
	
	function CameraInput.getTogglePan(): boolean
		return togglePan
	end
	
	function CameraInput.getPanning(): boolean
		return togglePan or holdPan
	end
	
	function CameraInput.setTogglePan(value: boolean)
		togglePan = value
	end
	
	local cameraToggleInputEnabled = false
	local rmbDownConnection
	local rmbUpConnection
	
	function CameraInput.enableCameraToggleInput()
		if cameraToggleInputEnabled then
			return
		end
		cameraToggleInputEnabled = true
	
		holdPan = false
		togglePan = false
	
		if rmbDownConnection then
			rmbDownConnection:Disconnect()
		end
	
		if rmbUpConnection then
			rmbUpConnection:Disconnect()
		end
	
		rmbDownConnection = rmbDown:Connect(function()
			holdPan = true
			lastRmbDown = tick()
		end)
	
		rmbUpConnection = rmbUp:Connect(function()
			holdPan = false
			if tick() - lastRmbDown < MB_TAP_LENGTH and (togglePan or UserInputService:GetMouseDelta().Magnitude < 2) then
				togglePan = not togglePan
			end
		end)
	end
	
	function CameraInput.disableCameraToggleInput()
		if not cameraToggleInputEnabled then
			return
		end
		cameraToggleInputEnabled = false
	
		if rmbDownConnection then
			rmbDownConnection:Disconnect()
			rmbDownConnection = nil
		end
		
		if rmbUpConnection then
			rmbUpConnection:Disconnect()
			rmbUpConnection = nil
		end
	end
end

return CameraInput
end))
ModuleScript15.Name = "VehicleCamera"
ModuleScript15.Parent = ModuleScript5
table.insert(cors,sandbox(ModuleScript15,function()
	--!nonstrict

	local MIN_ASSEMBLY_RADIUS = 5
	local EPSILON = 1e-3
	local PITCH_LIMIT = math.rad(80)
	local YAW_DEFAULT = math.rad(0)
	local ZOOM_MINIMUM = 0.5
	local ZOOM_SENSITIVITY_CURVATURE = 0.5
	-- zoom levels cycles when pressing R3 on a gamepad,
	-- assume an assembly radius of 10
	local DEFAULT_GAMEPAD_ZOOM_LEVELS = {0, 15, 30}

	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")

	local BaseCamera = require(script.Parent:WaitForChild("BaseCamera"))
	local CameraInput = require(script.Parent:WaitForChild("CameraInput"))
	local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"))
	local ZoomController = require(script.Parent:WaitForChild("ZoomController"))
	local VehicleCameraCore = require(script:WaitForChild("VehicleCameraCore"))
	local VehicleCameraConfig = require(script:WaitForChild("VehicleCameraConfig"))

	local localPlayer = Players.LocalPlayer

	local map = CameraUtils.map
	local Spring = CameraUtils.Spring
	local mapClamp = CameraUtils.mapClamp
	local sanitizeAngle = CameraUtils.sanitizeAngle

	-- pitch-axis rotational velocity of a part with a given CFrame and total RotVelocity
	local function pitchVelocity(rotVel, cf)
		return math.abs(cf.XVector:Dot(rotVel))
	end

	-- yaw-axis rotational velocity of a part with a given CFrame and total RotVelocity
	local function yawVelocity(rotVel, cf)
		return math.abs(cf.YVector:Dot(rotVel))
	end

	-- track physics solver time delta separately from the render loop to correctly synchronize time delta
	local worldDt = 1/60
	RunService.Stepped:Connect(function(_, _worldDt)
		worldDt = _worldDt
	end)

	local VehicleCamera = setmetatable({}, BaseCamera)
	VehicleCamera.__index = VehicleCamera

	function VehicleCamera.new()
		local self = setmetatable(BaseCamera.new(), VehicleCamera)
		self:Reset()
		return self
	end

	function VehicleCamera:Reset()
		self.vehicleCameraCore = VehicleCameraCore.new(self:GetSubjectCFrame())
		self.pitchSpring = Spring.new(0, -math.rad(VehicleCameraConfig.pitchBaseAngle))
		self.yawSpring = Spring.new(0, YAW_DEFAULT)
		self.lastPanTick = 0

		local camera = workspace.CurrentCamera
		local cameraSubject = camera and camera.CameraSubject

		assert(camera)
		assert(cameraSubject)
		assert(cameraSubject:IsA("VehicleSeat"))

		local assemblyParts = cameraSubject:GetConnectedParts(true) -- passing true to recursively get all assembly parts
		local assemblyPosition, assemblyRadius = CameraUtils.getLooseBoundingSphere(assemblyParts)

		-- assembly radius is limited to 5 in case of extremely small radii causing zoom to be extremely close
		assemblyRadius = math.max(assemblyRadius, MIN_ASSEMBLY_RADIUS)

		self.assemblyRadius = assemblyRadius
		self.assemblyOffset = cameraSubject.CFrame:Inverse()*assemblyPosition -- seat-space offset of the assembly bounding sphere center

		-- scale zoom levels by car radius and headscale
		self.gamepadZoomLevels = {}
		for i, zoom in DEFAULT_GAMEPAD_ZOOM_LEVELS do
			table.insert(self.gamepadZoomLevels, zoom * self.assemblyRadius / 10)
		end
		self:SetCameraToSubjectDistance(self.gamepadZoomLevels[#self.gamepadZoomLevels])
	end

	function VehicleCamera:_StepRotation(dt, vdotz): CFrame
		local yawSpring = self.yawSpring
		local pitchSpring = self.pitchSpring

		local rotationInput = CameraInput.getRotation(true)
		local dYaw = -rotationInput.X
		local dPitch = -rotationInput.Y

		yawSpring.pos = sanitizeAngle(yawSpring.pos + dYaw)
		pitchSpring.pos = sanitizeAngle(math.clamp(pitchSpring.pos + dPitch, -PITCH_LIMIT, PITCH_LIMIT))

		if CameraInput.getRotationActivated() then
			self.lastPanTick = os.clock()
		end

		local pitchBaseAngle = -math.rad(VehicleCameraConfig.pitchBaseAngle)
		local pitchDeadzoneAngle = math.rad(VehicleCameraConfig.pitchDeadzoneAngle)

		if os.clock() - self.lastPanTick > VehicleCameraConfig.autocorrectDelay then
			-- adjust autocorrect response based on forward velocity
			local autocorrectResponse = mapClamp(
				vdotz,
				VehicleCameraConfig.autocorrectMinCarSpeed,
				VehicleCameraConfig.autocorrectMaxCarSpeed,
				0,
				VehicleCameraConfig.autocorrectResponse
			)

			yawSpring.freq = autocorrectResponse
			pitchSpring.freq = autocorrectResponse

			-- zero out response under a threshold
			if yawSpring.freq < EPSILON then
				yawSpring.vel = 0
			end

			if pitchSpring.freq < EPSILON then
				pitchSpring.vel = 0
			end

			if math.abs(sanitizeAngle(pitchBaseAngle - pitchSpring.pos)) <= pitchDeadzoneAngle then
				-- do nothing within the deadzone
				pitchSpring.goal = pitchSpring.pos
			else
				pitchSpring.goal = pitchBaseAngle
			end
		else
			yawSpring.freq = 0
			yawSpring.vel = 0

			pitchSpring.freq = 0
			pitchSpring.vel = 0

			pitchSpring.goal = pitchBaseAngle
		end

		return CFrame.fromEulerAnglesYXZ(
			pitchSpring:step(dt),
			yawSpring:step(dt),
			0
		)
	end

	function VehicleCamera:_GetThirdPersonLocalOffset()
		return self.assemblyOffset + Vector3.new(0, self.assemblyRadius*VehicleCameraConfig.verticalCenterOffset, 0)
	end

	function VehicleCamera:_GetFirstPersonLocalOffset(subjectCFrame: CFrame)
		local character = localPlayer.Character

		if character and character.Parent then
			local head = character:FindFirstChild("Head")

			if head and head:IsA("BasePart") then
				return subjectCFrame:Inverse()*head.Position
			end
		end

		return self:_GetThirdPersonLocalOffset()
	end

	function VehicleCamera:Update()
		local camera = workspace.CurrentCamera
		local cameraSubject = camera and camera.CameraSubject
		local vehicleCameraCore = self.vehicleCameraCore

		assert(camera)
		assert(cameraSubject)
		assert(cameraSubject:IsA("VehicleSeat"))

		-- consume the physics solver time delta to account for mismatched physics/render cycles
		local dt = worldDt
		worldDt = 0

		-- get subject info
		local subjectCFrame: CFrame = self:GetSubjectCFrame()
		local subjectVel: Vector3 = self:GetSubjectVelocity()
		local subjectRotVel = self:GetSubjectRotVelocity()

		-- measure the local-to-world-space forward velocity of the vehicle
		local vDotZ = math.abs(subjectVel:Dot(subjectCFrame.ZVector))
		local yawVel = yawVelocity(subjectRotVel, subjectCFrame)
		local pitchVel = pitchVelocity(subjectRotVel, subjectCFrame)

		-- step camera components forward
		local zoom = self:StepZoom()
		local objectRotation = self:_StepRotation(dt, vDotZ)

		-- mix third and first person offsets in local space
		local firstPerson = mapClamp(zoom, ZOOM_MINIMUM, self.assemblyRadius, 1, 0)

		local tpOffset = self:_GetThirdPersonLocalOffset()
		local fpOffset = self:_GetFirstPersonLocalOffset(subjectCFrame)
		local localOffset = tpOffset:Lerp(fpOffset, firstPerson)

		-- step core forward
		vehicleCameraCore:setTransform(subjectCFrame)
		local processedRotation = vehicleCameraCore:step(dt, pitchVel, yawVel, firstPerson)

		-- calculate final focus & cframe
		local focus = CFrame.new(subjectCFrame*localOffset)*processedRotation*objectRotation
		local cf = focus*CFrame.new(0, 0, zoom)

		return cf, focus
	end

	function VehicleCamera:ApplyVRTransform()
		-- no-op override; VR transform is not applied in vehicles
	end

	return VehicleCamera

end))
ModuleScript16.Name = "VehicleCameraCore"
ModuleScript16.Parent = ModuleScript15
table.insert(cors,sandbox(ModuleScript16,function()
	--!nonstrict
	local CameraUtils = require(script.Parent.Parent.CameraUtils)
	local VehicleCameraConfig = require(script.Parent.VehicleCameraConfig)

	local map = CameraUtils.map
	local mapClamp = CameraUtils.mapClamp
	local sanitizeAngle = CameraUtils.sanitizeAngle

	-- extract sanitized yaw from a CFrame rotation
	local function getYaw(cf)
		local _, yaw = cf:toEulerAnglesYXZ()
		return sanitizeAngle(yaw)
	end

	-- extract sanitized pitch from a CFrame rotation
	local function getPitch(cf)
		local pitch = cf:toEulerAnglesYXZ()
		return sanitizeAngle(pitch)
	end

	-- step a damped angular spring axis
	local function stepSpringAxis(dt, f, g, p, v)
		local offset = sanitizeAngle(p - g)
		local decay = math.exp(-f*dt)

		local p1 = sanitizeAngle((offset*(1 + f*dt) + v*dt)*decay + g)
		local v1 = (v*(1 - f*dt) - offset*(f*f*dt))*decay

		return p1, v1
	end

	-- value damper with separate response frequencies for rising and falling values
	local VariableEdgeSpring = {} do
		VariableEdgeSpring.__index = VariableEdgeSpring

		function VariableEdgeSpring.new(fRising, fFalling, position)
			return setmetatable({
				fRising = fRising,
				fFalling = fFalling,
				g = position,
				p = position,
				v = position*0,
			}, VariableEdgeSpring)
		end

		function VariableEdgeSpring:step(dt)
			local fRising = self.fRising
			local fFalling = self.fFalling
			local g = self.g
			local p0 = self.p
			local v0 = self.v

			local f = 2*math.pi*(v0 > 0 and fRising or fFalling)

			local offset = p0 - g
			local decay = math.exp(-f*dt)

			local p1 = (offset*(1 + f*dt) + v0*dt)*decay + g
			local v1 = (v0*(1 - f*dt) - offset*(f*f*dt))*decay

			self.p = p1
			self.v = v1

			return p1
		end
	end

	-- damps a 3D rotation in Tait-Bryan YXZ space, filtering out Z
	local YawPitchSpring = {} do
		YawPitchSpring.__index = YawPitchSpring

		function YawPitchSpring.new(cf)
			assert(typeof(cf) == "CFrame")

			return setmetatable({
				yawG = getYaw(cf), -- yaw goal
				yawP = getYaw(cf), -- yaw position
				yawV = 0, -- yaw velocity

				pitchG = getPitch(cf), -- pitch goal
				pitchP = getPitch(cf), -- pitch position
				pitchV = 0, -- pitch velocity

				-- yaw/pitch response springs
				fSpringYaw = VariableEdgeSpring.new(
					VehicleCameraConfig.yawReponseDampingRising,
					VehicleCameraConfig.yawResponseDampingFalling,
					0
				),
				fSpringPitch = VariableEdgeSpring.new(
					VehicleCameraConfig.pitchReponseDampingRising,
					VehicleCameraConfig.pitchResponseDampingFalling,
					0
				),
			}, YawPitchSpring)
		end

		-- Extract Tait-Bryan angles from a CFrame rotation
		function YawPitchSpring:setGoal(goalCFrame)
			assert(typeof(goalCFrame) == "CFrame")

			self.yawG = getYaw(goalCFrame)
			self.pitchG = getPitch(goalCFrame)
		end

		function YawPitchSpring:getCFrame()
			return CFrame.fromEulerAnglesYXZ(self.pitchP, self.yawP, 0)
		end

		function YawPitchSpring:step(dt, pitchVel, yawVel, firstPerson)
			assert(typeof(dt) == "number")
			assert(typeof(yawVel) == "number")
			assert(typeof(pitchVel) == "number")
			assert(typeof(firstPerson) == "number")

			local fSpringYaw = self.fSpringYaw
			local fSpringPitch = self.fSpringPitch

			-- calculate the frequency spring
			fSpringYaw.g = mapClamp(
				map(firstPerson, 0, 1, yawVel, 0),
				math.rad(VehicleCameraConfig.cutoffMinAngularVelYaw),
				math.rad(VehicleCameraConfig.cutoffMaxAngularVelYaw),
				1, 0
			)

			fSpringPitch.g = mapClamp(
				map(firstPerson, 0, 1, pitchVel, 0),
				math.rad(VehicleCameraConfig.cutoffMinAngularVelPitch),
				math.rad(VehicleCameraConfig.cutoffMaxAngularVelPitch),
				1, 0
			)

			-- calculate final frequencies
			local fYaw = 2*math.pi*VehicleCameraConfig.yawStiffness*fSpringYaw:step(dt)
			local fPitch = 2*math.pi*VehicleCameraConfig.pitchStiffness*fSpringPitch:step(dt)

			-- adjust response for first person
			fPitch *= map(firstPerson, 0, 1, 1, VehicleCameraConfig.firstPersonResponseMul)
			fYaw *= map(firstPerson, 0, 1, 1, VehicleCameraConfig.firstPersonResponseMul)

			-- step yaw
			self.yawP, self.yawV = stepSpringAxis(
				dt,
				fYaw,
				self.yawG,
				self.yawP,
				self.yawV
			)

			-- step pitch
			self.pitchP, self.pitchV = stepSpringAxis(
				dt,
				fPitch,
				self.pitchG,
				self.pitchP,
				self.pitchV
			)

			return self:getCFrame()
		end
	end

	local VehicleCameraCore = {} do
		VehicleCameraCore.__index = VehicleCameraCore

		function VehicleCameraCore.new(transform)
			return setmetatable({
				vrs = YawPitchSpring.new(transform)
			}, VehicleCameraCore)
		end

		function VehicleCameraCore:step(dt, pitchVel, yawVel, firstPerson)
			return self.vrs:step(dt, pitchVel, yawVel, firstPerson)
		end

		function VehicleCameraCore:setTransform(transform)
			self.vrs:setGoal(transform)
		end
	end

	return VehicleCameraCore

end))
ModuleScript17.Name = "VehicleCameraConfig"
ModuleScript17.Parent = ModuleScript15
table.insert(cors,sandbox(ModuleScript17,function()
	local VEHICLE_CAMERA_CONFIG = {
		-- (hz) Camera response stiffness along the pitch axis
		pitchStiffness = 0.5,

		-- (hz) Camera response stiffness along the yaw axis
		yawStiffness = 2.5,

		-- (s) Delay after use input before the camera can begin autorotating
		autocorrectDelay = 1,

		-- (studs/s) Minimum vehicle speed before the autocorrect begins to activate
		autocorrectMinCarSpeed = 16,

		-- (studs/s) Vehicle speed where autocorrect is fully activated
		autocorrectMaxCarSpeed = 32,

		-- (hz) Autocorrect stiffness/speed
		autocorrectResponse = 0.5,

		-- (deg/s) Minimum angular yaw velocity before the camera rotation cutoff begins
		cutoffMinAngularVelYaw = 60,

		-- (deg/s) Maximum angular yaw velocity where the camera rotation cutoff is fully activated
		cutoffMaxAngularVelYaw = 180,

		-- (deg/s) Minimum angular pitch velocity before the camera rotation cutoff begins
		cutoffMinAngularVelPitch = 15,

		-- (deg/s) Maximum angular pitch velocity where the camera rotation cutoff is fully activated
		cutoffMaxAngularVelPitch = 60,

		-- (deg) Default pitch angle relative to the horizon
		pitchBaseAngle = 18,

		-- (deg) Half-size of the deadzone angle for pitch autocorrect
		pitchDeadzoneAngle = 12,

		-- (unitless) Multiplier for camera response stiffness in first-person mode
		firstPersonResponseMul = 10,

		-- (hz) Responsiveness of yaw cutoff to rising angular velocities
		yawReponseDampingRising = 1,

		-- (hz) Responsiveness of yaw cutoff to falling angular velocities
		yawResponseDampingFalling = 3,

		-- (hz) Responsiveness of pitch cutoff to rising angular velocities
		pitchReponseDampingRising = 1,

		-- (hz) Responsiveness of pitch cutoff to falling angular velocities
		pitchResponseDampingFalling = 3,

		-- (unitless) Vertical third-person camera offset as a fraction of car radius
		verticalCenterOffset = 0.33,
	}

	return VEHICLE_CAMERA_CONFIG

end))
ModuleScript18.Name = "BaseCamera"
ModuleScript18.Parent = ModuleScript5
table.insert(cors,sandbox(ModuleScript18,function()
	--!nonstrict
	--!nolint DeprecatedApi
--[[
	BaseCamera - Abstract base class for camera control modules
	2018 Camera Update - AllYourBlox
--]]

	--[[ Local Constants ]]--

	local FFlagUserFixGamepadMaxZoom
	do
		local success, result = pcall(function()
			return UserSettings():IsUserFeatureEnabled("UserFixGamepadMaxZoom")
		end)
		FFlagUserFixGamepadMaxZoom = success and result
	end

	local UNIT_Z = Vector3.new(0,0,1)
	local X1_Y0_Z1 = Vector3.new(1,0,1)	--Note: not a unit vector, used for projecting onto XZ plane

	local DEFAULT_DISTANCE = 12.5	-- Studs
	local PORTRAIT_DEFAULT_DISTANCE = 25		-- Studs
	local FIRST_PERSON_DISTANCE_THRESHOLD = 1.0 -- Below this value, snap into first person

	-- Note: DotProduct check in CoordinateFrame::lookAt() prevents using values within about
	-- 8.11 degrees of the +/- Y axis, that's why these limits are currently 80 degrees
	local MIN_Y = math.rad(-80)
	local MAX_Y = math.rad(80)

	local VR_ANGLE = math.rad(15)
	local VR_LOW_INTENSITY_ROTATION = Vector2.new(math.rad(15), 0)
	local VR_HIGH_INTENSITY_ROTATION = Vector2.new(math.rad(45), 0)
	local VR_LOW_INTENSITY_REPEAT = 0.1
	local VR_HIGH_INTENSITY_REPEAT = 0.4

	local ZERO_VECTOR2 = Vector2.new(0,0)
	local ZERO_VECTOR3 = Vector3.new(0,0,0)

	local SEAT_OFFSET = Vector3.new(0,5,0)
	local VR_SEAT_OFFSET = Vector3.new(0,4,0)
	local HEAD_OFFSET = Vector3.new(0,1.5,0)
	local R15_HEAD_OFFSET = Vector3.new(0, 1.5, 0)
	local R15_HEAD_OFFSET_NO_SCALING = Vector3.new(0, 2, 0)
	local HUMANOID_ROOT_PART_SIZE = Vector3.new(2, 2, 1)

	local ZOOM_SENSITIVITY_CURVATURE = 0.5
	local FIRST_PERSON_DISTANCE_MIN = 0.5

	local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"))
	local ZoomController = require(script.Parent:WaitForChild("ZoomController"))
	local CameraToggleStateController = require(script.Parent:WaitForChild("CameraToggleStateController"))
	local CameraInput = require(script.Parent:WaitForChild("CameraInput"))
	local CameraUI = require(script.Parent:WaitForChild("CameraUI"))

	--[[ Roblox Services ]]--
	local Players = game:GetService("Players")
	local UserInputService = game:GetService("UserInputService")
	local StarterGui = game:GetService("StarterGui")
	local VRService = game:GetService("VRService")
	local UserGameSettings = UserSettings():GetService("UserGameSettings")

	local player = Players.LocalPlayer

	--[[ The Module ]]--
	local BaseCamera = {}
	BaseCamera.__index = BaseCamera

	function BaseCamera.new()
		local self = setmetatable({}, BaseCamera)

		self.gamepadZoomLevels = {0, 10, 20} -- zoom levels that are cycled through on a gamepad R3 press

		-- So that derived classes have access to this
		self.FIRST_PERSON_DISTANCE_THRESHOLD = FIRST_PERSON_DISTANCE_THRESHOLD

		self.cameraType = nil
		self.cameraMovementMode = nil

		self.lastCameraTransform = nil
		self.lastUserPanCamera = tick()

		self.humanoidRootPart = nil
		self.humanoidCache = {}

		-- Subject and position on last update call
		self.lastSubject = nil
		self.lastSubjectPosition = Vector3.new(0, 5, 0)
		self.lastSubjectCFrame = CFrame.new(self.lastSubjectPosition)

		self.currentSubjectDistance = math.clamp(DEFAULT_DISTANCE, player.CameraMinZoomDistance, player.CameraMaxZoomDistance)

		self.inFirstPerson = false
		self.inMouseLockedMode = false
		self.portraitMode = false
		self.isSmallTouchScreen = false

		-- Used by modules which want to reset the camera angle on respawn.
		self.resetCameraAngle = true

		self.enabled = false

		-- Input Event Connections

		self.PlayerGui = nil

		self.cameraChangedConn = nil
		self.viewportSizeChangedConn = nil

		-- VR Support
		self.shouldUseVRRotation = false
		self.VRRotationIntensityAvailable = false
		self.lastVRRotationIntensityCheckTime = 0
		self.lastVRRotationTime = 0
		self.vrRotateKeyCooldown = {}
		self.cameraTranslationConstraints = Vector3.new(1, 1, 1)
		self.humanoidJumpOrigin = nil
		self.trackingHumanoid = nil
		self.cameraFrozen = false
		self.subjectStateChangedConn = nil

		self.gamepadZoomPressConnection = nil

		-- Mouse locked formerly known as shift lock mode
		self.mouseLockOffset = ZERO_VECTOR3

		-- Initialization things used to always execute at game load time, but now these camera modules are instantiated
		-- when needed, so the code here may run well after the start of the game

		if player.Character then
			self:OnCharacterAdded(player.Character)
		end

		player.CharacterAdded:Connect(function(char)
			self:OnCharacterAdded(char)
		end)

		if self.playerCameraModeChangeConn then self.playerCameraModeChangeConn:Disconnect() end
		self.playerCameraModeChangeConn = player:GetPropertyChangedSignal("CameraMode"):Connect(function()
			self:OnPlayerCameraPropertyChange()
		end)

		if self.minDistanceChangeConn then self.minDistanceChangeConn:Disconnect() end
		self.minDistanceChangeConn = player:GetPropertyChangedSignal("CameraMinZoomDistance"):Connect(function()
			self:OnPlayerCameraPropertyChange()
		end)

		if self.maxDistanceChangeConn then self.maxDistanceChangeConn:Disconnect() end
		self.maxDistanceChangeConn = player:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(function()
			self:OnPlayerCameraPropertyChange()
		end)

		if self.playerDevTouchMoveModeChangeConn then self.playerDevTouchMoveModeChangeConn:Disconnect() end
		self.playerDevTouchMoveModeChangeConn = player:GetPropertyChangedSignal("DevTouchMovementMode"):Connect(function()
			self:OnDevTouchMovementModeChanged()
		end)
		self:OnDevTouchMovementModeChanged() -- Init

		if self.gameSettingsTouchMoveMoveChangeConn then self.gameSettingsTouchMoveMoveChangeConn:Disconnect() end
		self.gameSettingsTouchMoveMoveChangeConn = UserGameSettings:GetPropertyChangedSignal("TouchMovementMode"):Connect(function()
			self:OnGameSettingsTouchMovementModeChanged()
		end)
		self:OnGameSettingsTouchMovementModeChanged() -- Init

		UserGameSettings:SetCameraYInvertVisible()
		UserGameSettings:SetGamepadCameraSensitivityVisible()

		self.hasGameLoaded = game:IsLoaded()
		if not self.hasGameLoaded then
			self.gameLoadedConn = game.Loaded:Connect(function()
				self.hasGameLoaded = true
				self.gameLoadedConn:Disconnect()
				self.gameLoadedConn = nil
			end)
		end

		self:OnPlayerCameraPropertyChange()

		return self
	end

	function BaseCamera:GetModuleName()
		return "BaseCamera"
	end

	function BaseCamera:OnCharacterAdded(char)
		self.resetCameraAngle = self.resetCameraAngle or self:GetEnabled()
		self.humanoidRootPart = nil
		if UserInputService.TouchEnabled then
			self.PlayerGui = player:WaitForChild("PlayerGui")
			for _, child in ipairs(char:GetChildren()) do
				if child:IsA("Tool") then
					self.isAToolEquipped = true
				end
			end
			char.ChildAdded:Connect(function(child)
				if child:IsA("Tool") then
					self.isAToolEquipped = true
				end
			end)
			char.ChildRemoved:Connect(function(child)
				if child:IsA("Tool") then
					self.isAToolEquipped = false
				end
			end)
		end
	end

	function BaseCamera:GetHumanoidRootPart(): BasePart
		if not self.humanoidRootPart then
			if player.Character then
				local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
				if humanoid then
					self.humanoidRootPart = humanoid.RootPart
				end
			end
		end
		return self.humanoidRootPart
	end

	function BaseCamera:GetBodyPartToFollow(humanoid: Humanoid, isDead: boolean) -- BasePart
		-- If the humanoid is dead, prefer the head part if one still exists as a sibling of the humanoid
		if humanoid:GetState() == Enum.HumanoidStateType.Dead then
			local character = humanoid.Parent
			if character and character:IsA("Model") then
				return character:FindFirstChild("Head") or humanoid.RootPart
			end
		end

		return humanoid.RootPart
	end

	function BaseCamera:GetSubjectCFrame(): CFrame
		local result = self.lastSubjectCFrame
		local camera = workspace.CurrentCamera
		local cameraSubject = camera and camera.CameraSubject

		if not cameraSubject then
			return result
		end

		if cameraSubject:IsA("Humanoid") then
			local humanoid = cameraSubject
			local humanoidIsDead = humanoid:GetState() == Enum.HumanoidStateType.Dead

			local bodyPartToFollow = humanoid.RootPart

			-- If the humanoid is dead, prefer their head part as a follow target, if it exists
			if humanoidIsDead then
				if humanoid.Parent and humanoid.Parent:IsA("Model") then
					bodyPartToFollow = humanoid.Parent:FindFirstChild("Head") or bodyPartToFollow
				end
			end

			if bodyPartToFollow and bodyPartToFollow:IsA("BasePart") then
				local heightOffset
				if humanoid.RigType == Enum.HumanoidRigType.R15 then
					if humanoid.AutomaticScalingEnabled then
						heightOffset = R15_HEAD_OFFSET

						local rootPart = humanoid.RootPart
						if bodyPartToFollow == rootPart then
							local rootPartSizeOffset = (rootPart.Size.Y - HUMANOID_ROOT_PART_SIZE.Y)/2
							heightOffset = heightOffset + Vector3.new(0, rootPartSizeOffset, 0)
						end
					else
						heightOffset = R15_HEAD_OFFSET_NO_SCALING
					end
				else
					heightOffset = HEAD_OFFSET
				end

				if humanoidIsDead then
					heightOffset = ZERO_VECTOR3
				end

				result = bodyPartToFollow.CFrame*CFrame.new(heightOffset + humanoid.CameraOffset)
			end

		elseif cameraSubject:IsA("BasePart") then
			result = cameraSubject.CFrame

		elseif cameraSubject:IsA("Model") then
			-- Model subjects are expected to have a PrimaryPart to determine orientation
			if cameraSubject.PrimaryPart then
				result = cameraSubject:GetPrimaryPartCFrame()
			else
				result = CFrame.new()
			end
		end

		if result then
			self.lastSubjectCFrame = result
		end

		return result
	end

	function BaseCamera:GetSubjectVelocity(): Vector3
		local camera = workspace.CurrentCamera
		local cameraSubject = camera and camera.CameraSubject

		if not cameraSubject then
			return ZERO_VECTOR3
		end

		if cameraSubject:IsA("BasePart") then
			return cameraSubject.Velocity

		elseif cameraSubject:IsA("Humanoid") then
			local rootPart = cameraSubject.RootPart

			if rootPart then
				return rootPart.Velocity
			end

		elseif cameraSubject:IsA("Model") then
			local primaryPart = cameraSubject.PrimaryPart

			if primaryPart then
				return primaryPart.Velocity
			end
		end

		return ZERO_VECTOR3
	end

	function BaseCamera:GetSubjectRotVelocity(): Vector3
		local camera = workspace.CurrentCamera
		local cameraSubject = camera and camera.CameraSubject

		if not cameraSubject then
			return ZERO_VECTOR3
		end

		if cameraSubject:IsA("BasePart") then
			return cameraSubject.RotVelocity

		elseif cameraSubject:IsA("Humanoid") then
			local rootPart = cameraSubject.RootPart

			if rootPart then
				return rootPart.RotVelocity
			end

		elseif cameraSubject:IsA("Model") then
			local primaryPart = cameraSubject.PrimaryPart

			if primaryPart then
				return primaryPart.RotVelocity
			end
		end

		return ZERO_VECTOR3
	end

	function BaseCamera:StepZoom()
		local zoom: number = self.currentSubjectDistance
		local zoomDelta: number = CameraInput.getZoomDelta()

		if math.abs(zoomDelta) > 0 then
			local newZoom

			if zoomDelta > 0 then
				newZoom = zoom + zoomDelta*(1 + zoom*ZOOM_SENSITIVITY_CURVATURE)
				newZoom = math.max(newZoom, self.FIRST_PERSON_DISTANCE_THRESHOLD)
			else
				newZoom = (zoom + zoomDelta)/(1 - zoomDelta*ZOOM_SENSITIVITY_CURVATURE)
				newZoom = math.max(newZoom, FIRST_PERSON_DISTANCE_MIN)
			end

			if newZoom < self.FIRST_PERSON_DISTANCE_THRESHOLD then
				newZoom = FIRST_PERSON_DISTANCE_MIN
			end

			self:SetCameraToSubjectDistance(newZoom)
		end

		return ZoomController.GetZoomRadius()
	end

	function BaseCamera:GetSubjectPosition(): Vector3?
		local result = self.lastSubjectPosition
		local camera = game.Workspace.CurrentCamera
		local cameraSubject = camera and camera.CameraSubject

		if cameraSubject then
			if cameraSubject:IsA("Humanoid") then
				local humanoid = cameraSubject
				local humanoidIsDead = humanoid:GetState() == Enum.HumanoidStateType.Dead

				local bodyPartToFollow = humanoid.RootPart

				-- If the humanoid is dead, prefer their head part as a follow target, if it exists
				if humanoidIsDead then
					if humanoid.Parent and humanoid.Parent:IsA("Model") then
						bodyPartToFollow = humanoid.Parent:FindFirstChild("Head") or bodyPartToFollow
					end
				end

				if bodyPartToFollow and bodyPartToFollow:IsA("BasePart") then
					local heightOffset
					if humanoid.RigType == Enum.HumanoidRigType.R15 then
						if humanoid.AutomaticScalingEnabled then
							heightOffset = R15_HEAD_OFFSET
							if bodyPartToFollow == humanoid.RootPart then
								local rootPartSizeOffset = (humanoid.RootPart.Size.Y/2) - (HUMANOID_ROOT_PART_SIZE.Y/2)
								heightOffset = heightOffset + Vector3.new(0, rootPartSizeOffset, 0)
							end
						else
							heightOffset = R15_HEAD_OFFSET_NO_SCALING
						end
					else
						heightOffset = HEAD_OFFSET
					end

					if humanoidIsDead then
						heightOffset = ZERO_VECTOR3
					end

					result = bodyPartToFollow.CFrame.p + bodyPartToFollow.CFrame:vectorToWorldSpace(heightOffset + humanoid.CameraOffset)
				end

			elseif cameraSubject:IsA("VehicleSeat") then
				local offset = SEAT_OFFSET
				result = cameraSubject.CFrame.p + cameraSubject.CFrame:vectorToWorldSpace(offset)
			elseif cameraSubject:IsA("SkateboardPlatform") then
				result = cameraSubject.CFrame.p + SEAT_OFFSET
			elseif cameraSubject:IsA("BasePart") then
				result = cameraSubject.CFrame.p
			elseif cameraSubject:IsA("Model") then
				if cameraSubject.PrimaryPart then
					result = cameraSubject:GetPrimaryPartCFrame().p
				else
					result = cameraSubject:GetModelCFrame().p
				end
			end
		else
			-- cameraSubject is nil
			-- Note: Previous RootCamera did not have this else case and let self.lastSubject and self.lastSubjectPosition
			-- both get set to nil in the case of cameraSubject being nil. This function now exits here to preserve the
			-- last set valid values for these, as nil values are not handled cases
			return nil
		end

		self.lastSubject = cameraSubject
		self.lastSubjectPosition = result

		return result
	end

	function BaseCamera:OnViewportSizeChanged()
		local camera = game.Workspace.CurrentCamera
		local size = camera.ViewportSize
		self.portraitMode = size.X < size.Y
		self.isSmallTouchScreen = UserInputService.TouchEnabled and (size.Y < 500 or size.X < 700)
	end

	-- Listener for changes to workspace.CurrentCamera
	function BaseCamera:OnCurrentCameraChanged()
		if UserInputService.TouchEnabled then
			if self.viewportSizeChangedConn then
				self.viewportSizeChangedConn:Disconnect()
				self.viewportSizeChangedConn = nil
			end

			local newCamera = game.Workspace.CurrentCamera

			if newCamera then
				self:OnViewportSizeChanged()
				self.viewportSizeChangedConn = newCamera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
					self:OnViewportSizeChanged()
				end)
			end
		end

		-- VR support additions
		if self.cameraSubjectChangedConn then
			self.cameraSubjectChangedConn:Disconnect()
			self.cameraSubjectChangedConn = nil
		end

		local camera = game.Workspace.CurrentCamera
		if camera then
			self.cameraSubjectChangedConn = camera:GetPropertyChangedSignal("CameraSubject"):Connect(function()
				self:OnNewCameraSubject()
			end)
			self:OnNewCameraSubject()
		end
	end

	function BaseCamera:OnDynamicThumbstickEnabled()
		if UserInputService.TouchEnabled then
			self.isDynamicThumbstickEnabled = true
		end
	end

	function BaseCamera:OnDynamicThumbstickDisabled()
		self.isDynamicThumbstickEnabled = false
	end

	function BaseCamera:OnGameSettingsTouchMovementModeChanged()
		if player.DevTouchMovementMode == Enum.DevTouchMovementMode.UserChoice then
			if (UserGameSettings.TouchMovementMode == Enum.TouchMovementMode.DynamicThumbstick
				or UserGameSettings.TouchMovementMode == Enum.TouchMovementMode.Default) then
				self:OnDynamicThumbstickEnabled()
			else
				self:OnDynamicThumbstickDisabled()
			end
		end
	end

	function BaseCamera:OnDevTouchMovementModeChanged()
		if player.DevTouchMovementMode == Enum.DevTouchMovementMode.DynamicThumbstick then
			self:OnDynamicThumbstickEnabled()
		else
			self:OnGameSettingsTouchMovementModeChanged()
		end
	end

	function BaseCamera:OnPlayerCameraPropertyChange()
		-- This call forces re-evaluation of player.CameraMode and clamping to min/max distance which may have changed
		self:SetCameraToSubjectDistance(self.currentSubjectDistance)
	end

	function BaseCamera:InputTranslationToCameraAngleChange(translationVector, sensitivity)
		return translationVector * sensitivity
	end

	-- cycles between zoom levels in self.gamepadZoomLevels, setting CameraToSubjectDistance. gamepadZoomLevels may
	-- be out of range of Min/Max camera zoom
	function BaseCamera:GamepadZoomPress()
		-- this code relies on the fact that SetCameraToSubjectDistance will clamp the min and max
		local dist = self:GetCameraToSubjectDistance()

		local max = player.CameraMaxZoomDistance

		-- check from largest to smallest, set the first zoom level which is 
		-- below the threshold
		for i = #self.gamepadZoomLevels, 1, -1 do
			local zoom = self.gamepadZoomLevels[i]

			if max < zoom then
				continue
			end

			if zoom < player.CameraMinZoomDistance then
				zoom = player.CameraMinZoomDistance
				if FFlagUserFixGamepadMaxZoom then
					-- no more zoom levels to check, all the remaining ones
					-- are < min
					if max == zoom then
						break
					end
				end
			end

			if not FFlagUserFixGamepadMaxZoom then
				if max == zoom then
					break
				end
			end

			-- theshold is set at halfway between zoom levels
			if dist > zoom + (max - zoom) / 2 then
				self:SetCameraToSubjectDistance(zoom)
				return
			end

			max = zoom
		end

		-- cycle back to the largest, relies on the fact that SetCameraToSubjectDistance will clamp max and min
		self:SetCameraToSubjectDistance(self.gamepadZoomLevels[#self.gamepadZoomLevels])
	end

	function BaseCamera:Enable(enable: boolean)
		if self.enabled ~= enable then
			self.enabled = enable

			self:OnEnabledChanged()
		end
	end

	function BaseCamera:OnEnabledChanged()
		if self.enabled then
			CameraInput.setInputEnabled(true)

			self.gamepadZoomPressConnection = CameraInput.gamepadZoomPress:Connect(function()
				self:GamepadZoomPress()
			end)

			if player.CameraMode == Enum.CameraMode.LockFirstPerson then
				self.currentSubjectDistance = 0.5
				if not self.inFirstPerson then
					self:EnterFirstPerson()
				end
			end

			if self.cameraChangedConn then self.cameraChangedConn:Disconnect(); self.cameraChangedConn = nil end
			self.cameraChangedConn = workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
				self:OnCurrentCameraChanged()
			end)
			self:OnCurrentCameraChanged()
		else
			CameraInput.setInputEnabled(false)

			if self.gamepadZoomPressConnection then
				self.gamepadZoomPressConnection:Disconnect()
				self.gamepadZoomPressConnection = nil
			end
			-- Clean up additional event listeners and reset a bunch of properties
			self:Cleanup()
		end
	end

	function BaseCamera:GetEnabled(): boolean
		return self.enabled
	end

	function BaseCamera:Cleanup()
		if self.subjectStateChangedConn then
			self.subjectStateChangedConn:Disconnect()
			self.subjectStateChangedConn = nil
		end
		if self.viewportSizeChangedConn then
			self.viewportSizeChangedConn:Disconnect()
			self.viewportSizeChangedConn = nil
		end
		if self.cameraChangedConn then 
			self.cameraChangedConn:Disconnect()
			self.cameraChangedConn = nil 
		end

		self.lastCameraTransform = nil
		self.lastSubjectCFrame = nil

		-- Unlock mouse for example if right mouse button was being held down
		CameraUtils.restoreMouseBehavior()
	end

	function BaseCamera:UpdateMouseBehavior()
		local blockToggleDueToClickToMove = UserGameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove

		if self.isCameraToggle and blockToggleDueToClickToMove == false then
			CameraUI.setCameraModeToastEnabled(true)
			CameraInput.enableCameraToggleInput()
			CameraToggleStateController(self.inFirstPerson)
		else
			CameraUI.setCameraModeToastEnabled(false)
			CameraInput.disableCameraToggleInput()

			-- first time transition to first person mode or mouse-locked third person
			if self.inFirstPerson or self.inMouseLockedMode then
				CameraUtils.setRotationTypeOverride(Enum.RotationType.CameraRelative)
				CameraUtils.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter)
			else
				CameraUtils.restoreRotationType()

				local rotationActivated = CameraInput.getRotationActivated()
				if rotationActivated then
					CameraUtils.setMouseBehaviorOverride(Enum.MouseBehavior.LockCurrentPosition)
				else
					CameraUtils.restoreMouseBehavior()
				end
			end
		end
	end

	function BaseCamera:UpdateForDistancePropertyChange()
		-- Calling this setter with the current value will force checking that it is still
		-- in range after a change to the min/max distance limits
		self:SetCameraToSubjectDistance(self.currentSubjectDistance)
	end

	function BaseCamera:SetCameraToSubjectDistance(desiredSubjectDistance: number): number
		local lastSubjectDistance = self.currentSubjectDistance

		-- By default, camera modules will respect LockFirstPerson and override the currentSubjectDistance with 0
		-- regardless of what Player.CameraMinZoomDistance is set to, so that first person can be made
		-- available by the developer without needing to allow players to mousewheel dolly into first person.
		-- Some modules will override this function to remove or change first-person capability.
		if player.CameraMode == Enum.CameraMode.LockFirstPerson then
			self.currentSubjectDistance = 0.5
			if not self.inFirstPerson then
				self:EnterFirstPerson()
			end
		else
			local newSubjectDistance = math.clamp(desiredSubjectDistance, player.CameraMinZoomDistance, player.CameraMaxZoomDistance)
			if newSubjectDistance < FIRST_PERSON_DISTANCE_THRESHOLD then
				self.currentSubjectDistance = 0.5
				if not self.inFirstPerson then
					self:EnterFirstPerson()
				end
			else
				self.currentSubjectDistance = newSubjectDistance
				if self.inFirstPerson then
					self:LeaveFirstPerson()
				end
			end
		end

		-- Pass target distance and zoom direction to the zoom controller
		ZoomController.SetZoomParameters(self.currentSubjectDistance, math.sign(desiredSubjectDistance - lastSubjectDistance))

		-- Returned only for convenience to the caller to know the outcome
		return self.currentSubjectDistance
	end

	function BaseCamera:SetCameraType( cameraType )
		--Used by derived classes
		self.cameraType = cameraType
	end

	function BaseCamera:GetCameraType()
		return self.cameraType
	end

	-- Movement mode standardized to Enum.ComputerCameraMovementMode values
	function BaseCamera:SetCameraMovementMode( cameraMovementMode )
		self.cameraMovementMode = cameraMovementMode
	end

	function BaseCamera:GetCameraMovementMode()
		return self.cameraMovementMode
	end

	function BaseCamera:SetIsMouseLocked(mouseLocked: boolean)
		self.inMouseLockedMode = mouseLocked
	end

	function BaseCamera:GetIsMouseLocked(): boolean
		return self.inMouseLockedMode
	end

	function BaseCamera:SetMouseLockOffset(offsetVector)
		self.mouseLockOffset = offsetVector
	end

	function BaseCamera:GetMouseLockOffset()
		return self.mouseLockOffset
	end

	function BaseCamera:InFirstPerson(): boolean
		return self.inFirstPerson
	end

	function BaseCamera:EnterFirstPerson()
		self.inFirstPerson = true
		self:UpdateMouseBehavior()
	end

	function BaseCamera:LeaveFirstPerson()
		self.inFirstPerson = false
		self:UpdateMouseBehavior()
	end

	-- Nominal distance, set by dollying in and out with the mouse wheel or equivalent, not measured distance
	function BaseCamera:GetCameraToSubjectDistance(): number
		return self.currentSubjectDistance
	end

	-- Actual measured distance to the camera Focus point, which may be needed in special circumstances, but should
	-- never be used as the starting point for updating the nominal camera-to-subject distance (self.currentSubjectDistance)
	-- since that is a desired target value set only by mouse wheel (or equivalent) input, PopperCam, and clamped to min max camera distance
	function BaseCamera:GetMeasuredDistanceToFocus(): number?
		local camera = game.Workspace.CurrentCamera
		if camera then
			return (camera.CoordinateFrame.p - camera.Focus.p).magnitude
		end
		return nil
	end

	function BaseCamera:GetCameraLookVector(): Vector3
		return game.Workspace.CurrentCamera and game.Workspace.CurrentCamera.CFrame.LookVector or UNIT_Z
	end

	function BaseCamera:CalculateNewLookCFrameFromArg(suppliedLookVector: Vector3?, rotateInput: Vector2): CFrame
		local currLookVector: Vector3 = suppliedLookVector or self:GetCameraLookVector()
		local currPitchAngle = math.asin(currLookVector.Y)
		local yTheta = math.clamp(rotateInput.Y, -MAX_Y + currPitchAngle, -MIN_Y + currPitchAngle)
		local constrainedRotateInput = Vector2.new(rotateInput.X, yTheta)
		local startCFrame = CFrame.new(ZERO_VECTOR3, currLookVector)
		local newLookCFrame = CFrame.Angles(0, -constrainedRotateInput.X, 0) * startCFrame * CFrame.Angles(-constrainedRotateInput.Y,0,0)
		return newLookCFrame
	end

	function BaseCamera:CalculateNewLookVectorFromArg(suppliedLookVector: Vector3?, rotateInput: Vector2): Vector3
		local newLookCFrame = self:CalculateNewLookCFrameFromArg(suppliedLookVector, rotateInput)
		return newLookCFrame.LookVector
	end

	function BaseCamera:CalculateNewLookVectorVRFromArg(rotateInput: Vector2): Vector3
		local subjectPosition: Vector3 = self:GetSubjectPosition()
		local vecToSubject: Vector3 = (subjectPosition - (game.Workspace.CurrentCamera :: Camera).CFrame.p)
		local currLookVector: Vector3 = (vecToSubject * X1_Y0_Z1).unit
		local vrRotateInput: Vector2 = Vector2.new(rotateInput.X, 0)
		local startCFrame: CFrame = CFrame.new(ZERO_VECTOR3, currLookVector)
		local yawRotatedVector: Vector3 = (CFrame.Angles(0, -vrRotateInput.X, 0) * startCFrame * CFrame.Angles(-vrRotateInput.Y,0,0)).LookVector
		return (yawRotatedVector * X1_Y0_Z1).unit
	end

	function BaseCamera:GetHumanoid(): Humanoid?
		local character = player and player.Character
		if character then
			local resultHumanoid = self.humanoidCache[player]
			if resultHumanoid and resultHumanoid.Parent == character then
				return resultHumanoid
			else
				self.humanoidCache[player] = nil -- Bust Old Cache
				local humanoid = character:FindFirstChildOfClass("Humanoid")
				if humanoid then
					self.humanoidCache[player] = humanoid
				end
				return humanoid
			end
		end
		return nil
	end

	function BaseCamera:GetHumanoidPartToFollow(humanoid: Humanoid, humanoidStateType: Enum.HumanoidStateType) -- BasePart
		if humanoidStateType == Enum.HumanoidStateType.Dead then
			local character = humanoid.Parent
			if character then
				return character:FindFirstChild("Head") or humanoid.Torso
			else
				return humanoid.Torso
			end
		else
			return humanoid.Torso
		end
	end


	function BaseCamera:OnNewCameraSubject()
		if self.subjectStateChangedConn then
			self.subjectStateChangedConn:Disconnect()
			self.subjectStateChangedConn = nil
		end
	end

	function BaseCamera:IsInFirstPerson()
		return self.inFirstPerson
	end

	function BaseCamera:Update(dt)
		error("BaseCamera:Update() This is a virtual function that should never be getting called.", 2)
	end

	function BaseCamera:GetCameraHeight()
		if VRService.VREnabled and not self.inFirstPerson then
			return math.sin(VR_ANGLE) * self.currentSubjectDistance
		end
		return 0
	end

	return BaseCamera

end))
ModuleScript19.Name = "CameraToggleStateController"
ModuleScript19.Parent = ModuleScript5
table.insert(cors,sandbox(ModuleScript19,function()
	local Players = game:GetService("Players")
	local UserInputService = game:GetService("UserInputService")
	local GameSettings = UserSettings():GetService("UserGameSettings")

	local Input = require(script.Parent:WaitForChild("CameraInput"))
	local CameraUI = require(script.Parent:WaitForChild("CameraUI"))
	local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"))

	local lastTogglePan = false
	local lastTogglePanChange = tick()

	local CROSS_MOUSE_ICON = "rbxasset://textures/Cursors/CrossMouseIcon.png"

	local lockStateDirty = false
	local wasTogglePanOnTheLastTimeYouWentIntoFirstPerson = false
	local lastFirstPerson = false

	CameraUI.setCameraModeToastEnabled(false)

	return function(isFirstPerson: boolean)
		local togglePan = Input.getTogglePan()
		local toastTimeout = 3

		if isFirstPerson and togglePan ~= lastTogglePan then
			lockStateDirty = true
		end

		if lastTogglePan ~= togglePan or tick() - lastTogglePanChange > toastTimeout then
			local doShow = togglePan and tick() - lastTogglePanChange < toastTimeout

			CameraUI.setCameraModeToastOpen(doShow)

			if togglePan then
				lockStateDirty = false
			end
			lastTogglePanChange = tick()
			lastTogglePan = togglePan
		end

		if isFirstPerson ~= lastFirstPerson then
			if isFirstPerson then
				wasTogglePanOnTheLastTimeYouWentIntoFirstPerson = Input.getTogglePan()
				Input.setTogglePan(true)
			elseif not lockStateDirty then
				Input.setTogglePan(wasTogglePanOnTheLastTimeYouWentIntoFirstPerson)
			end
		end

		if isFirstPerson then
			if Input.getTogglePan() then
				CameraUtils.setMouseIconOverride(CROSS_MOUSE_ICON)
				CameraUtils.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter)
				CameraUtils.setRotationTypeOverride(Enum.RotationType.CameraRelative)
			else
				CameraUtils.restoreMouseIcon()
				CameraUtils.restoreMouseBehavior()
				CameraUtils.setRotationTypeOverride(Enum.RotationType.CameraRelative)
			end

		elseif Input.getTogglePan() then
			CameraUtils.setMouseIconOverride(CROSS_MOUSE_ICON)
			CameraUtils.setMouseBehaviorOverride(Enum.MouseBehavior.LockCenter)
			CameraUtils.setRotationTypeOverride(Enum.RotationType.MovementRelative)

		elseif Input.getHoldPan() then
			CameraUtils.restoreMouseIcon()
			CameraUtils.setMouseBehaviorOverride(Enum.MouseBehavior.LockCurrentPosition)
			CameraUtils.setRotationTypeOverride(Enum.RotationType.MovementRelative)

		else
			CameraUtils.restoreMouseIcon()
			CameraUtils.restoreMouseBehavior()
			CameraUtils.restoreRotationType()
		end

		lastFirstPerson = isFirstPerson
	end

end))
ModuleScript20.Name = "ZoomController"
ModuleScript20.Parent = ModuleScript5
table.insert(cors,sandbox(ModuleScript20,function()
	-- Zoom
	-- Controls the distance between the focus and the camera.

	local ZOOM_STIFFNESS = 4.5
	local ZOOM_DEFAULT = 12.5
	local ZOOM_ACCELERATION = 0.0375

	local MIN_FOCUS_DIST = 0.5
	local DIST_OPAQUE = 1

	local Popper = require(script:WaitForChild("Popper"))

	local clamp = math.clamp
	local exp = math.exp
	local min = math.min
	local max = math.max
	local pi = math.pi

	local cameraMinZoomDistance, cameraMaxZoomDistance do
		local Player = game:GetService("Players").LocalPlayer
		assert(Player)

		local function updateBounds()
			cameraMinZoomDistance = Player.CameraMinZoomDistance
			cameraMaxZoomDistance = Player.CameraMaxZoomDistance
		end

		updateBounds()

		Player:GetPropertyChangedSignal("CameraMinZoomDistance"):Connect(updateBounds)
		Player:GetPropertyChangedSignal("CameraMaxZoomDistance"):Connect(updateBounds)
	end

	local ConstrainedSpring = {} do
		ConstrainedSpring.__index = ConstrainedSpring

		function ConstrainedSpring.new(freq: number, x: number, minValue: number, maxValue: number)
			x = clamp(x, minValue, maxValue)
			return setmetatable({
				freq = freq, -- Undamped frequency (Hz)
				x = x, -- Current position
				v = 0, -- Current velocity
				minValue = minValue, -- Minimum bound
				maxValue = maxValue, -- Maximum bound
				goal = x, -- Goal position
			}, ConstrainedSpring)
		end

		function ConstrainedSpring:Step(dt: number)
			local freq = self.freq :: number * 2 * pi -- Convert from Hz to rad/s
			local x: number = self.x
			local v: number = self.v
			local minValue: number = self.minValue
			local maxValue: number = self.maxValue
			local goal: number = self.goal

			-- Solve the spring ODE for position and velocity after time t, assuming critical damping:
			--   2*f*x'[t] + x''[t] = f^2*(g - x[t])
			-- Knowns are x[0] and x'[0].
			-- Solve for x[t] and x'[t].

			local offset = goal - x
			local step = freq*dt
			local decay = exp(-step)

			local x1 = goal + (v*dt - offset*(step + 1))*decay
			local v1 = ((offset*freq - v)*step + v)*decay

			-- Constrain
			if x1 < minValue then
				x1 = minValue
				v1 = 0
			elseif x1 > maxValue then
				x1 = maxValue
				v1 = 0
			end

			self.x = x1
			self.v = v1

			return x1
		end
	end

	local zoomSpring = ConstrainedSpring.new(ZOOM_STIFFNESS, ZOOM_DEFAULT, MIN_FOCUS_DIST, cameraMaxZoomDistance)

	local function stepTargetZoom(z: number, dz: number, zoomMin: number, zoomMax: number)
		z = clamp(z + dz*(1 + z*ZOOM_ACCELERATION), zoomMin, zoomMax)
		if z < DIST_OPAQUE then
			z = dz <= 0 and zoomMin or DIST_OPAQUE
		end
		return z
	end

	local zoomDelta = 0

	local Zoom = {} do
		function Zoom.Update(renderDt: number, focus: CFrame, extrapolation)
			local poppedZoom = math.huge

			if zoomSpring.goal > DIST_OPAQUE then
				-- Make a pessimistic estimate of zoom distance for this step without accounting for poppercam
				local maxPossibleZoom = max(
					zoomSpring.x,
					stepTargetZoom(zoomSpring.goal, zoomDelta, cameraMinZoomDistance, cameraMaxZoomDistance)
				)

				-- Run the Popper algorithm on the feasible zoom range, [MIN_FOCUS_DIST, maxPossibleZoom]
				poppedZoom = Popper(
					focus*CFrame.new(0, 0, MIN_FOCUS_DIST),
					maxPossibleZoom - MIN_FOCUS_DIST,
					extrapolation
				) + MIN_FOCUS_DIST
			end

			zoomSpring.minValue = MIN_FOCUS_DIST
			zoomSpring.maxValue = min(cameraMaxZoomDistance, poppedZoom)

			return zoomSpring:Step(renderDt)
		end

		function Zoom.GetZoomRadius()
			return zoomSpring.x
		end

		function Zoom.SetZoomParameters(targetZoom, newZoomDelta)
			zoomSpring.goal = targetZoom
			zoomDelta = newZoomDelta
		end

		function Zoom.ReleaseSpring()
			zoomSpring.x = zoomSpring.goal
			zoomSpring.v = 0
		end
	end

	return Zoom

end))
ModuleScript21.Name = "Popper"
ModuleScript21.Parent = ModuleScript20
table.insert(cors,sandbox(ModuleScript21,function()
	--!nonstrict
	--------------------------------------------------------------------------------
	-- Popper.lua
	-- Prevents your camera from clipping through walls.
	--------------------------------------------------------------------------------

	local Players = game:GetService("Players")

	local camera = game.Workspace.CurrentCamera

	local min = math.min
	local tan = math.tan
	local rad = math.rad
	local inf = math.huge
	local ray = Ray.new

	local function getTotalTransparency(part)
		return 1 - (1 - part.Transparency)*(1 - part.LocalTransparencyModifier)
	end

	local function eraseFromEnd(t, toSize)
		for i = #t, toSize + 1, -1 do
			t[i] = nil
		end
	end

	local nearPlaneZ, projX, projY do
		local function updateProjection()
			local fov = rad(camera.FieldOfView)
			local view = camera.ViewportSize
			local ar = view.X/view.Y

			projY = 2*tan(fov/2)
			projX = ar*projY
		end

		camera:GetPropertyChangedSignal("FieldOfView"):Connect(updateProjection)
		camera:GetPropertyChangedSignal("ViewportSize"):Connect(updateProjection)

		updateProjection()

		nearPlaneZ = camera.NearPlaneZ
		camera:GetPropertyChangedSignal("NearPlaneZ"):Connect(function()
			nearPlaneZ = camera.NearPlaneZ
		end)
	end

	local blacklist = {} do
		local charMap = {}

		local function refreshIgnoreList()
			local n = 1
			blacklist = {}
			for _, character in pairs(charMap) do
				blacklist[n] = character
				n = n + 1
			end
		end

		local function playerAdded(player)
			local function characterAdded(character)
				charMap[player] = character
				refreshIgnoreList()
			end
			local function characterRemoving()
				charMap[player] = nil
				refreshIgnoreList()
			end

			player.CharacterAdded:Connect(characterAdded)
			player.CharacterRemoving:Connect(characterRemoving)
			if player.Character then
				characterAdded(player.Character)
			end
		end

		local function playerRemoving(player)
			charMap[player] = nil
			refreshIgnoreList()
		end

		Players.PlayerAdded:Connect(playerAdded)
		Players.PlayerRemoving:Connect(playerRemoving)

		for _, player in ipairs(Players:GetPlayers()) do
			playerAdded(player)
		end
		refreshIgnoreList()
	end

	--------------------------------------------------------------------------------------------
	-- Popper uses the level geometry find an upper bound on subject-to-camera distance.
	--
	-- Hard limits are applied immediately and unconditionally. They are generally caused
	-- when level geometry intersects with the near plane (with exceptions, see below).
	--
	-- Soft limits are only applied under certain conditions.
	-- They are caused when level geometry occludes the subject without actually intersecting
	-- with the near plane at the target distance.
	--
	-- Soft limits can be promoted to hard limits and hard limits can be demoted to soft limits.
	-- We usually don"t want the latter to happen.
	--
	-- A soft limit will be promoted to a hard limit if an obstruction
	-- lies between the current and target camera positions.
	--------------------------------------------------------------------------------------------

	local subjectRoot
	local subjectPart

	camera:GetPropertyChangedSignal("CameraSubject"):Connect(function()
		local subject = camera.CameraSubject
		if subject:IsA("Humanoid") then
			subjectPart = subject.RootPart
		elseif subject:IsA("BasePart") then
			subjectPart = subject
		else
			subjectPart = nil
		end
	end)

	local function canOcclude(part)
		-- Occluders must be:
		-- 1. Opaque
		-- 2. Interactable
		-- 3. Not in the same assembly as the subject

		return
			getTotalTransparency(part) < 0.25 and
			part.CanCollide and
			subjectRoot ~= (part:GetRootPart() or part) and
			not part:IsA("TrussPart")
	end

	-- Offsets for the volume visibility test
	local SCAN_SAMPLE_OFFSETS = {
		Vector2.new( 0.4, 0.0),
		Vector2.new(-0.4, 0.0),
		Vector2.new( 0.0,-0.4),
		Vector2.new( 0.0, 0.4),
		Vector2.new( 0.0, 0.2),
	}

	-- Maximum number of rays that can be cast 
	local QUERY_POINT_CAST_LIMIT = 64

	--------------------------------------------------------------------------------
	-- Piercing raycasts

	local function getCollisionPoint(origin, dir)
		local originalSize = #blacklist
		repeat
			local hitPart, hitPoint = workspace:FindPartOnRayWithIgnoreList(
				ray(origin, dir), blacklist, false, true
			)

			if hitPart then
				if hitPart.CanCollide then
					eraseFromEnd(blacklist, originalSize)
					return hitPoint, true
				end
				blacklist[#blacklist + 1] = hitPart
			end
		until not hitPart

		eraseFromEnd(blacklist, originalSize)
		return origin + dir, false
	end

	--------------------------------------------------------------------------------

	local function queryPoint(origin, unitDir, dist, lastPos)
		debug.profilebegin("queryPoint")

		local originalSize = #blacklist

		dist = dist + nearPlaneZ
		local target = origin + unitDir*dist

		local softLimit = inf
		local hardLimit = inf
		local movingOrigin = origin

		local numPierced = 0

		repeat
			local entryPart, entryPos = workspace:FindPartOnRayWithIgnoreList(ray(movingOrigin, target - movingOrigin), blacklist, false, true)
			numPierced += 1

			if entryPart then
				-- forces the current iteration into a hard limit to cap the number of raycasts
				local earlyAbort = numPierced >= QUERY_POINT_CAST_LIMIT

				if canOcclude(entryPart) or earlyAbort then
					local wl = {entryPart}
					local exitPart = workspace:FindPartOnRayWithWhitelist(ray(target, entryPos - target), wl, true)

					local lim = (entryPos - origin).Magnitude

					if exitPart and not earlyAbort then
						local promote = false
						if lastPos then
							promote =
								workspace:FindPartOnRayWithWhitelist(ray(lastPos, target - lastPos), wl, true) or
								workspace:FindPartOnRayWithWhitelist(ray(target, lastPos - target), wl, true)
						end

						if promote then
							-- Ostensibly a soft limit, but the camera has passed through it in the last frame, so promote to a hard limit.
							hardLimit = lim
						elseif dist < softLimit then
							-- Trivial soft limit
							softLimit = lim
						end
					else
						-- Trivial hard limit
						hardLimit = lim
					end
				end

				blacklist[#blacklist + 1] = entryPart
				movingOrigin = entryPos - unitDir*1e-3
			end
		until hardLimit < inf or not entryPart

		eraseFromEnd(blacklist, originalSize)

		debug.profileend()
		return softLimit - nearPlaneZ, hardLimit - nearPlaneZ
	end

	local function queryViewport(focus, dist)
		debug.profilebegin("queryViewport")

		local fP =  focus.p
		local fX =  focus.rightVector
		local fY =  focus.upVector
		local fZ = -focus.lookVector

		local viewport = camera.ViewportSize

		local hardBoxLimit = inf
		local softBoxLimit = inf

		-- Center the viewport on the PoI, sweep points on the edge towards the target, and take the minimum limits
		for viewX = 0, 1 do
			local worldX = fX*((viewX - 0.5)*projX)

			for viewY = 0, 1 do
				local worldY = fY*((viewY - 0.5)*projY)

				local origin = fP + nearPlaneZ*(worldX + worldY)
				local lastPos = camera:ViewportPointToRay(
					viewport.x*viewX,
					viewport.y*viewY
				).Origin

				local softPointLimit, hardPointLimit = queryPoint(origin, fZ, dist, lastPos)

				if hardPointLimit < hardBoxLimit then
					hardBoxLimit = hardPointLimit
				end
				if softPointLimit < softBoxLimit then
					softBoxLimit = softPointLimit
				end
			end
		end
		debug.profileend()

		return softBoxLimit, hardBoxLimit
	end

	local function testPromotion(focus, dist, focusExtrapolation)
		debug.profilebegin("testPromotion")

		local fP = focus.p
		local fX = focus.rightVector
		local fY = focus.upVector
		local fZ = -focus.lookVector

		do
			-- Dead reckoning the camera rotation and focus
			debug.profilebegin("extrapolate")

			local SAMPLE_DT = 0.0625
			local SAMPLE_MAX_T = 1.25

			local maxDist = (getCollisionPoint(fP, focusExtrapolation.posVelocity*SAMPLE_MAX_T) - fP).Magnitude
			-- Metric that decides how many samples to take
			local combinedSpeed = focusExtrapolation.posVelocity.magnitude

			for dt = 0, min(SAMPLE_MAX_T, focusExtrapolation.rotVelocity.magnitude + maxDist/combinedSpeed), SAMPLE_DT do
				local cfDt = focusExtrapolation.extrapolate(dt) -- Extrapolated CFrame at time dt

				if queryPoint(cfDt.p, -cfDt.lookVector, dist) >= dist then
					return false
				end
			end

			debug.profileend()
		end

		do
			-- Test screen-space offsets from the focus for the presence of soft limits
			debug.profilebegin("testOffsets")

			for _, offset in ipairs(SCAN_SAMPLE_OFFSETS) do
				local scaledOffset = offset
				local pos = getCollisionPoint(fP, fX*scaledOffset.x + fY*scaledOffset.y)
				if queryPoint(pos, (fP + fZ*dist - pos).Unit, dist) == inf then
					return false
				end
			end

			debug.profileend()
		end

		debug.profileend()
		return true
	end

	local function Popper(focus, targetDist, focusExtrapolation)
		debug.profilebegin("popper")

		subjectRoot = subjectPart and subjectPart:GetRootPart() or subjectPart

		local dist = targetDist
		local soft, hard = queryViewport(focus, targetDist)
		if hard < dist then
			dist = hard
		end
		if soft < dist and testPromotion(focus, targetDist, focusExtrapolation) then
			dist = soft
		end

		subjectRoot = nil

		debug.profileend()
		return dist
	end

	return Popper

end))
ModuleScript22.Name = "Invisicam"
ModuleScript22.Parent = ModuleScript5
table.insert(cors,sandbox(ModuleScript22,function()
	--!nonstrict
--[[
	Invisicam - Occlusion module that makes objects occluding character view semi-transparent
	2018 Camera Update - AllYourBlox
--]]

	--[[ Top Level Roblox Services ]]--
	local PlayersService = game:GetService("Players")

	--[[ Constants ]]--
	local ZERO_VECTOR3 = Vector3.new(0,0,0)
	local USE_STACKING_TRANSPARENCY = true	-- Multiple items between the subject and camera get transparency values that add up to TARGET_TRANSPARENCY
	local TARGET_TRANSPARENCY = 0.75 -- Classic Invisicam's Value, also used by new invisicam for parts hit by head and torso rays
	local TARGET_TRANSPARENCY_PERIPHERAL = 0.5 -- Used by new SMART_CIRCLE mode for items not hit by head and torso rays

	local MODE = {
		--CUSTOM = 1, 		-- Retired, unused
		LIMBS = 2, 			-- Track limbs
		MOVEMENT = 3, 		-- Track movement
		CORNERS = 4, 		-- Char model corners
		CIRCLE1 = 5, 		-- Circle of casts around character
		CIRCLE2 = 6, 		-- Circle of casts around character, camera relative
		LIMBMOVE = 7, 		-- LIMBS mode + MOVEMENT mode
		SMART_CIRCLE = 8, 	-- More sample points on and around character
		CHAR_OUTLINE = 9,	-- Dynamic outline around the character
	}

	local LIMB_TRACKING_SET = {
		-- Body parts common to R15 and R6
		['Head'] = true,

		-- Body parts unique to R6
		['Left Arm'] = true,
		['Right Arm'] = true,
		['Left Leg'] = true,
		['Right Leg'] = true,

		-- Body parts unique to R15
		['LeftLowerArm'] = true,
		['RightLowerArm'] = true,
		['LeftUpperLeg'] = true,
		['RightUpperLeg'] = true
	}

	local CORNER_FACTORS = {
		Vector3.new(1,1,-1),
		Vector3.new(1,-1,-1),
		Vector3.new(-1,-1,-1),
		Vector3.new(-1,1,-1)
	}

	local CIRCLE_CASTS = 10
	local MOVE_CASTS = 3
	local SMART_CIRCLE_CASTS = 24
	local SMART_CIRCLE_INCREMENT = 2.0 * math.pi / SMART_CIRCLE_CASTS
	local CHAR_OUTLINE_CASTS = 24

	-- Used to sanitize user-supplied functions
	local function AssertTypes(param, ...)
		local allowedTypes = {}
		local typeString = ''
		for _, typeName in pairs({...}) do
			allowedTypes[typeName] = true
			typeString = typeString .. (typeString == '' and '' or ' or ') .. typeName
		end
		local theType = type(param)
		assert(allowedTypes[theType], typeString .. " type expected, got: " .. theType)
	end

	-- Helper function for Determinant of 3x3, not in CameraUtils for performance reasons
	local function Det3x3(a: number,b: number,c: number,d: number,e: number,f: number,g: number,h: number,i: number): number
		return (a*(e*i-f*h)-b*(d*i-f*g)+c*(d*h-e*g))
	end

	-- Smart Circle mode needs the intersection of 2 rays that are known to be in the same plane
	-- because they are generated from cross products with a common vector. This function is computing
	-- that intersection, but it's actually the general solution for the point halfway between where
	-- two skew lines come nearest to each other, which is more forgiving.
	local function RayIntersection(p0: Vector3, v0: Vector3, p1: Vector3, v1: Vector3): Vector3
		local v2 = v0:Cross(v1)
		local d1 = p1.X - p0.X
		local d2 = p1.Y - p0.Y
		local d3 = p1.Z - p0.Z
		local denom = Det3x3(v0.X,-v1.X,v2.X,v0.Y,-v1.Y,v2.Y,v0.Z,-v1.Z,v2.Z)

		if (denom == 0) then
			return ZERO_VECTOR3 -- No solution (rays are parallel)
		end

		local t0 = Det3x3(d1,-v1.X,v2.X,d2,-v1.Y,v2.Y,d3,-v1.Z,v2.Z) / denom
		local t1 = Det3x3(v0.X,d1,v2.X,v0.Y,d2,v2.Y,v0.Z,d3,v2.Z) / denom
		local s0 = p0 + t0 * v0
		local s1 = p1 + t1 * v1
		local s = s0 + 0.5 * ( s1 - s0 )

		-- 0.25 studs is a threshold for deciding if the rays are
		-- close enough to be considered intersecting, found through testing
		if (s1-s0).Magnitude < 0.25 then
			return s
		else
			return ZERO_VECTOR3
		end
	end



	--[[ The Module ]]--
	local BaseOcclusion = require(script.Parent:WaitForChild("BaseOcclusion"))
	local Invisicam = setmetatable({}, BaseOcclusion)
	Invisicam.__index = Invisicam

	function Invisicam.new()
		local self = setmetatable(BaseOcclusion.new(), Invisicam)

		self.char = nil
		self.humanoidRootPart = nil
		self.torsoPart = nil
		self.headPart = nil

		self.childAddedConn = nil
		self.childRemovedConn = nil

		self.behaviors = {} 	-- Map of modes to behavior fns
		self.behaviors[MODE.LIMBS] = self.LimbBehavior
		self.behaviors[MODE.MOVEMENT] = self.MoveBehavior
		self.behaviors[MODE.CORNERS] = self.CornerBehavior
		self.behaviors[MODE.CIRCLE1] = self.CircleBehavior
		self.behaviors[MODE.CIRCLE2] = self.CircleBehavior
		self.behaviors[MODE.LIMBMOVE] = self.LimbMoveBehavior
		self.behaviors[MODE.SMART_CIRCLE] = self.SmartCircleBehavior
		self.behaviors[MODE.CHAR_OUTLINE] = self.CharacterOutlineBehavior

		self.mode = MODE.SMART_CIRCLE
		self.behaviorFunction = self.SmartCircleBehavior

		self.savedHits = {} 	-- Objects currently being faded in/out
		self.trackedLimbs = {}	-- Used in limb-tracking casting modes

		self.camera = game.Workspace.CurrentCamera

		self.enabled = false
		return self
	end

	function Invisicam:Enable(enable)
		self.enabled = enable

		if not enable then
			self:Cleanup()
		end
	end

	function Invisicam:GetOcclusionMode()
		return Enum.DevCameraOcclusionMode.Invisicam
	end

	--[[ Module functions ]]--
	function Invisicam:LimbBehavior(castPoints)
		for limb, _ in pairs(self.trackedLimbs) do
			castPoints[#castPoints + 1] = limb.Position
		end
	end

	function Invisicam:MoveBehavior(castPoints)
		for i = 1, MOVE_CASTS do
			local position: Vector3, velocity: Vector3 = self.humanoidRootPart.Position, self.humanoidRootPart.Velocity
			local horizontalSpeed: number = Vector3.new(velocity.X, 0, velocity.Z).Magnitude / 2
			local offsetVector: Vector3 = (i - 1) * self.humanoidRootPart.CFrame.lookVector :: Vector3 * horizontalSpeed
			castPoints[#castPoints + 1] = position + offsetVector
		end
	end

	function Invisicam:CornerBehavior(castPoints)
		local cframe: CFrame = self.humanoidRootPart.CFrame
		local centerPoint: Vector3 = cframe.Position
		local rotation = cframe - centerPoint
		local halfSize = self.char:GetExtentsSize() / 2 --NOTE: Doesn't update w/ limb animations
		castPoints[#castPoints + 1] = centerPoint
		for i = 1, #CORNER_FACTORS do
			castPoints[#castPoints + 1] = centerPoint + (rotation * (halfSize * CORNER_FACTORS[i]))
		end
	end

	function Invisicam:CircleBehavior(castPoints)
		local cframe: CFrame
		if self.mode == MODE.CIRCLE1 then
			cframe = self.humanoidRootPart.CFrame
		else
			local camCFrame: CFrame = self.camera.CoordinateFrame
			cframe = camCFrame - camCFrame.Position + self.humanoidRootPart.Position
		end
		castPoints[#castPoints + 1] = cframe.Position
		for i = 0, CIRCLE_CASTS - 1 do
			local angle = (2 * math.pi / CIRCLE_CASTS) * i
			local offset = 3 * Vector3.new(math.cos(angle), math.sin(angle), 0)
			castPoints[#castPoints + 1] = cframe * offset
		end
	end

	function Invisicam:LimbMoveBehavior(castPoints)
		self:LimbBehavior(castPoints)
		self:MoveBehavior(castPoints)
	end

	function Invisicam:CharacterOutlineBehavior(castPoints)
		local torsoUp = self.torsoPart.CFrame.upVector.unit
		local torsoRight = self.torsoPart.CFrame.rightVector.unit

		-- Torso cross of points for interior coverage
		castPoints[#castPoints + 1] = self.torsoPart.CFrame.p
		castPoints[#castPoints + 1] = self.torsoPart.CFrame.p + torsoUp
		castPoints[#castPoints + 1] = self.torsoPart.CFrame.p - torsoUp
		castPoints[#castPoints + 1] = self.torsoPart.CFrame.p + torsoRight
		castPoints[#castPoints + 1] = self.torsoPart.CFrame.p - torsoRight
		if self.headPart then
			castPoints[#castPoints + 1] = self.headPart.CFrame.p
		end

		local cframe = CFrame.new(ZERO_VECTOR3,Vector3.new(self.camera.CoordinateFrame.lookVector.X,0,self.camera.CoordinateFrame.lookVector.Z))
		local centerPoint = (self.torsoPart and self.torsoPart.Position or self.humanoidRootPart.Position)

		local partsWhitelist = {self.torsoPart}
		if self.headPart then
			partsWhitelist[#partsWhitelist + 1] = self.headPart
		end

		for i = 1, CHAR_OUTLINE_CASTS do
			local angle = (2 * math.pi * i / CHAR_OUTLINE_CASTS)
			local offset = cframe * (3 * Vector3.new(math.cos(angle), math.sin(angle), 0))

			offset = Vector3.new(offset.X, math.max(offset.Y, -2.25), offset.Z)

			local ray = Ray.new(centerPoint + offset, -3 * offset)
			local hit, hitPoint = game.Workspace:FindPartOnRayWithWhitelist(ray, partsWhitelist, false)

			if hit then
				-- Use hit point as the cast point, but nudge it slightly inside the character so that bumping up against
				-- walls is less likely to cause a transparency glitch
				castPoints[#castPoints + 1] = hitPoint + 0.2 * (centerPoint - hitPoint).unit
			end
		end
	end

	function Invisicam:SmartCircleBehavior(castPoints)
		local torsoUp = self.torsoPart.CFrame.upVector.unit
		local torsoRight = self.torsoPart.CFrame.rightVector.unit

		-- SMART_CIRCLE mode includes rays to head and 5 to the torso.
		-- Hands, arms, legs and feet are not included since they
		-- are not canCollide and can therefore go inside of parts
		castPoints[#castPoints + 1] = self.torsoPart.CFrame.p
		castPoints[#castPoints + 1] = self.torsoPart.CFrame.p + torsoUp
		castPoints[#castPoints + 1] = self.torsoPart.CFrame.p - torsoUp
		castPoints[#castPoints + 1] = self.torsoPart.CFrame.p + torsoRight
		castPoints[#castPoints + 1] = self.torsoPart.CFrame.p - torsoRight
		if self.headPart then
			castPoints[#castPoints + 1] = self.headPart.CFrame.p
		end

		local cameraOrientation = self.camera.CFrame - self.camera.CFrame.p
		local torsoPoint = Vector3.new(0,0.5,0) + (self.torsoPart and self.torsoPart.Position or self.humanoidRootPart.Position)
		local radius = 2.5

		-- This loop first calculates points in a circle of radius 2.5 around the torso of the character, in the
		-- plane orthogonal to the camera's lookVector. Each point is then raycast to, to determine if it is within
		-- the free space surrounding the player (not inside anything). Two iterations are done to adjust points that
		-- are inside parts, to try to move them to valid locations that are still on their camera ray, so that the
		-- circle remains circular from the camera's perspective, but does not cast rays into walls or parts that are
		-- behind, below or beside the character and not really obstructing view of the character. This minimizes
		-- the undesirable situation where the character walks up to an exterior wall and it is made invisible even
		-- though it is behind the character.
		for i = 1, SMART_CIRCLE_CASTS do
			local angle = SMART_CIRCLE_INCREMENT * i - 0.5 * math.pi
			local offset = radius * Vector3.new(math.cos(angle), math.sin(angle), 0)
			local circlePoint = torsoPoint + cameraOrientation * offset

			-- Vector from camera to point on the circle being tested
			local vp = circlePoint - self.camera.CFrame.p

			local ray = Ray.new(torsoPoint, circlePoint - torsoPoint)
			local hit, hp, hitNormal = game.Workspace:FindPartOnRayWithIgnoreList(ray, {self.char}, false, false )
			local castPoint = circlePoint

			if hit then
				local hprime = hp + 0.1 * hitNormal.unit -- Slightly offset hit point from the hit surface
				local v0 = hprime - torsoPoint -- Vector from torso to offset hit point

				local perp = (v0:Cross(vp)).unit

				-- Vector from the offset hit point, along the hit surface
				local v1 = (perp:Cross(hitNormal)).unit

				-- Vector from camera to offset hit
				local vprime = (hprime - self.camera.CFrame.p).unit

				-- This dot product checks to see if the vector along the hit surface would hit the correct
				-- side of the invisicam cone, or if it would cross the camera look vector and hit the wrong side
				if ( v0.unit:Dot(-v1) < v0.unit:Dot(vprime)) then
					castPoint = RayIntersection(hprime, v1, circlePoint, vp)

					if castPoint.Magnitude > 0 then
						local ray = Ray.new(hprime, castPoint - hprime)
						local hit, hitPoint, hitNormal = game.Workspace:FindPartOnRayWithIgnoreList(ray, {self.char}, false, false )

						if hit then
							local hprime2 = hitPoint + 0.1 * hitNormal.unit
							castPoint = hprime2
						end
					else
						castPoint = hprime
					end
				else
					castPoint = hprime
				end

				local ray = Ray.new(torsoPoint, (castPoint - torsoPoint))
				local hit, hitPoint, hitNormal = game.Workspace:FindPartOnRayWithIgnoreList(ray, {self.char}, false, false )

				if hit then
					local castPoint2 = hitPoint - 0.1 * (castPoint - torsoPoint).unit
					castPoint = castPoint2
				end
			end

			castPoints[#castPoints + 1] = castPoint
		end
	end

	function Invisicam:CheckTorsoReference()
		if self.char then
			self.torsoPart = self.char:FindFirstChild("Torso")
			if not self.torsoPart then
				self.torsoPart = self.char:FindFirstChild("UpperTorso")
				if not self.torsoPart then
					self.torsoPart = self.char:FindFirstChild("HumanoidRootPart")
				end
			end

			self.headPart = self.char:FindFirstChild("Head")
		end
	end

	function Invisicam:CharacterAdded(char: Model, player: Player)
		-- We only want the LocalPlayer's character
		if player~=PlayersService.LocalPlayer then return end

		if self.childAddedConn then
			self.childAddedConn:Disconnect()
			self.childAddedConn = nil
		end
		if self.childRemovedConn then
			self.childRemovedConn:Disconnect()
			self.childRemovedConn = nil
		end

		self.char = char

		self.trackedLimbs = {}
		local function childAdded(child)
			if child:IsA("BasePart") then
				if LIMB_TRACKING_SET[child.Name] then
					self.trackedLimbs[child] = true
				end

				if child.Name == "Torso" or child.Name == "UpperTorso" then
					self.torsoPart = child
				end

				if child.Name == "Head" then
					self.headPart = child
				end
			end
		end

		local function childRemoved(child)
			self.trackedLimbs[child] = nil

			-- If removed/replaced part is 'Torso' or 'UpperTorso' double check that we still have a TorsoPart to use
			self:CheckTorsoReference()
		end

		self.childAddedConn = char.ChildAdded:Connect(childAdded)
		self.childRemovedConn = char.ChildRemoved:Connect(childRemoved)
		for _, child in pairs(self.char:GetChildren()) do
			childAdded(child)
		end
	end

	function Invisicam:SetMode(newMode: number)
		AssertTypes(newMode, 'number')
		for _, modeNum in pairs(MODE) do
			if modeNum == newMode then
				self.mode = newMode
				self.behaviorFunction = self.behaviors[self.mode]
				return
			end
		end
		error("Invalid mode number")
	end

	function Invisicam:GetObscuredParts()
		return self.savedHits
	end

	-- Want to turn off Invisicam? Be sure to call this after.
	function Invisicam:Cleanup()
		for hit, originalFade in pairs(self.savedHits) do
			hit.LocalTransparencyModifier = originalFade
		end
	end

	function Invisicam:Update(dt: number, desiredCameraCFrame: CFrame, desiredCameraFocus: CFrame): (CFrame, CFrame)
		-- Bail if there is no Character
		if not self.enabled or not self.char then
			return desiredCameraCFrame, desiredCameraFocus
		end

		self.camera = game.Workspace.CurrentCamera

		-- TODO: Move this to a GetHumanoidRootPart helper, probably combine with CheckTorsoReference
		-- Make sure we still have a HumanoidRootPart
		if not self.humanoidRootPart then
			local humanoid = self.char:FindFirstChildOfClass("Humanoid")
			if humanoid and humanoid.RootPart then
				self.humanoidRootPart = humanoid.RootPart
			else
				-- Not set up with Humanoid? Try and see if there's one in the Character at all:
				self.humanoidRootPart = self.char:FindFirstChild("HumanoidRootPart")
				if not self.humanoidRootPart then
					-- Bail out, since we're relying on HumanoidRootPart existing
					return desiredCameraCFrame, desiredCameraFocus
				end
			end

			-- TODO: Replace this with something more sensible
			local ancestryChangedConn
			ancestryChangedConn = self.humanoidRootPart.AncestryChanged:Connect(function(child, parent)
				if child == self.humanoidRootPart and not parent then
					self.humanoidRootPart = nil
					if ancestryChangedConn and ancestryChangedConn.Connected then
						ancestryChangedConn:Disconnect()
						ancestryChangedConn = nil
					end
				end
			end)
		end

		if not self.torsoPart then
			self:CheckTorsoReference()
			if not self.torsoPart then
				-- Bail out, since we're relying on Torso existing, should never happen since we fall back to using HumanoidRootPart as torso
				return desiredCameraCFrame, desiredCameraFocus
			end
		end

		-- Make a list of world points to raycast to
		local castPoints = {}
		self.behaviorFunction(self, castPoints)

		-- Cast to get a list of objects between the camera and the cast points
		local currentHits = {}
		local ignoreList = {self.char}
		local function add(hit)
			currentHits[hit] = true
			if not self.savedHits[hit] then
				self.savedHits[hit] = hit.LocalTransparencyModifier
			end
		end

		local hitParts
		local hitPartCount = 0

		-- Hash table to treat head-ray-hit parts differently than the rest of the hit parts hit by other rays
		-- head/torso ray hit parts will be more transparent than peripheral parts when USE_STACKING_TRANSPARENCY is enabled
		local headTorsoRayHitParts = {}

		local perPartTransparencyHeadTorsoHits = TARGET_TRANSPARENCY
		local perPartTransparencyOtherHits = TARGET_TRANSPARENCY

		if USE_STACKING_TRANSPARENCY then

			-- This first call uses head and torso rays to find out how many parts are stacked up
			-- for the purpose of calculating required per-part transparency
			local headPoint = self.headPart and self.headPart.CFrame.p or castPoints[1]
			local torsoPoint = self.torsoPart and self.torsoPart.CFrame.p or castPoints[2]
			hitParts = self.camera:GetPartsObscuringTarget({headPoint, torsoPoint}, ignoreList)

			-- Count how many things the sample rays passed through, including decals. This should only
			-- count decals facing the camera, but GetPartsObscuringTarget does not return surface normals,
			-- so my compromise for now is to just let any decal increase the part count by 1. Only one
			-- decal per part will be considered.
			for i = 1, #hitParts do
				local hitPart = hitParts[i]
				hitPartCount = hitPartCount + 1 -- count the part itself
				headTorsoRayHitParts[hitPart] = true
				for _, child in pairs(hitPart:GetChildren()) do
					if child:IsA('Decal') or child:IsA('Texture') then
						hitPartCount = hitPartCount + 1 -- count first decal hit, then break
						break
					end
				end
			end

			if (hitPartCount > 0) then
				perPartTransparencyHeadTorsoHits = math.pow( ((0.5 * TARGET_TRANSPARENCY) + (0.5 * TARGET_TRANSPARENCY / hitPartCount)), 1 / hitPartCount )
				perPartTransparencyOtherHits = math.pow( ((0.5 * TARGET_TRANSPARENCY_PERIPHERAL) + (0.5 * TARGET_TRANSPARENCY_PERIPHERAL / hitPartCount)), 1 / hitPartCount )
			end
		end

		-- Now get all the parts hit by all the rays
		hitParts = self.camera:GetPartsObscuringTarget(castPoints, ignoreList)

		local partTargetTransparency = {}

		-- Include decals and textures
		for i = 1, #hitParts do
			local hitPart = hitParts[i]

			partTargetTransparency[hitPart] =headTorsoRayHitParts[hitPart] and perPartTransparencyHeadTorsoHits or perPartTransparencyOtherHits

			-- If the part is not already as transparent or more transparent than what invisicam requires, add it to the list of
			-- parts to be modified by invisicam
			if hitPart.Transparency < partTargetTransparency[hitPart] then
				add(hitPart)
			end

			-- Check all decals and textures on the part
			for _, child in pairs(hitPart:GetChildren()) do
				if child:IsA('Decal') or child:IsA('Texture') then
					if (child.Transparency < partTargetTransparency[hitPart]) then
						partTargetTransparency[child] = partTargetTransparency[hitPart]
						add(child)
					end
				end
			end
		end

		-- Invisibilize objects that are in the way, restore those that aren't anymore
		for hitPart, originalLTM in pairs(self.savedHits) do
			if currentHits[hitPart] then
				-- LocalTransparencyModifier gets whatever value is required to print the part's total transparency to equal perPartTransparency
				hitPart.LocalTransparencyModifier = (hitPart.Transparency < 1) and ((partTargetTransparency[hitPart] - hitPart.Transparency) / (1.0 - hitPart.Transparency)) or 0
			else -- Restore original pre-invisicam value of LTM
				hitPart.LocalTransparencyModifier = originalLTM
				self.savedHits[hitPart] = nil
			end
		end

		-- Invisicam does not change the camera values
		return desiredCameraCFrame, desiredCameraFocus
	end

	return Invisicam

end))
ModuleScript23.Name = "ClassicCamera"
ModuleScript23.Parent = ModuleScript5
table.insert(cors,sandbox(ModuleScript23,function()
	--!nonstrict
--[[
	ClassicCamera - Classic Roblox camera control module
	2018 Camera Update - AllYourBlox

	Note: This module also handles camera control types Follow and Track, the
	latter of which is currently not distinguished from Classic
--]]

	-- Local private variables and constants

	local ZERO_VECTOR2 = Vector2.new(0,0)

	local tweenAcceleration = math.rad(220) -- Radians/Second^2
	local tweenSpeed = math.rad(0)          -- Radians/Second
	local tweenMaxSpeed = math.rad(250)     -- Radians/Second
	local TIME_BEFORE_AUTO_ROTATE = 2       -- Seconds, used when auto-aligning camera with vehicles

	local INITIAL_CAMERA_ANGLE = CFrame.fromOrientation(math.rad(-15), 0, 0)
	local ZOOM_SENSITIVITY_CURVATURE = 0.5
	local FIRST_PERSON_DISTANCE_MIN = 0.5

	--[[ Services ]]--
	local PlayersService = game:GetService("Players")
	local VRService = game:GetService("VRService")

	local CameraInput = require(script.Parent:WaitForChild("CameraInput"))
	local Util = require(script.Parent:WaitForChild("CameraUtils"))

	--[[ The Module ]]--
	local BaseCamera = require(script.Parent:WaitForChild("BaseCamera"))
	local ClassicCamera = setmetatable({}, BaseCamera)
	ClassicCamera.__index = ClassicCamera

	function ClassicCamera.new()
		local self = setmetatable(BaseCamera.new(), ClassicCamera)

		self.isFollowCamera = false
		self.isCameraToggle = false
		self.lastUpdate = tick()
		self.cameraToggleSpring = Util.Spring.new(5, 0)

		return self
	end

	function ClassicCamera:GetCameraToggleOffset(dt: number)
		if self.isCameraToggle then
			local zoom = self.currentSubjectDistance

			if CameraInput.getTogglePan() then
				self.cameraToggleSpring.goal = math.clamp(Util.map(zoom, 0.5, self.FIRST_PERSON_DISTANCE_THRESHOLD, 0, 1), 0, 1)
			else
				self.cameraToggleSpring.goal = 0
			end

			local distanceOffset: number = math.clamp(Util.map(zoom, 0.5, 64, 0, 1), 0, 1) + 1
			return Vector3.new(0, self.cameraToggleSpring:step(dt)*distanceOffset, 0)
		end

		return Vector3.new()
	end

	-- Movement mode standardized to Enum.ComputerCameraMovementMode values
	function ClassicCamera:SetCameraMovementMode(cameraMovementMode: Enum.ComputerCameraMovementMode)
		BaseCamera.SetCameraMovementMode(self, cameraMovementMode)

		self.isFollowCamera = cameraMovementMode == Enum.ComputerCameraMovementMode.Follow
		self.isCameraToggle = cameraMovementMode == Enum.ComputerCameraMovementMode.CameraToggle
	end

	function ClassicCamera:Update()
		local now = tick()
		local timeDelta = now - self.lastUpdate

		local camera = workspace.CurrentCamera
		local newCameraCFrame = camera.CFrame
		local newCameraFocus = camera.Focus

		local overrideCameraLookVector = nil
		if self.resetCameraAngle then
			local rootPart: BasePart = self:GetHumanoidRootPart()
			if rootPart then
				overrideCameraLookVector = (rootPart.CFrame * INITIAL_CAMERA_ANGLE).lookVector
			else
				overrideCameraLookVector = INITIAL_CAMERA_ANGLE.lookVector
			end
			self.resetCameraAngle = false
		end

		local player = PlayersService.LocalPlayer
		local humanoid = self:GetHumanoid()
		local cameraSubject = camera.CameraSubject
		local isInVehicle = cameraSubject and cameraSubject:IsA("VehicleSeat")
		local isOnASkateboard = cameraSubject and cameraSubject:IsA("SkateboardPlatform")
		local isClimbing = humanoid and humanoid:GetState() == Enum.HumanoidStateType.Climbing

		if self.lastUpdate == nil or timeDelta > 1 then
			self.lastCameraTransform = nil
		end

		local rotateInput = CameraInput.getRotation()

		self:StepZoom()

		local cameraHeight = self:GetCameraHeight()

		-- Reset tween speed if user is panning
		if CameraInput.getRotation() ~= Vector2.new() then
			tweenSpeed = 0
			self.lastUserPanCamera = tick()
		end

		local userRecentlyPannedCamera = now - self.lastUserPanCamera < TIME_BEFORE_AUTO_ROTATE
		local subjectPosition: Vector3 = self:GetSubjectPosition()

		if subjectPosition and player and camera then
			local zoom = self:GetCameraToSubjectDistance()
			if zoom < 0.5 then
				zoom = 0.5
			end

			if self:GetIsMouseLocked() and not self:IsInFirstPerson() then
				-- We need to use the right vector of the camera after rotation, not before
				local newLookCFrame: CFrame = self:CalculateNewLookCFrameFromArg(overrideCameraLookVector, rotateInput)

				local offset: Vector3 = self:GetMouseLockOffset()
				local cameraRelativeOffset: Vector3 = offset.X * newLookCFrame.RightVector + offset.Y * newLookCFrame.UpVector + offset.Z * newLookCFrame.LookVector

				--offset can be NAN, NAN, NAN if newLookVector has only y component
				if Util.IsFiniteVector3(cameraRelativeOffset) then
					subjectPosition = subjectPosition + cameraRelativeOffset
				end
			else
				local userPanningTheCamera = CameraInput.getRotation() ~= Vector2.new()

				if not userPanningTheCamera and self.lastCameraTransform then

					local isInFirstPerson = self:IsInFirstPerson()

					if (isInVehicle or isOnASkateboard or (self.isFollowCamera and isClimbing)) and self.lastUpdate and humanoid and humanoid.Torso then
						if isInFirstPerson then
							if self.lastSubjectCFrame and (isInVehicle or isOnASkateboard) and cameraSubject:IsA("BasePart") then
								local y = -Util.GetAngleBetweenXZVectors(self.lastSubjectCFrame.lookVector, cameraSubject.CFrame.lookVector)
								if Util.IsFinite(y) then
									rotateInput = rotateInput + Vector2.new(y, 0)
								end
								tweenSpeed = 0
							end
						elseif not userRecentlyPannedCamera then
							local forwardVector = humanoid.Torso.CFrame.lookVector
							tweenSpeed = math.clamp(tweenSpeed + tweenAcceleration * timeDelta, 0, tweenMaxSpeed)

							local percent = math.clamp(tweenSpeed * timeDelta, 0, 1)
							if self:IsInFirstPerson() and not (self.isFollowCamera and self.isClimbing) then
								percent = 1
							end

							local y = Util.GetAngleBetweenXZVectors(forwardVector, self:GetCameraLookVector())
							if Util.IsFinite(y) and math.abs(y) > 0.0001 then
								rotateInput = rotateInput + Vector2.new(y * percent, 0)
							end
						end

					elseif self.isFollowCamera and (not (isInFirstPerson or userRecentlyPannedCamera) and not VRService.VREnabled) then
						-- Logic that was unique to the old FollowCamera module
						local lastVec = -(self.lastCameraTransform.p - subjectPosition)

						local y = Util.GetAngleBetweenXZVectors(lastVec, self:GetCameraLookVector())

						-- This cutoff is to decide if the humanoid's angle of movement,
						-- relative to the camera's look vector, is enough that
						-- we want the camera to be following them. The point is to provide
						-- a sizable dead zone to allow more precise forward movements.
						local thetaCutoff = 0.4

						-- Check for NaNs
						if Util.IsFinite(y) and math.abs(y) > 0.0001 and math.abs(y) > thetaCutoff * timeDelta then
							rotateInput = rotateInput + Vector2.new(y, 0)
						end
					end
				end
			end

			if not self.isFollowCamera then
				local VREnabled = VRService.VREnabled

				if VREnabled then
					newCameraFocus = self:GetVRFocus(subjectPosition, timeDelta)
				else
					newCameraFocus = CFrame.new(subjectPosition)
				end

				local cameraFocusP = newCameraFocus.p
				if VREnabled and not self:IsInFirstPerson() then
					local vecToSubject = (subjectPosition - camera.CFrame.p)
					local distToSubject = vecToSubject.magnitude

					local flaggedRotateInput = rotateInput

					-- Only move the camera if it exceeded a maximum distance to the subject in VR
					if distToSubject > zoom or flaggedRotateInput.x ~= 0 then
						local desiredDist = math.min(distToSubject, zoom)
						vecToSubject = self:CalculateNewLookVectorFromArg(nil, rotateInput) * desiredDist
						local newPos = cameraFocusP - vecToSubject
						local desiredLookDir = camera.CFrame.lookVector
						if flaggedRotateInput.x ~= 0 then
							desiredLookDir = vecToSubject
						end
						local lookAt = Vector3.new(newPos.x + desiredLookDir.x, newPos.y, newPos.z + desiredLookDir.z)

						newCameraCFrame = CFrame.new(newPos, lookAt) + Vector3.new(0, cameraHeight, 0)
					end
				else
					local newLookVector = self:CalculateNewLookVectorFromArg(overrideCameraLookVector, rotateInput)
					newCameraCFrame = CFrame.new(cameraFocusP - (zoom * newLookVector), cameraFocusP)
				end
			else -- is FollowCamera
				local newLookVector = self:CalculateNewLookVectorFromArg(overrideCameraLookVector, rotateInput)

				if VRService.VREnabled then
					newCameraFocus = self:GetVRFocus(subjectPosition, timeDelta)
				else
					newCameraFocus = CFrame.new(subjectPosition)
				end
				newCameraCFrame = CFrame.new(newCameraFocus.p - (zoom * newLookVector), newCameraFocus.p) + Vector3.new(0, cameraHeight, 0)
			end

			local toggleOffset = self:GetCameraToggleOffset(timeDelta)
			newCameraFocus = newCameraFocus + toggleOffset
			newCameraCFrame = newCameraCFrame + toggleOffset

			self.lastCameraTransform = newCameraCFrame
			self.lastCameraFocus = newCameraFocus
			if (isInVehicle or isOnASkateboard) and cameraSubject:IsA("BasePart") then
				self.lastSubjectCFrame = cameraSubject.CFrame
			else
				self.lastSubjectCFrame = nil
			end
		end

		self.lastUpdate = now
		return newCameraCFrame, newCameraFocus
	end

	return ClassicCamera

end))
ModuleScript24.Name = "OrbitalCamera"
ModuleScript24.Parent = ModuleScript5
table.insert(cors,sandbox(ModuleScript24,function()
	--!nonstrict
--[[
	OrbitalCamera - Spherical coordinates control camera for top-down games
	2018 Camera Update - AllYourBlox
--]]

	-- Local private variables and constants
	local UNIT_Z = Vector3.new(0,0,1)
	local X1_Y0_Z1 = Vector3.new(1,0,1)	--Note: not a unit vector, used for projecting onto XZ plane
	local ZERO_VECTOR3 = Vector3.new(0,0,0)
	local TAU = 2 * math.pi

	-- Do not edit these values, they are not the developer-set limits, they are limits
	-- to the values the camera system equations can correctly handle
	local MIN_ALLOWED_ELEVATION_DEG = -80
	local MAX_ALLOWED_ELEVATION_DEG = 80

	local externalProperties = {}
	externalProperties["InitialDistance"]  = 25
	externalProperties["MinDistance"]      = 10
	externalProperties["MaxDistance"]      = 100
	externalProperties["InitialElevation"] = 35
	externalProperties["MinElevation"]     = 35
	externalProperties["MaxElevation"]     = 35
	externalProperties["ReferenceAzimuth"] = -45	-- Angle around the Y axis where the camera starts. -45 offsets the camera in the -X and +Z directions equally
	externalProperties["CWAzimuthTravel"]  = 90	-- How many degrees the camera is allowed to rotate from the reference position, CW as seen from above
	externalProperties["CCWAzimuthTravel"] = 90	-- How many degrees the camera is allowed to rotate from the reference position, CCW as seen from above
	externalProperties["UseAzimuthLimits"] = false -- Full rotation around Y axis available by default

	local Util = require(script.Parent:WaitForChild("CameraUtils"))
	local CameraInput = require(script.Parent:WaitForChild("CameraInput"))

	--[[ Services ]]--
	local PlayersService = game:GetService('Players')
	local VRService = game:GetService("VRService")

	--[[ The Module ]]--
	local BaseCamera = require(script.Parent:WaitForChild("BaseCamera"))
	local OrbitalCamera = setmetatable({}, BaseCamera)
	OrbitalCamera.__index = OrbitalCamera


	function OrbitalCamera.new()
		local self = setmetatable(BaseCamera.new(), OrbitalCamera)

		self.lastUpdate = tick()

		-- OrbitalCamera-specific members
		self.changedSignalConnections = {}
		self.refAzimuthRad = nil
		self.curAzimuthRad = nil
		self.minAzimuthAbsoluteRad = nil
		self.maxAzimuthAbsoluteRad = nil
		self.useAzimuthLimits = nil
		self.curElevationRad = nil
		self.minElevationRad = nil
		self.maxElevationRad = nil
		self.curDistance = nil
		self.minDistance = nil
		self.maxDistance = nil

		self.gamepadDollySpeedMultiplier = 1

		self.lastUserPanCamera = tick()

		self.externalProperties = {}
		self.externalProperties["InitialDistance"] 	= 25
		self.externalProperties["MinDistance"] 		= 10
		self.externalProperties["MaxDistance"] 		= 100
		self.externalProperties["InitialElevation"] 	= 35
		self.externalProperties["MinElevation"] 		= 35
		self.externalProperties["MaxElevation"] 		= 35
		self.externalProperties["ReferenceAzimuth"] 	= -45	-- Angle around the Y axis where the camera starts. -45 offsets the camera in the -X and +Z directions equally
		self.externalProperties["CWAzimuthTravel"] 	= 90	-- How many degrees the camera is allowed to rotate from the reference position, CW as seen from above
		self.externalProperties["CCWAzimuthTravel"] 	= 90	-- How many degrees the camera is allowed to rotate from the reference position, CCW as seen from above
		self.externalProperties["UseAzimuthLimits"] 	= false -- Full rotation around Y axis available by default
		self:LoadNumberValueParameters()

		return self
	end

	function OrbitalCamera:LoadOrCreateNumberValueParameter(name: string, valueType, updateFunction)
		local valueObj = script:FindFirstChild(name)

		if valueObj and valueObj:isA(valueType) then
			-- Value object exists and is the correct type, use its value
			self.externalProperties[name] = valueObj.Value
		elseif self.externalProperties[name] ~= nil then
			-- Create missing (or replace incorrectly-typed) valueObject with default value
			valueObj = Instance.new(valueType)
			valueObj.Name = name
			valueObj.Parent = script
			valueObj.Value = self.externalProperties[name]
		else
			return
		end

		if updateFunction then
			if self.changedSignalConnections[name] then
				self.changedSignalConnections[name]:Disconnect()
			end
			self.changedSignalConnections[name] = valueObj.Changed:Connect(function(newValue)
				self.externalProperties[name] = newValue
				updateFunction(self)
			end)
		end
	end

	function OrbitalCamera:SetAndBoundsCheckAzimuthValues()
		self.minAzimuthAbsoluteRad = math.rad(self.externalProperties["ReferenceAzimuth"]) - math.abs(math.rad(self.externalProperties["CWAzimuthTravel"]))
		self.maxAzimuthAbsoluteRad = math.rad(self.externalProperties["ReferenceAzimuth"]) + math.abs(math.rad(self.externalProperties["CCWAzimuthTravel"]))
		self.useAzimuthLimits = self.externalProperties["UseAzimuthLimits"]
		if self.useAzimuthLimits then
			self.curAzimuthRad = math.max(self.curAzimuthRad, self.minAzimuthAbsoluteRad)
			self.curAzimuthRad = math.min(self.curAzimuthRad, self.maxAzimuthAbsoluteRad)
		end
	end

	function OrbitalCamera:SetAndBoundsCheckElevationValues()
		-- These degree values are the direct user input values. It is deliberate that they are
		-- ranged checked only against the extremes, and not against each other. Any time one
		-- is changed, both of the internal values in radians are recalculated. This allows for
		-- A developer to change the values in any order and for the end results to be that the
		-- internal values adjust to match intent as best as possible.
		local minElevationDeg = math.max(self.externalProperties["MinElevation"], MIN_ALLOWED_ELEVATION_DEG)
		local maxElevationDeg = math.min(self.externalProperties["MaxElevation"], MAX_ALLOWED_ELEVATION_DEG)

		-- Set internal values in radians
		self.minElevationRad = math.rad(math.min(minElevationDeg, maxElevationDeg))
		self.maxElevationRad = math.rad(math.max(minElevationDeg, maxElevationDeg))
		self.curElevationRad = math.max(self.curElevationRad, self.minElevationRad)
		self.curElevationRad = math.min(self.curElevationRad, self.maxElevationRad)
	end

	function OrbitalCamera:SetAndBoundsCheckDistanceValues()
		self.minDistance = self.externalProperties["MinDistance"]
		self.maxDistance = self.externalProperties["MaxDistance"]
		self.curDistance = math.max(self.curDistance, self.minDistance)
		self.curDistance = math.min(self.curDistance, self.maxDistance)
	end

	-- This loads from, or lazily creates, NumberValue objects for exposed parameters
	function OrbitalCamera:LoadNumberValueParameters()
		-- These initial values do not require change listeners since they are read only once
		self:LoadOrCreateNumberValueParameter("InitialElevation", "NumberValue", nil)
		self:LoadOrCreateNumberValueParameter("InitialDistance", "NumberValue", nil)

		-- Note: ReferenceAzimuth is also used as an initial value, but needs a change listener because it is used in the calculation of the limits
		self:LoadOrCreateNumberValueParameter("ReferenceAzimuth", "NumberValue", self.SetAndBoundsCheckAzimuthValue)
		self:LoadOrCreateNumberValueParameter("CWAzimuthTravel", "NumberValue", self.SetAndBoundsCheckAzimuthValues)
		self:LoadOrCreateNumberValueParameter("CCWAzimuthTravel", "NumberValue", self.SetAndBoundsCheckAzimuthValues)
		self:LoadOrCreateNumberValueParameter("MinElevation", "NumberValue", self.SetAndBoundsCheckElevationValues)
		self:LoadOrCreateNumberValueParameter("MaxElevation", "NumberValue", self.SetAndBoundsCheckElevationValues)
		self:LoadOrCreateNumberValueParameter("MinDistance", "NumberValue", self.SetAndBoundsCheckDistanceValues)
		self:LoadOrCreateNumberValueParameter("MaxDistance", "NumberValue", self.SetAndBoundsCheckDistanceValues)
		self:LoadOrCreateNumberValueParameter("UseAzimuthLimits", "BoolValue", self.SetAndBoundsCheckAzimuthValues)

		-- Internal values set (in radians, from degrees), plus sanitization
		self.curAzimuthRad = math.rad(self.externalProperties["ReferenceAzimuth"])
		self.curElevationRad = math.rad(self.externalProperties["InitialElevation"])
		self.curDistance = self.externalProperties["InitialDistance"]

		self:SetAndBoundsCheckAzimuthValues()
		self:SetAndBoundsCheckElevationValues()
		self:SetAndBoundsCheckDistanceValues()
	end

	function OrbitalCamera:GetModuleName()
		return "OrbitalCamera"
	end

	function OrbitalCamera:SetInitialOrientation(humanoid: Humanoid)
		if not humanoid or not humanoid.RootPart then
			warn("OrbitalCamera could not set initial orientation due to missing humanoid")
			return
		end
		assert(humanoid.RootPart, "")
		local newDesiredLook = (humanoid.RootPart.CFrame.LookVector - Vector3.new(0,0.23,0)).Unit
		local horizontalShift = Util.GetAngleBetweenXZVectors(newDesiredLook, self:GetCameraLookVector())
		local vertShift = math.asin(self:GetCameraLookVector().Y) - math.asin(newDesiredLook.Y)
		if not Util.IsFinite(horizontalShift) then
			horizontalShift = 0
		end
		if not Util.IsFinite(vertShift) then
			vertShift = 0
		end
	end

	--[[ Functions of BaseCamera that are overridden by OrbitalCamera ]]--
	function OrbitalCamera:GetCameraToSubjectDistance()
		return self.curDistance
	end

	function OrbitalCamera:SetCameraToSubjectDistance(desiredSubjectDistance)
		local player = PlayersService.LocalPlayer
		if player then
			self.currentSubjectDistance = math.clamp(desiredSubjectDistance, self.minDistance, self.maxDistance)

			-- OrbitalCamera is not allowed to go into the first-person range
			self.currentSubjectDistance = math.max(self.currentSubjectDistance, self.FIRST_PERSON_DISTANCE_THRESHOLD)
		end
		self.inFirstPerson = false
		self:UpdateMouseBehavior()
		return self.currentSubjectDistance
	end

	function OrbitalCamera:CalculateNewLookVector(suppliedLookVector: Vector3, xyRotateVector: Vector2): Vector3
		local currLookVector: Vector3 = suppliedLookVector or self:GetCameraLookVector()
		local currPitchAngle: number = math.asin(currLookVector.Y)
		local yTheta: number = math.clamp(xyRotateVector.Y, currPitchAngle - math.rad(MAX_ALLOWED_ELEVATION_DEG), currPitchAngle - math.rad(MIN_ALLOWED_ELEVATION_DEG))
		local constrainedRotateInput: Vector2 = Vector2.new(xyRotateVector.X, yTheta)
		local startCFrame: CFrame = CFrame.new(ZERO_VECTOR3, currLookVector)
		local newLookVector: Vector3 = (CFrame.Angles(0, -constrainedRotateInput.X, 0) * startCFrame * CFrame.Angles(-constrainedRotateInput.Y,0,0)).LookVector
		return newLookVector
	end

	-- [[ Update ]]--
	function OrbitalCamera:Update(dt: number): (CFrame, CFrame)
		local now = tick()
		local timeDelta = (now - self.lastUpdate)
		local userPanningTheCamera = CameraInput.getRotation() ~= Vector2.new()
		local camera = 	workspace.CurrentCamera
		local newCameraCFrame = camera.CFrame
		local newCameraFocus = camera.Focus
		local player = PlayersService.LocalPlayer
		local cameraSubject = camera and camera.CameraSubject
		local isInVehicle = cameraSubject and cameraSubject:IsA('VehicleSeat')
		local isOnASkateboard = cameraSubject and cameraSubject:IsA('SkateboardPlatform')

		if self.lastUpdate == nil or timeDelta > 1 then
			self.lastCameraTransform = nil
		end

		-- Reset tween speed if user is panning
		if userPanningTheCamera then
			self.lastUserPanCamera = tick()
		end

		local subjectPosition = self:GetSubjectPosition()

		if subjectPosition and player and camera then

			-- Process any dollying being done by gamepad
			-- TODO: Move this
			if self.gamepadDollySpeedMultiplier ~= 1 then
				self:SetCameraToSubjectDistance(self.currentSubjectDistance * self.gamepadDollySpeedMultiplier)
			end

			local VREnabled = VRService.VREnabled
			newCameraFocus = VREnabled and self:GetVRFocus(subjectPosition, timeDelta) or CFrame.new(subjectPosition)

			local flaggedRotateInput = CameraInput.getRotation()

			local cameraFocusP = newCameraFocus.p
			if VREnabled and not self:IsInFirstPerson() then
				local cameraHeight = self:GetCameraHeight()
				local vecToSubject: Vector3 = (subjectPosition - camera.CFrame.p)
				local distToSubject: number = vecToSubject.Magnitude

				-- Only move the camera if it exceeded a maximum distance to the subject in VR
				if distToSubject > self.currentSubjectDistance or flaggedRotateInput.X ~= 0 then
					local desiredDist = math.min(distToSubject, self.currentSubjectDistance)

					-- Note that CalculateNewLookVector is overridden from BaseCamera
					vecToSubject = self:CalculateNewLookVector(vecToSubject.Unit * X1_Y0_Z1, Vector2.new(flaggedRotateInput.X, 0)) * desiredDist

					local newPos = cameraFocusP - vecToSubject
					local desiredLookDir = camera.CFrame.LookVector
					if flaggedRotateInput.X ~= 0 then
						desiredLookDir = vecToSubject
					end
					local lookAt = Vector3.new(newPos.X + desiredLookDir.X, newPos.Y, newPos.Z + desiredLookDir.Z)
					newCameraCFrame = CFrame.new(newPos, lookAt) + Vector3.new(0, cameraHeight, 0)
				end
			else
				-- rotateInput is a Vector2 of mouse movement deltas since last update
				self.curAzimuthRad = self.curAzimuthRad - flaggedRotateInput.X

				if self.useAzimuthLimits then
					self.curAzimuthRad = math.clamp(self.curAzimuthRad, self.minAzimuthAbsoluteRad, self.maxAzimuthAbsoluteRad)
				else
					self.curAzimuthRad = (self.curAzimuthRad ~= 0) and (math.sign(self.curAzimuthRad) * (math.abs(self.curAzimuthRad) % TAU)) or 0
				end

				self.curElevationRad = math.clamp(self.curElevationRad + flaggedRotateInput.Y, self.minElevationRad, self.maxElevationRad)

				local cameraPosVector = self.currentSubjectDistance * ( CFrame.fromEulerAnglesYXZ( -self.curElevationRad, self.curAzimuthRad, 0 ) * UNIT_Z )
				local camPos = subjectPosition + cameraPosVector

				newCameraCFrame = CFrame.new(camPos, subjectPosition)
			end

			self.lastCameraTransform = newCameraCFrame
			self.lastCameraFocus = newCameraFocus
			if (isInVehicle or isOnASkateboard) and cameraSubject:IsA('BasePart') then
				self.lastSubjectCFrame = cameraSubject.CFrame
			else
				self.lastSubjectCFrame = nil
			end
		end

		self.lastUpdate = now
		return newCameraCFrame, newCameraFocus
	end

	return OrbitalCamera

end))
ModuleScript25.Name = "LegacyCamera"
ModuleScript25.Parent = ModuleScript5
table.insert(cors,sandbox(ModuleScript25,function()
	--!nonstrict
--[[
	LegacyCamera - Implements legacy controller types: Attach, Fixed, Watch
	2018 Camera Update - AllYourBlox
--]]

	local ZERO_VECTOR2 = Vector2.new()
	local PITCH_LIMIT = math.rad(80)

	local Util = require(script.Parent:WaitForChild("CameraUtils"))
	local CameraInput = require(script.Parent:WaitForChild("CameraInput"))

	--[[ Services ]]--
	local PlayersService = game:GetService('Players')

	--[[ The Module ]]--
	local BaseCamera = require(script.Parent:WaitForChild("BaseCamera"))
	local LegacyCamera = setmetatable({}, BaseCamera)
	LegacyCamera.__index = LegacyCamera

	function LegacyCamera.new()
		local self = setmetatable(BaseCamera.new(), LegacyCamera)

		self.cameraType = Enum.CameraType.Fixed
		self.lastUpdate = tick()
		self.lastDistanceToSubject = nil

		return self
	end

	function LegacyCamera:GetModuleName()
		return "LegacyCamera"
	end

	--[[ Functions overridden from BaseCamera ]]--
	function LegacyCamera:SetCameraToSubjectDistance(desiredSubjectDistance)
		return BaseCamera.SetCameraToSubjectDistance(self,desiredSubjectDistance)
	end

	function LegacyCamera:Update(dt: number): (CFrame?, CFrame?)

		-- Cannot update until cameraType has been set
		if not self.cameraType then
			return nil, nil
		end

		local now = tick()
		local timeDelta = (now - self.lastUpdate)
		local camera = 	workspace.CurrentCamera
		local newCameraCFrame = camera.CFrame
		local newCameraFocus = camera.Focus
		local player = PlayersService.LocalPlayer

		if self.lastUpdate == nil or timeDelta > 1 then
			self.lastDistanceToSubject = nil
		end
		local subjectPosition: Vector3 = self:GetSubjectPosition()

		if self.cameraType == Enum.CameraType.Fixed then
			if subjectPosition and player and camera then
				local distanceToSubject = self:GetCameraToSubjectDistance()
				local newLookVector = self:CalculateNewLookVectorFromArg(nil, CameraInput.getRotation())

				newCameraFocus = camera.Focus -- Fixed camera does not change focus
				newCameraCFrame = CFrame.new(camera.CFrame.p, camera.CFrame.p + (distanceToSubject * newLookVector))
			end

		elseif self.cameraType == Enum.CameraType.Attach then
			local subjectCFrame = self:GetSubjectCFrame()
			local cameraPitch = camera.CFrame:ToEulerAnglesYXZ()
			local _, subjectYaw = subjectCFrame:ToEulerAnglesYXZ()

			cameraPitch = math.clamp(cameraPitch - CameraInput.getRotation().Y, -PITCH_LIMIT, PITCH_LIMIT)

			newCameraFocus = CFrame.new(subjectCFrame.p)*CFrame.fromEulerAnglesYXZ(cameraPitch, subjectYaw, 0)
			newCameraCFrame = newCameraFocus*CFrame.new(0, 0, self:StepZoom())

		elseif self.cameraType == Enum.CameraType.Watch then
			if subjectPosition and player and camera then
				local cameraLook = nil

				if subjectPosition == camera.CFrame.p then
					warn("Camera cannot watch subject in same position as itself")
					return camera.CFrame, camera.Focus
				end

				local humanoid = self:GetHumanoid()
				if humanoid and humanoid.RootPart then
					local diffVector = subjectPosition - camera.CFrame.p
					cameraLook = diffVector.unit

					if self.lastDistanceToSubject and self.lastDistanceToSubject == self:GetCameraToSubjectDistance() then
						-- Don't clobber the zoom if they zoomed the camera
						local newDistanceToSubject = diffVector.magnitude
						self:SetCameraToSubjectDistance(newDistanceToSubject)
					end
				end

				local distanceToSubject: number = self:GetCameraToSubjectDistance()
				local newLookVector: Vector3 = self:CalculateNewLookVectorFromArg(cameraLook, CameraInput.getRotation())

				newCameraFocus = CFrame.new(subjectPosition)
				newCameraCFrame = CFrame.new(subjectPosition - (distanceToSubject * newLookVector), subjectPosition)

				self.lastDistanceToSubject = distanceToSubject
			end
		else
			-- Unsupported type, return current values unchanged
			return camera.CFrame, camera.Focus
		end

		self.lastUpdate = now
		return newCameraCFrame, newCameraFocus
	end

	return LegacyCamera

end))
ModuleScript26.Name = "MouseLockController"
ModuleScript26.Parent = ModuleScript5
table.insert(cors,sandbox(ModuleScript26,function()
	--!nonstrict
--[[
	MouseLockController - Replacement for ShiftLockController, manages use of mouse-locked mode
	2018 Camera Update - AllYourBlox
--]]

	--[[ Constants ]]--
	local DEFAULT_MOUSE_LOCK_CURSOR = "rbxasset://textures/MouseLockedCursor.png"

	local CONTEXT_ACTION_NAME = "MouseLockSwitchAction"
	local MOUSELOCK_ACTION_PRIORITY = Enum.ContextActionPriority.Medium.Value

	--[[ Services ]]--
	local PlayersService = game:GetService("Players")
	local ContextActionService = game:GetService("ContextActionService")
	local Settings = UserSettings()	-- ignore warning
	local GameSettings = Settings.GameSettings

	--[[ Imports ]]
	local CameraUtils = require(script.Parent:WaitForChild("CameraUtils"))

	--[[ The Module ]]--
	local MouseLockController = {}
	MouseLockController.__index = MouseLockController

	function MouseLockController.new()
		local self = setmetatable({}, MouseLockController)

		self.isMouseLocked = false
		self.savedMouseCursor = nil
		self.boundKeys = {Enum.KeyCode.LeftShift, Enum.KeyCode.RightShift} -- defaults

		self.mouseLockToggledEvent = Instance.new("BindableEvent")

		local boundKeysObj = script:FindFirstChild("BoundKeys")
		if (not boundKeysObj) or (not boundKeysObj:IsA("StringValue")) then
			-- If object with correct name was found, but it's not a StringValue, destroy and replace
			if boundKeysObj then
				boundKeysObj:Destroy()
			end

			boundKeysObj = Instance.new("StringValue")
			-- Luau FIXME: should be able to infer from assignment above that boundKeysObj is not nil
			assert(boundKeysObj, "")
			boundKeysObj.Name = "BoundKeys"
			boundKeysObj.Value = "LeftShift,RightShift"
			boundKeysObj.Parent = script
		end

		if boundKeysObj then
			boundKeysObj.Changed:Connect(function(value)
				self:OnBoundKeysObjectChanged(value)
			end)
			self:OnBoundKeysObjectChanged(boundKeysObj.Value) -- Initial setup call
		end

		-- Watch for changes to user's ControlMode and ComputerMovementMode settings and update the feature availability accordingly
		GameSettings.Changed:Connect(function(property)
			if property == "ControlMode" or property == "ComputerMovementMode" then
				self:UpdateMouseLockAvailability()
			end
		end)

		-- Watch for changes to DevEnableMouseLock and update the feature availability accordingly
		PlayersService.LocalPlayer:GetPropertyChangedSignal("DevEnableMouseLock"):Connect(function()
			self:UpdateMouseLockAvailability()
		end)

		-- Watch for changes to DevEnableMouseLock and update the feature availability accordingly
		PlayersService.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(function()
			self:UpdateMouseLockAvailability()
		end)

		self:UpdateMouseLockAvailability()

		return self
	end

	function MouseLockController:GetIsMouseLocked()
		return self.isMouseLocked
	end

	function MouseLockController:GetBindableToggleEvent()
		return self.mouseLockToggledEvent.Event
	end

	function MouseLockController:GetMouseLockOffset()
		local offsetValueObj: Vector3Value = script:FindFirstChild("CameraOffset") :: Vector3Value
		if offsetValueObj and offsetValueObj:IsA("Vector3Value") then
			return offsetValueObj.Value
		else
			-- If CameraOffset object was found but not correct type, destroy
			if offsetValueObj then
				offsetValueObj:Destroy()
			end
			offsetValueObj = Instance.new("Vector3Value")
			assert(offsetValueObj, "")
			offsetValueObj.Name = "CameraOffset"
			offsetValueObj.Value = Vector3.new(1.75,0,0) -- Legacy Default Value
			offsetValueObj.Parent = script
		end

		if offsetValueObj and offsetValueObj.Value then
			return offsetValueObj.Value
		end

		return Vector3.new(1.75,0,0)
	end

	function MouseLockController:UpdateMouseLockAvailability()
		local devAllowsMouseLock = PlayersService.LocalPlayer.DevEnableMouseLock
		local devMovementModeIsScriptable = PlayersService.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.Scriptable
		local userHasMouseLockModeEnabled = GameSettings.ControlMode == Enum.ControlMode.MouseLockSwitch
		local userHasClickToMoveEnabled =  GameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove
		local MouseLockAvailable = devAllowsMouseLock and userHasMouseLockModeEnabled and not userHasClickToMoveEnabled and not devMovementModeIsScriptable

		if MouseLockAvailable~=self.enabled then
			self:EnableMouseLock(MouseLockAvailable)
		end
	end

	function MouseLockController:OnBoundKeysObjectChanged(newValue: string)
		self.boundKeys = {} -- Overriding defaults, note: possibly with nothing at all if boundKeysObj.Value is "" or contains invalid values
		for token in string.gmatch(newValue,"[^%s,]+") do
			for _, keyEnum in pairs(Enum.KeyCode:GetEnumItems()) do
				if token == keyEnum.Name then
					self.boundKeys[#self.boundKeys+1] = keyEnum :: Enum.KeyCode
					break
				end
			end
		end
		self:UnbindContextActions()
		self:BindContextActions()
	end

	--[[ Local Functions ]]--
	function MouseLockController:OnMouseLockToggled()
		self.isMouseLocked = not self.isMouseLocked

		if self.isMouseLocked then
			local cursorImageValueObj: StringValue? = script:FindFirstChild("CursorImage") :: StringValue?
			if cursorImageValueObj and cursorImageValueObj:IsA("StringValue") and cursorImageValueObj.Value then
				CameraUtils.setMouseIconOverride(cursorImageValueObj.Value)
			else
				if cursorImageValueObj then
					cursorImageValueObj:Destroy()
				end
				cursorImageValueObj = Instance.new("StringValue")
				assert(cursorImageValueObj, "")
				cursorImageValueObj.Name = "CursorImage"
				cursorImageValueObj.Value = DEFAULT_MOUSE_LOCK_CURSOR
				cursorImageValueObj.Parent = script
				CameraUtils.setMouseIconOverride(DEFAULT_MOUSE_LOCK_CURSOR)
			end
		else
			CameraUtils.restoreMouseIcon()
		end

		self.mouseLockToggledEvent:Fire()
	end

	function MouseLockController:DoMouseLockSwitch(name, state, input)
		if state == Enum.UserInputState.Begin then
			self:OnMouseLockToggled()
			return Enum.ContextActionResult.Sink
		end
		return Enum.ContextActionResult.Pass
	end

	function MouseLockController:BindContextActions()
		ContextActionService:BindActionAtPriority(CONTEXT_ACTION_NAME, function(name, state, input)
			return self:DoMouseLockSwitch(name, state, input)
		end, false, MOUSELOCK_ACTION_PRIORITY, unpack(self.boundKeys))
	end

	function MouseLockController:UnbindContextActions()
		ContextActionService:UnbindAction(CONTEXT_ACTION_NAME)
	end

	function MouseLockController:IsMouseLocked(): boolean
		return self.enabled and self.isMouseLocked
	end

	function MouseLockController:EnableMouseLock(enable: boolean)
		if enable ~= self.enabled then

			self.enabled = enable

			if self.enabled then
				-- Enabling the mode
				self:BindContextActions()
			else
				-- Disabling
				-- Restore mouse cursor
				CameraUtils.restoreMouseIcon()

				self:UnbindContextActions()

				-- If the mode is disabled while being used, fire the event to toggle it off
				if self.isMouseLocked then
					self.mouseLockToggledEvent:Fire()
				end

				self.isMouseLocked = false
			end

		end
	end

	return MouseLockController

end))
StringValue27.Name = "BoundKeys"
StringValue27.Parent = ModuleScript26
StringValue27.Value = "LeftShift,RightShift"
ModuleScript28.Name = "ControlModule"
ModuleScript28.Parent = ModuleScript4
table.insert(cors,sandbox(ModuleScript28,function()
	--!nonstrict
--[[
	ControlModule - This ModuleScript implements a singleton class to manage the
	selection, activation, and deactivation of the current character movement controller.
	This script binds to RenderStepped at Input priority and calls the Update() methods
	on the active controller instances.

	The character controller ModuleScripts implement classes which are instantiated and
	activated as-needed, they are no longer all instantiated up front as they were in
	the previous generation of PlayerScripts.

	2018 PlayerScripts Update - AllYourBlox
--]]
	local ControlModule = {}
	ControlModule.__index = ControlModule

	--[[ Roblox Services ]]--
	local Players = game:GetService("Players")
	local RunService = game:GetService("RunService")
	local UserInputService = game:GetService("UserInputService")
	local GuiService = game:GetService("GuiService")
	local Workspace = game:GetService("Workspace")
	local UserGameSettings = UserSettings():GetService("UserGameSettings")
	local VRService = game:GetService("VRService")

	-- Roblox User Input Control Modules - each returns a new() constructor function used to create controllers as needed
	local Keyboard = require(script:WaitForChild("Keyboard"))
	local Gamepad = require(script:WaitForChild("Gamepad"))
	local DynamicThumbstick = require(script:WaitForChild("DynamicThumbstick"))


	local FFlagUserVRAvatarGestures
	do
		local success, result = pcall(function()
			return UserSettings():IsUserFeatureEnabled("UserVRAvatarGestures")
		end)
		FFlagUserVRAvatarGestures = success and result
	end

	local FFlagUserDynamicThumbstickSafeAreaUpdate do
		local success, result = pcall(function()
			return UserSettings():IsUserFeatureEnabled("UserDynamicThumbstickSafeAreaUpdate")
		end)
		FFlagUserDynamicThumbstickSafeAreaUpdate = success and result
	end

	local TouchThumbstick = require(script:WaitForChild("TouchThumbstick"))

	-- These controllers handle only walk/run movement, jumping is handled by the
	-- TouchJump controller if any of these are active
	local ClickToMove = require(script:WaitForChild("ClickToMoveController"))
	local TouchJump = require(script:WaitForChild("TouchJump"))

	local VehicleController = require(script:WaitForChild("VehicleController"))

	local CONTROL_ACTION_PRIORITY = Enum.ContextActionPriority.Medium.Value
	local NECK_OFFSET = -0.7
	local FIRST_PERSON_THRESHOLD_DISTANCE = 5

	-- Mapping from movement mode and lastInputType enum values to control modules to avoid huge if elseif switching
	local movementEnumToModuleMap = {
		[Enum.TouchMovementMode.DPad] = DynamicThumbstick,
		[Enum.DevTouchMovementMode.DPad] = DynamicThumbstick,
		[Enum.TouchMovementMode.Thumbpad] = DynamicThumbstick,
		[Enum.DevTouchMovementMode.Thumbpad] = DynamicThumbstick,
		[Enum.TouchMovementMode.Thumbstick] = TouchThumbstick,
		[Enum.DevTouchMovementMode.Thumbstick] = TouchThumbstick,
		[Enum.TouchMovementMode.DynamicThumbstick] = DynamicThumbstick,
		[Enum.DevTouchMovementMode.DynamicThumbstick] = DynamicThumbstick,
		[Enum.TouchMovementMode.ClickToMove] = ClickToMove,
		[Enum.DevTouchMovementMode.ClickToMove] = ClickToMove,

		-- Current default
		[Enum.TouchMovementMode.Default] = DynamicThumbstick,

		[Enum.ComputerMovementMode.Default] = Keyboard,
		[Enum.ComputerMovementMode.KeyboardMouse] = Keyboard,
		[Enum.DevComputerMovementMode.KeyboardMouse] = Keyboard,
		[Enum.DevComputerMovementMode.Scriptable] = nil,
		[Enum.ComputerMovementMode.ClickToMove] = ClickToMove,
		[Enum.DevComputerMovementMode.ClickToMove] = ClickToMove,
	}

	-- Keyboard controller is really keyboard and mouse controller
	local computerInputTypeToModuleMap = {
		[Enum.UserInputType.Keyboard] = Keyboard,
		[Enum.UserInputType.MouseButton1] = Keyboard,
		[Enum.UserInputType.MouseButton2] = Keyboard,
		[Enum.UserInputType.MouseButton3] = Keyboard,
		[Enum.UserInputType.MouseWheel] = Keyboard,
		[Enum.UserInputType.MouseMovement] = Keyboard,
		[Enum.UserInputType.Gamepad1] = Gamepad,
		[Enum.UserInputType.Gamepad2] = Gamepad,
		[Enum.UserInputType.Gamepad3] = Gamepad,
		[Enum.UserInputType.Gamepad4] = Gamepad,
	}

	local lastInputType

	function ControlModule.new()
		local self = setmetatable({},ControlModule)

		-- The Modules above are used to construct controller instances as-needed, and this
		-- table is a map from Module to the instance created from it
		self.controllers = {}

		self.activeControlModule = nil	-- Used to prevent unnecessarily expensive checks on each input event
		self.activeController = nil
		self.touchJumpController = nil
		self.moveFunction = Players.LocalPlayer.Move
		self.humanoid = nil
		self.lastInputType = Enum.UserInputType.None
		self.controlsEnabled = true

		-- For Roblox self.vehicleController
		self.humanoidSeatedConn = nil
		self.vehicleController = nil

		self.touchControlFrame = nil
		self.currentTorsoAngle = 0

		if FFlagUserVRAvatarGestures then
			self.inputMoveVector = Vector3.new(0,0,0)
		end

		self.vehicleController = VehicleController.new(CONTROL_ACTION_PRIORITY)

		Players.LocalPlayer.CharacterAdded:Connect(function(char) self:OnCharacterAdded(char) end)
		Players.LocalPlayer.CharacterRemoving:Connect(function(char) self:OnCharacterRemoving(char) end)
		if Players.LocalPlayer.Character then
			self:OnCharacterAdded(Players.LocalPlayer.Character)
		end

		RunService:BindToRenderStep("ControlScriptRenderstep", Enum.RenderPriority.Input.Value, function(dt)
			self:OnRenderStepped(dt)
		end)

		UserInputService.LastInputTypeChanged:Connect(function(newLastInputType)
			self:OnLastInputTypeChanged(newLastInputType)
		end)


		UserGameSettings:GetPropertyChangedSignal("TouchMovementMode"):Connect(function()
			self:OnTouchMovementModeChange()
		end)
		Players.LocalPlayer:GetPropertyChangedSignal("DevTouchMovementMode"):Connect(function()
			self:OnTouchMovementModeChange()
		end)

		UserGameSettings:GetPropertyChangedSignal("ComputerMovementMode"):Connect(function()
			self:OnComputerMovementModeChange()
		end)
		Players.LocalPlayer:GetPropertyChangedSignal("DevComputerMovementMode"):Connect(function()
			self:OnComputerMovementModeChange()
		end)

		--[[ Touch Device UI ]]--
		self.playerGui = nil
		self.touchGui = nil
		self.playerGuiAddedConn = nil

		GuiService:GetPropertyChangedSignal("TouchControlsEnabled"):Connect(function()
			self:UpdateTouchGuiVisibility()
			self:UpdateActiveControlModuleEnabled()
		end)

		if UserInputService.TouchEnabled then
			self.playerGui = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")
			if self.playerGui then
				self:CreateTouchGuiContainer()
				self:OnLastInputTypeChanged(UserInputService:GetLastInputType())
			else
				self.playerGuiAddedConn = Players.LocalPlayer.ChildAdded:Connect(function(child)
					if child:IsA("PlayerGui") then
						self.playerGui = child
						self:CreateTouchGuiContainer()
						self.playerGuiAddedConn:Disconnect()
						self.playerGuiAddedConn = nil
						self:OnLastInputTypeChanged(UserInputService:GetLastInputType())
					end
				end)
			end
		else
			self:OnLastInputTypeChanged(UserInputService:GetLastInputType())
		end

		return self
	end

	-- Convenience function so that calling code does not have to first get the activeController
	-- and then call GetMoveVector on it. When there is no active controller, this function returns the
	-- zero vector
	function ControlModule:GetMoveVector(): Vector3
		if self.activeController then
			return self.activeController:GetMoveVector()
		end
		return Vector3.new(0,0,0)
	end

	local function NormalizeAngle(angle): number
		angle = (angle + math.pi*4) % (math.pi*2)
		if angle > math.pi then
			angle = angle - math.pi*2
		end
		return angle
	end

	local function AverageAngle(angleA, angleB): number
		local difference = NormalizeAngle(angleB - angleA)
		return NormalizeAngle(angleA + difference/2)
	end

	function ControlModule:GetEstimatedVRTorsoFrame(): CFrame
		local headFrame = VRService:GetUserCFrame(Enum.UserCFrame.Head)
		local _, headAngle, _ = headFrame:ToEulerAnglesYXZ()
		headAngle = -headAngle
		if not VRService:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) or 
			not VRService:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand) then
			self.currentTorsoAngle = headAngle;
		else	
			local leftHandPos = VRService:GetUserCFrame(Enum.UserCFrame.LeftHand)
			local rightHandPos = VRService:GetUserCFrame(Enum.UserCFrame.RightHand)

			local leftHandToHead = headFrame.Position - leftHandPos.Position
			local rightHandToHead = headFrame.Position - rightHandPos.Position
			local leftHandAngle = -math.atan2(leftHandToHead.X, leftHandToHead.Z)
			local rightHandAngle = -math.atan2(rightHandToHead.X, rightHandToHead.Z)
			local averageHandAngle = AverageAngle(leftHandAngle, rightHandAngle)

			local headAngleRelativeToCurrentAngle = NormalizeAngle(headAngle - self.currentTorsoAngle)
			local averageHandAngleRelativeToCurrentAngle = NormalizeAngle(averageHandAngle - self.currentTorsoAngle)

			local averageHandAngleValid =
				averageHandAngleRelativeToCurrentAngle > -math.pi/2 and
				averageHandAngleRelativeToCurrentAngle < math.pi/2

			if not averageHandAngleValid then
				averageHandAngleRelativeToCurrentAngle = headAngleRelativeToCurrentAngle
			end

			local minimumValidAngle = math.min(averageHandAngleRelativeToCurrentAngle, headAngleRelativeToCurrentAngle)
			local maximumValidAngle = math.max(averageHandAngleRelativeToCurrentAngle, headAngleRelativeToCurrentAngle)

			local relativeAngleToUse = 0
			if minimumValidAngle > 0 then
				relativeAngleToUse = minimumValidAngle
			elseif maximumValidAngle < 0 then
				relativeAngleToUse = maximumValidAngle
			end

			self.currentTorsoAngle = relativeAngleToUse + self.currentTorsoAngle
		end

		return CFrame.new(headFrame.Position) * CFrame.fromEulerAnglesYXZ(0, -self.currentTorsoAngle, 0)
	end

	function ControlModule:GetActiveController()
		return self.activeController
	end

	-- Checks for conditions for enabling/disabling the active controller and updates whether the active controller is enabled/disabled
	function ControlModule:UpdateActiveControlModuleEnabled()
		-- helpers for disable/enable
		local disable = function()
			self.activeController:Enable(false)

			if self.moveFunction then
				self.moveFunction(Players.LocalPlayer, Vector3.new(0,0,0), true)
			end
		end

		local enable = function()
			if self.activeControlModule == ClickToMove then
				-- For ClickToMove, when it is the player's choice, we also enable the full keyboard controls.
				-- When the developer is forcing click to move, the most keyboard controls (WASD) are not available, only jump.
				self.activeController:Enable(
					true,
					Players.LocalPlayer.DevComputerMovementMode == Enum.DevComputerMovementMode.UserChoice,
					self.touchJumpController
				)
			elseif self.touchControlFrame then
				self.activeController:Enable(true, self.touchControlFrame)
			else
				self.activeController:Enable(true)
			end
		end

		-- there is no active controller
		if not self.activeController then
			return
		end

		-- developer called ControlModule:Disable(), don't turn back on
		if not self.controlsEnabled then
			disable()
			return
		end

		-- GuiService.TouchControlsEnabled == false and the active controller is a touch controller,
		-- disable controls
		if not GuiService.TouchControlsEnabled and UserInputService.TouchEnabled and
			(self.activeControlModule == ClickToMove or self.activeControlModule == TouchThumbstick or
				self.activeControlModule == DynamicThumbstick) then
			disable()
			return
		end

		-- no settings prevent enabling controls
		enable()
	end

	function ControlModule:Enable(enable: boolean?)
		if enable == nil then
			enable = true
		end
		self.controlsEnabled = enable

		if not self.activeController then
			return
		end

		self:UpdateActiveControlModuleEnabled()
	end

	-- For those who prefer distinct functions
	function ControlModule:Disable()
		self.controlsEnabled = false

		self:UpdateActiveControlModuleEnabled()
	end


	-- Returns module (possibly nil) and success code to differentiate returning nil due to error vs Scriptable
	function ControlModule:SelectComputerMovementModule(): ({}?, boolean)
		if not (UserInputService.KeyboardEnabled or UserInputService.GamepadEnabled) then
			return nil, false
		end

		local computerModule
		local DevMovementMode = Players.LocalPlayer.DevComputerMovementMode

		if DevMovementMode == Enum.DevComputerMovementMode.UserChoice then
			computerModule = computerInputTypeToModuleMap[lastInputType]
			if UserGameSettings.ComputerMovementMode == Enum.ComputerMovementMode.ClickToMove and computerModule == Keyboard then
				-- User has ClickToMove set in Settings, prefer ClickToMove controller for keyboard and mouse lastInputTypes
				computerModule = ClickToMove
			end
		else
			-- Developer has selected a mode that must be used.
			computerModule = movementEnumToModuleMap[DevMovementMode]

			-- computerModule is expected to be nil here only when developer has selected Scriptable
			if (not computerModule) and DevMovementMode ~= Enum.DevComputerMovementMode.Scriptable then
				warn("No character control module is associated with DevComputerMovementMode ", DevMovementMode)
			end
		end

		if computerModule then
			return computerModule, true
		elseif DevMovementMode == Enum.DevComputerMovementMode.Scriptable then
			-- Special case where nil is returned and we actually want to set self.activeController to nil for Scriptable
			return nil, true
		else
			-- This case is for when computerModule is nil because of an error and no suitable control module could
			-- be found.
			return nil, false
		end
	end

	-- Choose current Touch control module based on settings (user, dev)
	-- Returns module (possibly nil) and success code to differentiate returning nil due to error vs Scriptable
	function ControlModule:SelectTouchModule(): ({}?, boolean)
		if not UserInputService.TouchEnabled then
			return nil, false
		end
		local touchModule
		local DevMovementMode = Players.LocalPlayer.DevTouchMovementMode
		if DevMovementMode == Enum.DevTouchMovementMode.UserChoice then
			touchModule = movementEnumToModuleMap[UserGameSettings.TouchMovementMode]
		elseif DevMovementMode == Enum.DevTouchMovementMode.Scriptable then
			return nil, true
		else
			touchModule = movementEnumToModuleMap[DevMovementMode]
		end
		return touchModule, true
	end

	local function getGamepadRightThumbstickPosition(): Vector3
		local state = UserInputService:GetGamepadState(Enum.UserInputType.Gamepad1)
		for _, input in pairs(state) do
			if input.KeyCode == Enum.KeyCode.Thumbstick2 then
				return input.Position
			end
		end
		return Vector3.new(0,0,0)
	end

	function ControlModule:calculateRawMoveVector(humanoid: Humanoid, cameraRelativeMoveVector: Vector3): Vector3
		local camera = Workspace.CurrentCamera
		if not camera then
			return cameraRelativeMoveVector
		end
		local cameraCFrame = camera.CFrame

		if VRService.VREnabled and humanoid.RootPart then
			local vrFrame = VRService:GetUserCFrame(Enum.UserCFrame.Head)

			vrFrame = self:GetEstimatedVRTorsoFrame()

			-- movement relative to VR frustum
			local cameraDelta = camera.Focus.Position - cameraCFrame.Position
			if cameraDelta.Magnitude < 3 then -- "nearly" first person
				cameraCFrame = cameraCFrame * vrFrame
			else
				cameraCFrame = camera.CFrame * (vrFrame.Rotation + vrFrame.Position * camera.HeadScale)
			end
		end

		if humanoid:GetState() == Enum.HumanoidStateType.Swimming then	
			if VRService.VREnabled then
				cameraRelativeMoveVector = Vector3.new(cameraRelativeMoveVector.X, 0, cameraRelativeMoveVector.Z)
				if cameraRelativeMoveVector.Magnitude < 0.01 then
					return Vector3.zero
				end

				local pitch = -getGamepadRightThumbstickPosition().Y * math.rad(80)
				local yawAngle = math.atan2(-cameraRelativeMoveVector.X, -cameraRelativeMoveVector.Z)
				local _, cameraYaw, _ = cameraCFrame:ToEulerAnglesYXZ()
				yawAngle += cameraYaw
				local movementCFrame = CFrame.fromEulerAnglesYXZ(pitch, yawAngle, 0)
				return movementCFrame.LookVector
			else
				return cameraCFrame:VectorToWorldSpace(cameraRelativeMoveVector)
			end
		end

		local c, s
		local _, _, _, R00, R01, R02, _, _, R12, _, _, R22 = cameraCFrame:GetComponents()
		if R12 < 1 and R12 > -1 then
			-- X and Z components from back vector.
			c = R22
			s = R02
		else
			-- In this case the camera is looking straight up or straight down.
			-- Use X components from right and up vectors.
			c = R00
			s = -R01*math.sign(R12)
		end
		local norm = math.sqrt(c*c + s*s)
		return Vector3.new(
			(c*cameraRelativeMoveVector.X + s*cameraRelativeMoveVector.Z)/norm,
			0,
			(c*cameraRelativeMoveVector.Z - s*cameraRelativeMoveVector.X)/norm
		)
	end

	function ControlModule:OnRenderStepped(dt)
		if self.activeController and self.activeController.enabled and self.humanoid then
			-- Give the controller a chance to adjust its state
			self.activeController:OnRenderStepped(dt)

			-- Now retrieve info from the controller
			local moveVector = self.activeController:GetMoveVector()
			local cameraRelative = self.activeController:IsMoveVectorCameraRelative()

			local clickToMoveController = self:GetClickToMoveController()
			if self.activeController ~= clickToMoveController then
				if moveVector.magnitude > 0 then
					-- Clean up any developer started MoveTo path
					clickToMoveController:CleanupPath()
				else
					-- Get move vector for developer started MoveTo
					clickToMoveController:OnRenderStepped(dt)
					moveVector = clickToMoveController:GetMoveVector()
					cameraRelative = clickToMoveController:IsMoveVectorCameraRelative()
				end
			end

			-- Are we driving a vehicle ?
			local vehicleConsumedInput = false
			if self.vehicleController then
				moveVector, vehicleConsumedInput = self.vehicleController:Update(moveVector, cameraRelative, self.activeControlModule==Gamepad)
			end

			-- If not, move the player
			-- Verification of vehicleConsumedInput is commented out to preserve legacy behavior,
			-- in case some game relies on Humanoid.MoveDirection still being set while in a VehicleSeat
			--if not vehicleConsumedInput then
			if cameraRelative then
				moveVector = self:calculateRawMoveVector(self.humanoid, moveVector)
			end

			if FFlagUserVRAvatarGestures then
				self.inputMoveVector = moveVector
				if VRService.VREnabled then
					moveVector = self:updateVRMoveVector(moveVector)
				end
			end

			self.moveFunction(Players.LocalPlayer, moveVector, false)
			--end

			-- And make them jump if needed
			self.humanoid.Jump = self.activeController:GetIsJumping() or (self.touchJumpController and self.touchJumpController:GetIsJumping())
		end
	end

	function ControlModule:updateVRMoveVector(moveVector)
		local curCamera = workspace.CurrentCamera :: Camera

		-- movement relative to VR frustum
		local cameraDelta = curCamera.Focus.Position - curCamera.CFrame	.Position
		local firstPerson = cameraDelta.Magnitude < FIRST_PERSON_THRESHOLD_DISTANCE and true

		-- if the player is not moving via input in first person, follow the VRHead
		if moveVector.Magnitude == 0 and firstPerson and VRService.AvatarGestures and self.humanoid then
			local vrHeadOffset = VRService:GetUserCFrame(Enum.UserCFrame.Head) 
			vrHeadOffset = vrHeadOffset.Rotation + vrHeadOffset.Position * curCamera.HeadScale

			-- get the position in world space and offset at the neck
			local neck_offset = NECK_OFFSET * self.humanoid.RootPart.Size.Y / 2
			local vrHeadWorld = curCamera.CFrame * vrHeadOffset * CFrame.new(0, neck_offset, 0)

			local moveOffset = vrHeadWorld.Position - self.humanoid.RootPart.CFrame.Position
			return Vector3.new(moveOffset.x, 0, moveOffset.z)
		end

		return moveVector
	end

	function ControlModule:OnHumanoidSeated(active: boolean, currentSeatPart: BasePart)
		if active then
			if currentSeatPart and currentSeatPart:IsA("VehicleSeat") then
				if not self.vehicleController then
					self.vehicleController = self.vehicleController.new(CONTROL_ACTION_PRIORITY)
				end
				self.vehicleController:Enable(true, currentSeatPart)
			end
		else
			if self.vehicleController then
				self.vehicleController:Enable(false, currentSeatPart)
			end
		end
	end

	function ControlModule:OnCharacterAdded(char)
		self.humanoid = char:FindFirstChildOfClass("Humanoid")
		while not self.humanoid do
			char.ChildAdded:wait()
			self.humanoid = char:FindFirstChildOfClass("Humanoid")
		end

		self:UpdateTouchGuiVisibility()

		if self.humanoidSeatedConn then
			self.humanoidSeatedConn:Disconnect()
			self.humanoidSeatedConn = nil
		end
		self.humanoidSeatedConn = self.humanoid.Seated:Connect(function(active, currentSeatPart)
			self:OnHumanoidSeated(active, currentSeatPart)
		end)
	end

	function ControlModule:OnCharacterRemoving(char)
		self.humanoid = nil

		self:UpdateTouchGuiVisibility()
	end

	function ControlModule:UpdateTouchGuiVisibility()
		if self.touchGui then
			local doShow = self.humanoid and GuiService.TouchControlsEnabled
			self.touchGui.Enabled = not not doShow -- convert to bool
		end
	end

	-- Helper function to lazily instantiate a controller if it does not yet exist,
	-- disable the active controller if it is different from the on being switched to,
	-- and then enable the requested controller. The argument to this function must be
	-- a reference to one of the control modules, i.e. Keyboard, Gamepad, etc.

	-- This function should handle all controller enabling and disabling without relying on
	-- ControlModule:Enable() and Disable()
	function ControlModule:SwitchToController(controlModule)
		-- controlModule is invalid, just disable current controller
		if not controlModule then
			if self.activeController then
				self.activeController:Enable(false)
			end
			self.activeController = nil
			self.activeControlModule = nil
			return
		end

		-- first time switching to this control module, should instantiate it
		if not self.controllers[controlModule] then
			self.controllers[controlModule] = controlModule.new(CONTROL_ACTION_PRIORITY)
		end

		-- switch to the new controlModule
		if self.activeController ~= self.controllers[controlModule] then
			if self.activeController then
				self.activeController:Enable(false)
			end
			self.activeController = self.controllers[controlModule]
			self.activeControlModule = controlModule -- Only used to check if controller switch is necessary

			if self.touchControlFrame and (self.activeControlModule == ClickToMove
				or self.activeControlModule == TouchThumbstick
				or self.activeControlModule == DynamicThumbstick) then
				if not self.controllers[TouchJump] then
					self.controllers[TouchJump] = TouchJump.new()
				end
				self.touchJumpController = self.controllers[TouchJump]
				self.touchJumpController:Enable(true, self.touchControlFrame)
			else
				if self.touchJumpController then
					self.touchJumpController:Enable(false)
				end
			end

			self:UpdateActiveControlModuleEnabled()
		end
	end

	function ControlModule:OnLastInputTypeChanged(newLastInputType)
		if lastInputType == newLastInputType then
			warn("LastInputType Change listener called with current type.")
		end
		lastInputType = newLastInputType

		if lastInputType == Enum.UserInputType.Touch then
			-- TODO: Check if touch module already active
			local touchModule, success = self:SelectTouchModule()
			if success then
				while not self.touchControlFrame do
					wait()
				end
				self:SwitchToController(touchModule)
			end
		elseif computerInputTypeToModuleMap[lastInputType] ~= nil then
			local computerModule = self:SelectComputerMovementModule()
			if computerModule then
				self:SwitchToController(computerModule)
			end
		end

		self:UpdateTouchGuiVisibility()
	end

	-- Called when any relevant values of GameSettings or LocalPlayer change, forcing re-evalulation of
	-- current control scheme
	function ControlModule:OnComputerMovementModeChange()
		local controlModule, success =  self:SelectComputerMovementModule()
		if success then
			self:SwitchToController(controlModule)
		end
	end

	function ControlModule:OnTouchMovementModeChange()
		local touchModule, success = self:SelectTouchModule()
		if success then
			while not self.touchControlFrame do
				wait()
			end
			self:SwitchToController(touchModule)
		end
	end

	function ControlModule:CreateTouchGuiContainer()
		if self.touchGui then self.touchGui:Destroy() end

		-- Container for all touch device guis
		self.touchGui = Instance.new("ScreenGui")
		self.touchGui.Name = "TouchGui"
		self.touchGui.ResetOnSpawn = false
		self.touchGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		self:UpdateTouchGuiVisibility()

		if FFlagUserDynamicThumbstickSafeAreaUpdate then
			self.touchGui.ClipToDeviceSafeArea = false;
		end

		self.touchControlFrame = Instance.new("Frame")
		self.touchControlFrame.Name = "TouchControlFrame"
		self.touchControlFrame.Size = UDim2.new(1, 0, 1, 0)
		self.touchControlFrame.BackgroundTransparency = 1
		self.touchControlFrame.Parent = self.touchGui

		self.touchGui.Parent = self.playerGui
	end

	function ControlModule:GetClickToMoveController()
		if not self.controllers[ClickToMove] then
			self.controllers[ClickToMove] = ClickToMove.new(CONTROL_ACTION_PRIORITY)
		end
		return self.controllers[ClickToMove]
	end

	return ControlModule.new()

end))
ModuleScript29.Name = "VehicleController"
ModuleScript29.Parent = ModuleScript28
table.insert(cors,sandbox(ModuleScript29,function()
	--!nonstrict
--[[
	// FileName: VehicleControl
	// Version 1.0
	// Written by: jmargh
	// Description: Implements in-game vehicle controls for all input devices

	// NOTE: This works for basic vehicles (single vehicle seat). If you use custom VehicleSeat code,
	// multiple VehicleSeats or your own implementation of a VehicleSeat this will not work.
--]]
	local ContextActionService = game:GetService("ContextActionService")

	--[[ Constants ]]--
	-- Set this to true if you want to instead use the triggers for the throttle
	local useTriggersForThrottle = true
	-- Also set this to true if you want the thumbstick to not affect throttle, only triggers when a gamepad is conected
	local onlyTriggersForThrottle = false
	local ZERO_VECTOR3 = Vector3.new(0,0,0)

	local AUTO_PILOT_DEFAULT_MAX_STEERING_ANGLE = 35


	-- Note that VehicleController does not derive from BaseCharacterController, it is a special case
	local VehicleController = {}
	VehicleController.__index = VehicleController

	function VehicleController.new(CONTROL_ACTION_PRIORITY)
		local self = setmetatable({}, VehicleController)

		self.CONTROL_ACTION_PRIORITY = CONTROL_ACTION_PRIORITY

		self.enabled = false
		self.vehicleSeat = nil
		self.throttle = 0
		self.steer = 0

		self.acceleration = 0
		self.decceleration = 0
		self.turningRight = 0
		self.turningLeft = 0

		self.vehicleMoveVector = ZERO_VECTOR3

		self.autoPilot = {}
		self.autoPilot.MaxSpeed = 0
		self.autoPilot.MaxSteeringAngle = 0

		return self
	end

	function VehicleController:BindContextActions()
		if useTriggersForThrottle then
			ContextActionService:BindActionAtPriority("throttleAccel", (function(actionName, inputState, inputObject)
				self:OnThrottleAccel(actionName, inputState, inputObject)
				return Enum.ContextActionResult.Pass
			end), false, self.CONTROL_ACTION_PRIORITY, Enum.KeyCode.ButtonR2)
			ContextActionService:BindActionAtPriority("throttleDeccel", (function(actionName, inputState, inputObject)
				self:OnThrottleDeccel(actionName, inputState, inputObject)
				return Enum.ContextActionResult.Pass
			end), false, self.CONTROL_ACTION_PRIORITY, Enum.KeyCode.ButtonL2)
		end
		ContextActionService:BindActionAtPriority("arrowSteerRight", (function(actionName, inputState, inputObject)
			self:OnSteerRight(actionName, inputState, inputObject)
			return Enum.ContextActionResult.Pass
		end), false, self.CONTROL_ACTION_PRIORITY, Enum.KeyCode.Right)
		ContextActionService:BindActionAtPriority("arrowSteerLeft", (function(actionName, inputState, inputObject)
			self:OnSteerLeft(actionName, inputState, inputObject)
			return Enum.ContextActionResult.Pass
		end), false, self.CONTROL_ACTION_PRIORITY, Enum.KeyCode.Left)
	end

	function VehicleController:Enable(enable: boolean, vehicleSeat: VehicleSeat)
		if enable == self.enabled and vehicleSeat == self.vehicleSeat then
			return
		end

		self.enabled = enable
		self.vehicleMoveVector = ZERO_VECTOR3

		if enable then
			if vehicleSeat then
				self.vehicleSeat = vehicleSeat

				self:SetupAutoPilot()
				self:BindContextActions()
			end
		else
			if useTriggersForThrottle then
				ContextActionService:UnbindAction("throttleAccel")
				ContextActionService:UnbindAction("throttleDeccel")
			end
			ContextActionService:UnbindAction("arrowSteerRight")
			ContextActionService:UnbindAction("arrowSteerLeft")
			self.vehicleSeat = nil
		end
	end

	function VehicleController:OnThrottleAccel(actionName, inputState, inputObject)
		if inputState == Enum.UserInputState.End or inputState == Enum.UserInputState.Cancel then
			self.acceleration = 0
		else
			self.acceleration = -1
		end
		self.throttle = self.acceleration + self.decceleration
	end

	function VehicleController:OnThrottleDeccel(actionName, inputState, inputObject)
		if inputState == Enum.UserInputState.End or inputState == Enum.UserInputState.Cancel then
			self.decceleration = 0
		else
			self.decceleration = 1
		end
		self.throttle = self.acceleration + self.decceleration
	end

	function VehicleController:OnSteerRight(actionName, inputState, inputObject)
		if inputState == Enum.UserInputState.End or inputState == Enum.UserInputState.Cancel then
			self.turningRight = 0
		else
			self.turningRight = 1
		end
		self.steer = self.turningRight + self.turningLeft
	end

	function VehicleController:OnSteerLeft(actionName, inputState, inputObject)
		if inputState == Enum.UserInputState.End or inputState == Enum.UserInputState.Cancel then
			self.turningLeft = 0
		else
			self.turningLeft = -1
		end
		self.steer = self.turningRight + self.turningLeft
	end

	-- Call this from a function bound to Renderstep with Input Priority
	function VehicleController:Update(moveVector: Vector3, cameraRelative: boolean, usingGamepad: boolean)
		if self.vehicleSeat then
			if cameraRelative then
				-- This is the default steering mode
				moveVector = moveVector + Vector3.new(self.steer, 0, self.throttle)
				if usingGamepad and onlyTriggersForThrottle and useTriggersForThrottle then
					self.vehicleSeat.ThrottleFloat = -self.throttle
				else
					self.vehicleSeat.ThrottleFloat = -moveVector.Z
				end
				self.vehicleSeat.SteerFloat = moveVector.X

				return moveVector, true
			else
				-- This is the path following mode
				local localMoveVector = self.vehicleSeat.Occupant.RootPart.CFrame:VectorToObjectSpace(moveVector)

				self.vehicleSeat.ThrottleFloat = self:ComputeThrottle(localMoveVector)
				self.vehicleSeat.SteerFloat = self:ComputeSteer(localMoveVector)

				return ZERO_VECTOR3, true
			end
		end
		return moveVector, false
	end

	function VehicleController:ComputeThrottle(localMoveVector)
		if localMoveVector ~= ZERO_VECTOR3 then
			local throttle = -localMoveVector.Z
			return throttle
		else
			return 0.0
		end
	end

	function VehicleController:ComputeSteer(localMoveVector)
		if localMoveVector ~= ZERO_VECTOR3 then
			local steerAngle = -math.atan2(-localMoveVector.x, -localMoveVector.z) * (180 / math.pi)
			return steerAngle / self.autoPilot.MaxSteeringAngle
		else
			return 0.0
		end
	end

	function VehicleController:SetupAutoPilot()
		-- Setup default
		self.autoPilot.MaxSpeed = self.vehicleSeat.MaxSpeed
		self.autoPilot.MaxSteeringAngle = AUTO_PILOT_DEFAULT_MAX_STEERING_ANGLE

		-- VehicleSeat should have a MaxSteeringAngle as well.
		-- Or we could look for a child "AutoPilotConfigModule" to find these values
		-- Or allow developer to set them through the API as like the CLickToMove customization API
	end

	return VehicleController

end))
ModuleScript30.Name = "DynamicThumbstick"
ModuleScript30.Parent = ModuleScript28
table.insert(cors,sandbox(ModuleScript30,function()
	--!nonstrict
	--[[ Constants ]]--
	local ZERO_VECTOR3 = Vector3.new(0,0,0)
	local TOUCH_CONTROLS_SHEET = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"

	local DYNAMIC_THUMBSTICK_ACTION_NAME = "DynamicThumbstickAction"
	local DYNAMIC_THUMBSTICK_ACTION_PRIORITY = Enum.ContextActionPriority.High.Value

	local MIDDLE_TRANSPARENCIES = {
		1 - 0.89,
		1 - 0.70,
		1 - 0.60,
		1 - 0.50,
		1 - 0.40,
		1 - 0.30,
		1 - 0.25
	}
	local NUM_MIDDLE_IMAGES = #MIDDLE_TRANSPARENCIES

	local FADE_IN_OUT_BACKGROUND = true
	local FADE_IN_OUT_MAX_ALPHA = 0.35

	local SAFE_AREA_INSET_MAX = 100

	local FADE_IN_OUT_HALF_DURATION_DEFAULT = 0.3
	local FADE_IN_OUT_BALANCE_DEFAULT = 0.5
	local ThumbstickFadeTweenInfo = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

	local Players = game:GetService("Players")
	local GuiService = game:GetService("GuiService")
	local UserInputService = game:GetService("UserInputService")
	local ContextActionService = game:GetService("ContextActionService")
	local RunService = game:GetService("RunService")
	local TweenService = game:GetService("TweenService")

	local FFlagUserDynamicThumbstickMoveOverButtons do
		local success, result = pcall(function()
			return UserSettings():IsUserFeatureEnabled("UserDynamicThumbstickMoveOverButtons2")
		end)
		FFlagUserDynamicThumbstickMoveOverButtons = success and result
	end

	local FFlagUserDynamicThumbstickSafeAreaUpdate do
		local success, result = pcall(function()
			return UserSettings():IsUserFeatureEnabled("UserDynamicThumbstickSafeAreaUpdate")
		end)
		FFlagUserDynamicThumbstickSafeAreaUpdate = success and result
	end

	local FFlagUserResizeAwareTouchControls do
		local success, result = pcall(function()
			return UserSettings():IsUserFeatureEnabled("UserResizeAwareTouchControls")
		end)
		FFlagUserResizeAwareTouchControls = success and result
	end

	local LocalPlayer = Players.LocalPlayer
	if not LocalPlayer then
		Players:GetPropertyChangedSignal("LocalPlayer"):Wait()
		LocalPlayer = Players.LocalPlayer
	end

	--[[ The Module ]]--
	local BaseCharacterController = require(script.Parent:WaitForChild("BaseCharacterController"))
	local DynamicThumbstick = setmetatable({}, BaseCharacterController)
	DynamicThumbstick.__index = DynamicThumbstick

	function DynamicThumbstick.new()
		local self = setmetatable(BaseCharacterController.new() :: any, DynamicThumbstick)

		self.moveTouchObject = nil
		self.moveTouchLockedIn = false
		self.moveTouchFirstChanged = false
		self.moveTouchStartPosition = nil

		self.startImage = nil
		self.endImage = nil
		self.middleImages = {}

		self.startImageFadeTween = nil
		self.endImageFadeTween = nil
		self.middleImageFadeTweens = {}

		self.isFirstTouch = true

		self.thumbstickFrame = nil

		self.onRenderSteppedConn = nil

		self.fadeInAndOutBalance = FADE_IN_OUT_BALANCE_DEFAULT
		self.fadeInAndOutHalfDuration = FADE_IN_OUT_HALF_DURATION_DEFAULT
		self.hasFadedBackgroundInPortrait = false
		self.hasFadedBackgroundInLandscape = false

		self.tweenInAlphaStart = nil
		self.tweenOutAlphaStart = nil

		return self
	end

	-- Note: Overrides base class GetIsJumping with get-and-clear behavior to do a single jump
	-- rather than sustained jumping. This is only to preserve the current behavior through the refactor.
	function DynamicThumbstick:GetIsJumping()
		local wasJumping = self.isJumping
		self.isJumping = false
		return wasJumping
	end

	function DynamicThumbstick:Enable(enable: boolean?, uiParentFrame): boolean?
		if enable == nil then return false end			-- If nil, return false (invalid argument)
		enable = enable and true or false				-- Force anything non-nil to boolean before comparison
		if self.enabled == enable then return true end	-- If no state change, return true indicating already in requested state

		if enable then
			-- Enable
			if not self.thumbstickFrame then
				self:Create(uiParentFrame)
			end

			self:BindContextActions()
		else
			if FFlagUserDynamicThumbstickMoveOverButtons then
				self:UnbindContextActions()
			else
				ContextActionService:UnbindAction(DYNAMIC_THUMBSTICK_ACTION_NAME)
			end

			-- Disable
			self:OnInputEnded() -- Cleanup
		end

		self.enabled = enable
		self.thumbstickFrame.Visible = enable
		return nil
	end

	-- Was called OnMoveTouchEnded in previous version
	function DynamicThumbstick:OnInputEnded()
		self.moveTouchObject = nil
		self.moveVector = ZERO_VECTOR3
		self:FadeThumbstick(false)
	end

	function DynamicThumbstick:FadeThumbstick(visible: boolean?)
		if not visible and self.moveTouchObject then
			return
		end
		if self.isFirstTouch then return end

		if self.startImageFadeTween then
			self.startImageFadeTween:Cancel()
		end
		if self.endImageFadeTween then
			self.endImageFadeTween:Cancel()
		end
		for i = 1, #self.middleImages do
			if self.middleImageFadeTweens[i] then
				self.middleImageFadeTweens[i]:Cancel()
			end
		end

		if visible then
			self.startImageFadeTween = TweenService:Create(self.startImage, ThumbstickFadeTweenInfo, { ImageTransparency = 0 })
			self.startImageFadeTween:Play()

			self.endImageFadeTween = TweenService:Create(self.endImage, ThumbstickFadeTweenInfo, { ImageTransparency = 0.2 })
			self.endImageFadeTween:Play()

			for i = 1, #self.middleImages do
				self.middleImageFadeTweens[i] = TweenService:Create(self.middleImages[i], ThumbstickFadeTweenInfo, { ImageTransparency = MIDDLE_TRANSPARENCIES[i] })
				self.middleImageFadeTweens[i]:Play()
			end
		else
			self.startImageFadeTween = TweenService:Create(self.startImage, ThumbstickFadeTweenInfo, { ImageTransparency = 1 })
			self.startImageFadeTween:Play()

			self.endImageFadeTween = TweenService:Create(self.endImage, ThumbstickFadeTweenInfo, { ImageTransparency = 1 })
			self.endImageFadeTween:Play()

			for i = 1, #self.middleImages do
				self.middleImageFadeTweens[i] = TweenService:Create(self.middleImages[i], ThumbstickFadeTweenInfo, { ImageTransparency = 1 })
				self.middleImageFadeTweens[i]:Play()
			end
		end
	end

	function DynamicThumbstick:FadeThumbstickFrame(fadeDuration: number, fadeRatio: number)
		self.fadeInAndOutHalfDuration = fadeDuration * 0.5
		self.fadeInAndOutBalance = fadeRatio
		self.tweenInAlphaStart = tick()
	end

	function DynamicThumbstick:InputInFrame(inputObject: InputObject)
		local frameCornerTopLeft: Vector2 = self.thumbstickFrame.AbsolutePosition
		local frameCornerBottomRight = frameCornerTopLeft + self.thumbstickFrame.AbsoluteSize
		local inputPosition = inputObject.Position
		if inputPosition.X >= frameCornerTopLeft.X and inputPosition.Y >= frameCornerTopLeft.Y then
			if inputPosition.X <= frameCornerBottomRight.X and inputPosition.Y <= frameCornerBottomRight.Y then
				return true
			end
		end
		return false
	end

	function DynamicThumbstick:DoFadeInBackground()
		local playerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
		local hasFadedBackgroundInOrientation = false

		-- only fade in/out the background once per orientation
		if playerGui then
			if playerGui.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeLeft or
				playerGui.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeRight then
				hasFadedBackgroundInOrientation = self.hasFadedBackgroundInLandscape
				self.hasFadedBackgroundInLandscape = true
			elseif playerGui.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait then
				hasFadedBackgroundInOrientation = self.hasFadedBackgroundInPortrait
				self.hasFadedBackgroundInPortrait = true
			end
		end

		if not hasFadedBackgroundInOrientation then
			self.fadeInAndOutHalfDuration = FADE_IN_OUT_HALF_DURATION_DEFAULT
			self.fadeInAndOutBalance = FADE_IN_OUT_BALANCE_DEFAULT
			self.tweenInAlphaStart = tick()
		end
	end

	function DynamicThumbstick:DoMove(direction: Vector3)
		local currentMoveVector: Vector3 = direction

		-- Scaled Radial Dead Zone
		local inputAxisMagnitude: number = currentMoveVector.Magnitude
		if inputAxisMagnitude < self.radiusOfDeadZone then
			currentMoveVector = ZERO_VECTOR3
		else
			currentMoveVector = currentMoveVector.Unit*(
				1 - math.max(0, (self.radiusOfMaxSpeed - currentMoveVector.Magnitude)/self.radiusOfMaxSpeed)
			)
			currentMoveVector = Vector3.new(currentMoveVector.X, 0, currentMoveVector.Y)
		end

		self.moveVector = currentMoveVector
	end


	function DynamicThumbstick:LayoutMiddleImages(startPos: Vector3, endPos: Vector3)
		local startDist = (self.thumbstickSize / 2) + self.middleSize
		local vector = endPos - startPos
		local distAvailable = vector.Magnitude - (self.thumbstickRingSize / 2) - self.middleSize
		local direction = vector.Unit

		local distNeeded = self.middleSpacing * NUM_MIDDLE_IMAGES
		local spacing = self.middleSpacing

		if distNeeded < distAvailable then
			spacing = distAvailable / NUM_MIDDLE_IMAGES
		end

		for i = 1, NUM_MIDDLE_IMAGES do
			local image = self.middleImages[i]
			local distWithout = startDist + (spacing * (i - 2))
			local currentDist = startDist + (spacing * (i - 1))

			if distWithout < distAvailable then
				local pos = endPos - direction * currentDist
				local exposedFraction = math.clamp(1 - ((currentDist - distAvailable) / spacing), 0, 1)

				image.Visible = true
				image.Position = UDim2.new(0, pos.X, 0, pos.Y)
				image.Size = UDim2.new(0, self.middleSize * exposedFraction, 0, self.middleSize * exposedFraction)
			else
				image.Visible = false
			end
		end
	end

	function DynamicThumbstick:MoveStick(pos)
		local vector2StartPosition = Vector2.new(self.moveTouchStartPosition.X, self.moveTouchStartPosition.Y)
		local startPos = vector2StartPosition - self.thumbstickFrame.AbsolutePosition
		local endPos = Vector2.new(pos.X, pos.Y) - self.thumbstickFrame.AbsolutePosition
		self.endImage.Position = UDim2.new(0, endPos.X, 0, endPos.Y)
		self:LayoutMiddleImages(startPos, endPos)
	end

	function DynamicThumbstick:BindContextActions()
		local function inputBegan(inputObject)
			if self.moveTouchObject then
				return Enum.ContextActionResult.Pass
			end

			if not self:InputInFrame(inputObject) then
				return Enum.ContextActionResult.Pass
			end

			if self.isFirstTouch then
				self.isFirstTouch = false
				local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0,false,0)
				TweenService:Create(self.startImage, tweenInfo, {Size = UDim2.new(0, 0, 0, 0)}):Play()
				TweenService:Create(
					self.endImage,
					tweenInfo,
					{Size = UDim2.new(0, self.thumbstickSize, 0, self.thumbstickSize), ImageColor3 = Color3.new(0,0,0)}
				):Play()
			end

			self.moveTouchLockedIn = false
			self.moveTouchObject = inputObject
			self.moveTouchStartPosition = inputObject.Position
			self.moveTouchFirstChanged = true

			if FADE_IN_OUT_BACKGROUND then
				self:DoFadeInBackground()
			end

			return Enum.ContextActionResult.Pass
		end

		local function inputChanged(inputObject: InputObject)
			if inputObject == self.moveTouchObject then
				if self.moveTouchFirstChanged then
					self.moveTouchFirstChanged = false

					local startPosVec2 = Vector2.new(
						inputObject.Position.X - self.thumbstickFrame.AbsolutePosition.X,
						inputObject.Position.Y - self.thumbstickFrame.AbsolutePosition.Y
					)
					self.startImage.Visible = true
					self.startImage.Position = UDim2.new(0, startPosVec2.X, 0, startPosVec2.Y)
					self.endImage.Visible = true
					self.endImage.Position = self.startImage.Position

					self:FadeThumbstick(true)
					self:MoveStick(inputObject.Position)
				end

				self.moveTouchLockedIn = true

				local direction = Vector2.new(
					inputObject.Position.X - self.moveTouchStartPosition.X,
					inputObject.Position.Y - self.moveTouchStartPosition.Y
				)
				if math.abs(direction.X) > 0 or math.abs(direction.Y) > 0 then
					self:DoMove(direction)
					self:MoveStick(inputObject.Position)
				end
				return Enum.ContextActionResult.Sink
			end
			return Enum.ContextActionResult.Pass
		end

		local function inputEnded(inputObject)
			if inputObject == self.moveTouchObject then
				self:OnInputEnded()
				if self.moveTouchLockedIn then
					return Enum.ContextActionResult.Sink
				end
			end
			return Enum.ContextActionResult.Pass
		end

		local function handleInput(actionName, inputState, inputObject)
			if inputState == Enum.UserInputState.Begin then
				return inputBegan(inputObject)
			elseif inputState == Enum.UserInputState.Change then
				if FFlagUserDynamicThumbstickMoveOverButtons then
					if inputObject == self.moveTouchObject then
						return Enum.ContextActionResult.Sink
					else
						return Enum.ContextActionResult.Pass
					end
				else
					return inputChanged(inputObject)
				end
			elseif inputState == Enum.UserInputState.End then
				return inputEnded(inputObject)
			elseif inputState == Enum.UserInputState.Cancel then
				self:OnInputEnded()
			end
		end

		ContextActionService:BindActionAtPriority(
			DYNAMIC_THUMBSTICK_ACTION_NAME,
			handleInput,
			false,
			DYNAMIC_THUMBSTICK_ACTION_PRIORITY,
			Enum.UserInputType.Touch)

		if FFlagUserDynamicThumbstickMoveOverButtons then
			self.TouchMovedCon = UserInputService.TouchMoved:Connect(function(inputObject: InputObject, _gameProcessedEvent: boolean)
				inputChanged(inputObject)
			end)
		end
	end

	function DynamicThumbstick:UnbindContextActions()
		ContextActionService:UnbindAction(DYNAMIC_THUMBSTICK_ACTION_NAME)

		if self.TouchMovedCon then
			self.TouchMovedCon:Disconnect()
		end
	end

	function DynamicThumbstick:Create(parentFrame: GuiBase2d)
		if FFlagUserResizeAwareTouchControls then
			if self.thumbstickFrame then
				self.thumbstickFrame:Destroy()
				self.thumbstickFrame = nil
				if self.onRenderSteppedConn then
					self.onRenderSteppedConn:Disconnect()
					self.onRenderSteppedConn = nil
				end
				if self.absoluteSizeChangedConn then
					self.absoluteSizeChangedConn:Disconnect()
					self.absoluteSizeChangedConn = nil
				end
			end

			local safeInset: number = if FFlagUserDynamicThumbstickSafeAreaUpdate then SAFE_AREA_INSET_MAX else 0
			local function layoutThumbstickFrame(portraitMode: boolean)
				if portraitMode then
					self.thumbstickFrame.Size = UDim2.new(1, safeInset, 0.4, safeInset)
					self.thumbstickFrame.Position = UDim2.new(0, -safeInset, 0.6, 0)
				else
					self.thumbstickFrame.Size = UDim2.new(0.4, safeInset, 2/3, safeInset)
					self.thumbstickFrame.Position = UDim2.new(0, -safeInset, 1/3, 0)
				end
			end

			self.thumbstickFrame = Instance.new("Frame")
			self.thumbstickFrame.BorderSizePixel = 0
			self.thumbstickFrame.Name = "DynamicThumbstickFrame"
			self.thumbstickFrame.Visible = false
			self.thumbstickFrame.BackgroundTransparency = 1.0
			self.thumbstickFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			self.thumbstickFrame.Active = false
			layoutThumbstickFrame(false)

			self.startImage = Instance.new("ImageLabel")
			self.startImage.Name = "ThumbstickStart"
			self.startImage.Visible = true
			self.startImage.BackgroundTransparency = 1
			self.startImage.Image = TOUCH_CONTROLS_SHEET
			self.startImage.ImageRectOffset = Vector2.new(1,1)
			self.startImage.ImageRectSize = Vector2.new(144, 144)
			self.startImage.ImageColor3 = Color3.new(0, 0, 0)
			self.startImage.AnchorPoint = Vector2.new(0.5, 0.5)
			self.startImage.ZIndex = 10
			self.startImage.Parent = self.thumbstickFrame

			self.endImage = Instance.new("ImageLabel")
			self.endImage.Name = "ThumbstickEnd"
			self.endImage.Visible = true
			self.endImage.BackgroundTransparency = 1
			self.endImage.Image = TOUCH_CONTROLS_SHEET
			self.endImage.ImageRectOffset = Vector2.new(1,1)
			self.endImage.ImageRectSize =  Vector2.new(144, 144)
			self.endImage.AnchorPoint = Vector2.new(0.5, 0.5)
			self.endImage.ZIndex = 10
			self.endImage.Parent = self.thumbstickFrame

			for i = 1, NUM_MIDDLE_IMAGES do
				self.middleImages[i] = Instance.new("ImageLabel")
				self.middleImages[i].Name = "ThumbstickMiddle"
				self.middleImages[i].Visible = false
				self.middleImages[i].BackgroundTransparency = 1
				self.middleImages[i].Image = TOUCH_CONTROLS_SHEET
				self.middleImages[i].ImageRectOffset = Vector2.new(1,1)
				self.middleImages[i].ImageRectSize = Vector2.new(144, 144)
				self.middleImages[i].ImageTransparency = MIDDLE_TRANSPARENCIES[i]
				self.middleImages[i].AnchorPoint = Vector2.new(0.5, 0.5)
				self.middleImages[i].ZIndex = 9
				self.middleImages[i].Parent = self.thumbstickFrame
			end

			local function ResizeThumbstick()
				local screenSize = parentFrame.AbsoluteSize
				local isBigScreen = math.min(screenSize.X, screenSize.Y) > 500

				local DEFAULT_THUMBSTICK_SIZE = 45
				local DEFAULT_RING_SIZE = 20
				local DEFAULT_MIDDLE_SIZE = 10
				local DEFAULT_MIDDLE_SPACING = DEFAULT_MIDDLE_SIZE + 4
				local RADIUS_OF_DEAD_ZONE = 2
				local RADIUS_OF_MAX_SPEED = 20

				if isBigScreen then
					self.thumbstickSize = DEFAULT_THUMBSTICK_SIZE * 2
					self.thumbstickRingSize = DEFAULT_RING_SIZE * 2
					self.middleSize = DEFAULT_MIDDLE_SIZE * 2
					self.middleSpacing = DEFAULT_MIDDLE_SPACING * 2
					self.radiusOfDeadZone = RADIUS_OF_DEAD_ZONE * 2
					self.radiusOfMaxSpeed = RADIUS_OF_MAX_SPEED * 2
				else
					self.thumbstickSize = DEFAULT_THUMBSTICK_SIZE
					self.thumbstickRingSize = DEFAULT_RING_SIZE
					self.middleSize = DEFAULT_MIDDLE_SIZE
					self.middleSpacing = DEFAULT_MIDDLE_SPACING
					self.radiusOfDeadZone = RADIUS_OF_DEAD_ZONE
					self.radiusOfMaxSpeed = RADIUS_OF_MAX_SPEED
				end

				self.startImage.Position = UDim2.new(0, self.thumbstickRingSize * 3.3 + safeInset, 1, -self.thumbstickRingSize * 2.8 - safeInset)
				self.startImage.Size = UDim2.new(0, self.thumbstickRingSize  * 3.7, 0, self.thumbstickRingSize  * 3.7)

				self.endImage.Position = self.startImage.Position
				self.endImage.Size = UDim2.new(0, self.thumbstickSize * 0.8, 0, self.thumbstickSize * 0.8)
			end

			ResizeThumbstick()
			self.absoluteSizeChangedConn = parentFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(ResizeThumbstick)

			local CameraChangedConn: RBXScriptConnection? = nil
			local function onCurrentCameraChanged()
				if CameraChangedConn then
					CameraChangedConn:Disconnect()
					CameraChangedConn = nil
				end
				local newCamera = workspace.CurrentCamera
				if newCamera then
					local function onViewportSizeChanged()
						local size = newCamera.ViewportSize
						local portraitMode = size.X < size.Y
						layoutThumbstickFrame(portraitMode)
					end
					CameraChangedConn = newCamera:GetPropertyChangedSignal("ViewportSize"):Connect(onViewportSizeChanged)
					onViewportSizeChanged()
				end
			end
			workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(onCurrentCameraChanged)
			if workspace.CurrentCamera then
				onCurrentCameraChanged()
			end
		else
			if self.thumbstickFrame then
				self.thumbstickFrame:Destroy()
				self.thumbstickFrame = nil
				if self.onRenderSteppedConn then
					self.onRenderSteppedConn:Disconnect()
					self.onRenderSteppedConn = nil
				end
			end

			self.thumbstickSize = 45
			self.thumbstickRingSize = 20
			self.middleSize = 10
			self.middleSpacing = self.middleSize + 4
			self.radiusOfDeadZone = 2
			self.radiusOfMaxSpeed = 20

			local screenSize = parentFrame.AbsoluteSize
			local isBigScreen = math.min(screenSize.X, screenSize.Y) > 500
			if isBigScreen then
				self.thumbstickSize = self.thumbstickSize * 2
				self.thumbstickRingSize = self.thumbstickRingSize * 2
				self.middleSize = self.middleSize * 2
				self.middleSpacing = self.middleSpacing * 2
				self.radiusOfDeadZone = self.radiusOfDeadZone * 2
				self.radiusOfMaxSpeed = self.radiusOfMaxSpeed * 2
			end

			local safeInset: number = if FFlagUserDynamicThumbstickSafeAreaUpdate then SAFE_AREA_INSET_MAX else 0
			local function layoutThumbstickFrame(portraitMode: boolean)
				if portraitMode then
					self.thumbstickFrame.Size = UDim2.new(1, safeInset, 0.4, safeInset)
					self.thumbstickFrame.Position = UDim2.new(0, -safeInset, 0.6, 0)
				else
					self.thumbstickFrame.Size = UDim2.new(0.4, safeInset, 2/3, safeInset)
					self.thumbstickFrame.Position = UDim2.new(0, -safeInset, 1/3, 0)
				end
			end

			self.thumbstickFrame = Instance.new("Frame")
			self.thumbstickFrame.BorderSizePixel = 0
			self.thumbstickFrame.Name = "DynamicThumbstickFrame"
			self.thumbstickFrame.Visible = false
			self.thumbstickFrame.BackgroundTransparency = 1.0
			self.thumbstickFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			self.thumbstickFrame.Active = false
			layoutThumbstickFrame(false)

			self.startImage = Instance.new("ImageLabel")
			self.startImage.Name = "ThumbstickStart"
			self.startImage.Visible = true
			self.startImage.BackgroundTransparency = 1
			self.startImage.Image = TOUCH_CONTROLS_SHEET
			self.startImage.ImageRectOffset = Vector2.new(1,1)
			self.startImage.ImageRectSize = Vector2.new(144, 144)
			self.startImage.ImageColor3 = Color3.new(0, 0, 0)
			self.startImage.AnchorPoint = Vector2.new(0.5, 0.5)
			self.startImage.Position = UDim2.new(0, self.thumbstickRingSize * 3.3 + safeInset, 1, -self.thumbstickRingSize * 2.8 - safeInset)
			self.startImage.Size = UDim2.new(0, self.thumbstickRingSize  * 3.7, 0, self.thumbstickRingSize  * 3.7)
			self.startImage.ZIndex = 10
			self.startImage.Parent = self.thumbstickFrame

			self.endImage = Instance.new("ImageLabel")
			self.endImage.Name = "ThumbstickEnd"
			self.endImage.Visible = true
			self.endImage.BackgroundTransparency = 1
			self.endImage.Image = TOUCH_CONTROLS_SHEET
			self.endImage.ImageRectOffset = Vector2.new(1,1)
			self.endImage.ImageRectSize =  Vector2.new(144, 144)
			self.endImage.AnchorPoint = Vector2.new(0.5, 0.5)
			self.endImage.Position = self.startImage.Position
			self.endImage.Size = UDim2.new(0, self.thumbstickSize * 0.8, 0, self.thumbstickSize * 0.8)
			self.endImage.ZIndex = 10
			self.endImage.Parent = self.thumbstickFrame

			for i = 1, NUM_MIDDLE_IMAGES do
				self.middleImages[i] = Instance.new("ImageLabel")
				self.middleImages[i].Name = "ThumbstickMiddle"
				self.middleImages[i].Visible = false
				self.middleImages[i].BackgroundTransparency = 1
				self.middleImages[i].Image = TOUCH_CONTROLS_SHEET
				self.middleImages[i].ImageRectOffset = Vector2.new(1,1)
				self.middleImages[i].ImageRectSize = Vector2.new(144, 144)
				self.middleImages[i].ImageTransparency = MIDDLE_TRANSPARENCIES[i]
				self.middleImages[i].AnchorPoint = Vector2.new(0.5, 0.5)
				self.middleImages[i].ZIndex = 9
				self.middleImages[i].Parent = self.thumbstickFrame
			end

			local CameraChangedConn: RBXScriptConnection? = nil
			local function onCurrentCameraChanged()
				if CameraChangedConn then
					CameraChangedConn:Disconnect()
					CameraChangedConn = nil
				end
				local newCamera = workspace.CurrentCamera
				if newCamera then
					local function onViewportSizeChanged()
						local size = newCamera.ViewportSize
						local portraitMode = size.X < size.Y
						layoutThumbstickFrame(portraitMode)
					end
					CameraChangedConn = newCamera:GetPropertyChangedSignal("ViewportSize"):Connect(onViewportSizeChanged)
					onViewportSizeChanged()
				end
			end
			workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(onCurrentCameraChanged)
			if workspace.CurrentCamera then
				onCurrentCameraChanged()
			end
		end

		self.moveTouchStartPosition = nil

		self.startImageFadeTween = nil
		self.endImageFadeTween = nil
		self.middleImageFadeTweens = {}

		self.onRenderSteppedConn = RunService.RenderStepped:Connect(function()
			if self.tweenInAlphaStart ~= nil then
				local delta = tick() - self.tweenInAlphaStart
				local fadeInTime = (self.fadeInAndOutHalfDuration * 2 * self.fadeInAndOutBalance)
				self.thumbstickFrame.BackgroundTransparency = 1 - FADE_IN_OUT_MAX_ALPHA*math.min(delta/fadeInTime, 1)
				if delta > fadeInTime then
					self.tweenOutAlphaStart = tick()
					self.tweenInAlphaStart = nil
				end
			elseif self.tweenOutAlphaStart ~= nil then
				local delta = tick() - self.tweenOutAlphaStart
				local fadeOutTime = (self.fadeInAndOutHalfDuration * 2) - (self.fadeInAndOutHalfDuration * 2 * self.fadeInAndOutBalance)
				self.thumbstickFrame.BackgroundTransparency = 1 - FADE_IN_OUT_MAX_ALPHA + FADE_IN_OUT_MAX_ALPHA*math.min(delta/fadeOutTime, 1)
				if delta > fadeOutTime  then
					self.tweenOutAlphaStart = nil
				end
			end
		end)

		self.onTouchEndedConn = UserInputService.TouchEnded:connect(function(inputObject: InputObject)
			if inputObject == self.moveTouchObject then
				self:OnInputEnded()
			end
		end)

		GuiService.MenuOpened:connect(function()
			if self.moveTouchObject then
				self:OnInputEnded()
			end
		end)

		local playerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
		while not playerGui do
			LocalPlayer.ChildAdded:wait()
			playerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
		end

		local playerGuiChangedConn = nil
		local originalScreenOrientationWasLandscape =	playerGui.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeLeft or
			playerGui.CurrentScreenOrientation == Enum.ScreenOrientation.LandscapeRight

		local function longShowBackground()
			self.fadeInAndOutHalfDuration = 2.5
			self.fadeInAndOutBalance = 0.05
			self.tweenInAlphaStart = tick()
		end

		playerGuiChangedConn = playerGui:GetPropertyChangedSignal("CurrentScreenOrientation"):Connect(function()
			if (originalScreenOrientationWasLandscape and playerGui.CurrentScreenOrientation == Enum.ScreenOrientation.Portrait) or
				(not originalScreenOrientationWasLandscape and playerGui.CurrentScreenOrientation ~= Enum.ScreenOrientation.Portrait) then

				playerGuiChangedConn:disconnect()
				longShowBackground()

				if originalScreenOrientationWasLandscape then
					self.hasFadedBackgroundInPortrait = true
				else
					self.hasFadedBackgroundInLandscape = true
				end
			end
		end)

		self.thumbstickFrame.Parent = parentFrame

		if game:IsLoaded() then
			longShowBackground()
		else
			coroutine.wrap(function()
				game.Loaded:Wait()
				longShowBackground()
			end)()
		end
	end

	return DynamicThumbstick

end))
ModuleScript31.Name = "VRNavigation"
ModuleScript31.Parent = ModuleScript28
table.insert(cors,sandbox(ModuleScript31,function()
	--!nonstrict
	--!nolint GlobalUsedAsLocal

--[[
		VRNavigation
--]]

	local VRService = game:GetService("VRService")
	local UserInputService = game:GetService("UserInputService")
	local RunService = game:GetService("RunService")
	local Players = game:GetService("Players")
	local PathfindingService = game:GetService("PathfindingService")
	local ContextActionService = game:GetService("ContextActionService")
	local StarterGui = game:GetService("StarterGui")

	--local MasterControl = require(script.Parent)
	local PathDisplay = nil
	local LocalPlayer = Players.LocalPlayer

	--[[ Constants ]]--
	local RECALCULATE_PATH_THRESHOLD = 4
	local NO_PATH_THRESHOLD = 12
	local MAX_PATHING_DISTANCE = 200
	local POINT_REACHED_THRESHOLD = 1
	local OFFTRACK_TIME_THRESHOLD = 2
	local THUMBSTICK_DEADZONE = 0.22

	local ZERO_VECTOR3 = Vector3.new(0,0,0)
	local XZ_VECTOR3 = Vector3.new(1,0,1)

	--[[ Utility Functions ]]--
	local function IsFinite(num: number)
		return num == num and num ~= 1/0 and num ~= -1/0
	end

	local function IsFiniteVector3(vec3)
		return IsFinite(vec3.x) and IsFinite(vec3.y) and IsFinite(vec3.z)
	end

	local movementUpdateEvent = Instance.new("BindableEvent")
	movementUpdateEvent.Name = "MovementUpdate"
	movementUpdateEvent.Parent = script

	coroutine.wrap(function()
		local PathDisplayModule = script.Parent:WaitForChild("PathDisplay")
		if PathDisplayModule then
			PathDisplay = require(PathDisplayModule)
		end
	end)()


	--[[ The Class ]]--
	local BaseCharacterController = require(script.Parent:WaitForChild("BaseCharacterController"))
	local VRNavigation = setmetatable({}, BaseCharacterController)
	VRNavigation.__index = VRNavigation

	function VRNavigation.new(CONTROL_ACTION_PRIORITY)
		local self = setmetatable(BaseCharacterController.new() :: any, VRNavigation)

		self.CONTROL_ACTION_PRIORITY = CONTROL_ACTION_PRIORITY

		self.navigationRequestedConn = nil
		self.heartbeatConn = nil

		self.currentDestination = nil
		self.currentPath = nil
		self.currentPoints = nil
		self.currentPointIdx = 0

		self.expectedTimeToNextPoint = 0
		self.timeReachedLastPoint = tick()
		self.moving = false

		self.isJumpBound = false
		self.moveLatch = false

		self.userCFrameEnabledConn = nil

		return self
	end

	function VRNavigation:SetLaserPointerMode(mode)
		pcall(function()
			StarterGui:SetCore("VRLaserPointerMode", mode)
		end)
	end

	function VRNavigation:GetLocalHumanoid()
		local character = LocalPlayer.Character
		if not character then
			return
		end

		for _, child in pairs(character:GetChildren()) do
			if child:IsA("Humanoid") then
				return child
			end
		end
		return nil
	end

	function VRNavigation:HasBothHandControllers()
		return VRService:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) and VRService:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand)
	end

	function VRNavigation:HasAnyHandControllers()
		return VRService:GetUserCFrameEnabled(Enum.UserCFrame.RightHand) or VRService:GetUserCFrameEnabled(Enum.UserCFrame.LeftHand)
	end

	function VRNavigation:IsMobileVR()
		return UserInputService.TouchEnabled
	end

	function VRNavigation:HasGamepad()
		return UserInputService.GamepadEnabled
	end

	function VRNavigation:ShouldUseNavigationLaser()
		--Places where we use the navigation laser:
		-- mobile VR with any number of hands tracked
		-- desktop VR with only one hand tracked
		-- desktop VR with no hands and no gamepad (i.e. with Oculus remote?)
		--using an Xbox controller with a desktop VR headset means no laser since the user has a thumbstick.
		--in the future, we should query thumbstick presence with a features API
		if self:IsMobileVR() then
			return true
		else
			if self:HasBothHandControllers() then
				return false
			end
			if not self:HasAnyHandControllers() then
				return not self:HasGamepad()
			end
			return true
		end
	end



	function VRNavigation:StartFollowingPath(newPath)
		currentPath = newPath
		currentPoints = currentPath:GetPointCoordinates()
		currentPointIdx = 1
		moving = true

		timeReachedLastPoint = tick()

		local humanoid = self:GetLocalHumanoid()
		if humanoid and humanoid.Torso and #currentPoints >= 1 then
			local dist = (currentPoints[1] - humanoid.Torso.Position).magnitude
			expectedTimeToNextPoint = dist / humanoid.WalkSpeed
		end

		movementUpdateEvent:Fire("targetPoint", self.currentDestination)
	end

	function VRNavigation:GoToPoint(point)
		currentPath = true
		currentPoints = { point }
		currentPointIdx = 1
		moving = true

		local humanoid = self:GetLocalHumanoid()
		local distance = (humanoid.Torso.Position - point).magnitude
		local estimatedTimeRemaining = distance / humanoid.WalkSpeed

		timeReachedLastPoint = tick()
		expectedTimeToNextPoint = estimatedTimeRemaining

		movementUpdateEvent:Fire("targetPoint", point)
	end

	function VRNavigation:StopFollowingPath()
		currentPath = nil
		currentPoints = nil
		currentPointIdx = 0
		moving = false
		self.moveVector = ZERO_VECTOR3
	end

	function VRNavigation:TryComputePath(startPos: Vector3, destination: Vector3)
		local numAttempts = 0
		local newPath = nil

		while not newPath and numAttempts < 5 do
			newPath = PathfindingService:ComputeSmoothPathAsync(startPos, destination, MAX_PATHING_DISTANCE)
			numAttempts = numAttempts + 1

			if newPath.Status == Enum.PathStatus.ClosestNoPath or newPath.Status == Enum.PathStatus.ClosestOutOfRange then
				newPath = nil
				break
			end

			if newPath and newPath.Status == Enum.PathStatus.FailStartNotEmpty then
				startPos = startPos + (destination - startPos).Unit
				newPath = nil
			end

			if newPath and newPath.Status == Enum.PathStatus.FailFinishNotEmpty then
				destination = destination + Vector3.new(0, 1, 0)
				newPath = nil
			end
		end

		return newPath
	end

	function VRNavigation:OnNavigationRequest(destinationCFrame: CFrame, inputUserCFrame: CFrame)
		local destinationPosition = destinationCFrame.Position
		local lastDestination = self.currentDestination

		if not IsFiniteVector3(destinationPosition) then
			return
		end

		self.currentDestination = destinationPosition

		local humanoid = self:GetLocalHumanoid()
		if not humanoid or not humanoid.Torso then
			return
		end

		local currentPosition = humanoid.Torso.Position
		local distanceToDestination = (self.currentDestination - currentPosition).magnitude

		if distanceToDestination < NO_PATH_THRESHOLD then
			self:GoToPoint(self.currentDestination)
			return
		end

		if not lastDestination or (self.currentDestination - lastDestination).magnitude > RECALCULATE_PATH_THRESHOLD then
			local newPath = self:TryComputePath(currentPosition, self.currentDestination)
			if newPath then
				self:StartFollowingPath(newPath)
				if PathDisplay then
					PathDisplay.setCurrentPoints(self.currentPoints)
					PathDisplay.renderPath()
				end
			else
				self:StopFollowingPath()
				if PathDisplay then
					PathDisplay.clearRenderedPath()
				end
			end
		else
			if moving then
				self.currentPoints[#currentPoints] = self.currentDestination
			else
				self:GoToPoint(self.currentDestination)
			end
		end
	end

	function VRNavigation:OnJumpAction(actionName, inputState, inputObj)
		if inputState == Enum.UserInputState.Begin then
			self.isJumping = true
		end
		return Enum.ContextActionResult.Sink
	end
	function VRNavigation:BindJumpAction(active)
		if active then
			if not self.isJumpBound then
				self.isJumpBound = true
				ContextActionService:BindActionAtPriority("VRJumpAction", (function() return self:OnJumpAction() end), false,
				self.CONTROL_ACTION_PRIORITY, Enum.KeyCode.ButtonA)
			end
		else
			if self.isJumpBound then
				self.isJumpBound = false
				ContextActionService:UnbindAction("VRJumpAction")
			end
		end
	end

	function VRNavigation:ControlCharacterGamepad(actionName, inputState, inputObject)
		if inputObject.KeyCode ~= Enum.KeyCode.Thumbstick1 then return end

		if inputState == Enum.UserInputState.Cancel then
			self.moveVector =  ZERO_VECTOR3
			return
		end

		if inputState ~= Enum.UserInputState.End then
			self:StopFollowingPath()
			if PathDisplay then
				PathDisplay.clearRenderedPath()
			end

			if self:ShouldUseNavigationLaser() then
				self:BindJumpAction(true)
				self:SetLaserPointerMode("Hidden")
			end

			if inputObject.Position.magnitude > THUMBSTICK_DEADZONE then
				self.moveVector = Vector3.new(inputObject.Position.X, 0, -inputObject.Position.Y)
				if self.moveVector.magnitude > 0 then
					self.moveVector = self.moveVector.unit * math.min(1, inputObject.Position.magnitude)
				end

				self.moveLatch = true
			end
		else
			self.moveVector =  ZERO_VECTOR3

			if self:ShouldUseNavigationLaser() then
				self:BindJumpAction(false)
				self:SetLaserPointerMode("Navigation")
			end

			if self.moveLatch then
				self.moveLatch = false
				movementUpdateEvent:Fire("offtrack")
			end
		end
		return Enum.ContextActionResult.Sink
	end

	function VRNavigation:OnHeartbeat(dt)
		local newMoveVector = self.moveVector
		local humanoid = self:GetLocalHumanoid()
		if not humanoid or not humanoid.Torso then
			return
		end

		if self.moving and self.currentPoints then
			local currentPosition = humanoid.Torso.Position
			local goalPosition = currentPoints[1]
			local vectorToGoal = (goalPosition - currentPosition) * XZ_VECTOR3
			local moveDist = vectorToGoal.magnitude
			local moveDir = vectorToGoal / moveDist

			if moveDist < POINT_REACHED_THRESHOLD then
				local estimatedTimeRemaining = 0
				local prevPoint = currentPoints[1]
				for i, point in pairs(currentPoints) do
					if i ~= 1 then
						local dist = (point - prevPoint).magnitude
						prevPoint = point
						estimatedTimeRemaining = estimatedTimeRemaining + (dist / humanoid.WalkSpeed)
					end
				end

				table.remove(currentPoints, 1)
				currentPointIdx = currentPointIdx + 1

				if #currentPoints == 0 then
					self:StopFollowingPath()
					if PathDisplay then
						PathDisplay.clearRenderedPath()
					end
					return
				else
					if PathDisplay then
						PathDisplay.setCurrentPoints(currentPoints)
						PathDisplay.renderPath()
					end

					local newGoal = currentPoints[1]
					local distanceToGoal = (newGoal - currentPosition).magnitude
					expectedTimeToNextPoint = distanceToGoal / humanoid.WalkSpeed
					timeReachedLastPoint = tick()
				end
			else
				local ignoreTable = {
					(game.Players.LocalPlayer :: Player).Character,
					workspace.CurrentCamera
				}
				local obstructRay = Ray.new(currentPosition - Vector3.new(0, 1, 0), moveDir * 3)
				local obstructPart, obstructPoint, obstructNormal = workspace:FindPartOnRayWithIgnoreList(obstructRay, ignoreTable)

				if obstructPart then
					local heightOffset = Vector3.new(0, 100, 0)
					local jumpCheckRay = Ray.new(obstructPoint + moveDir * 0.5 + heightOffset, -heightOffset)
					local jumpCheckPart, jumpCheckPoint, jumpCheckNormal = workspace:FindPartOnRayWithIgnoreList(jumpCheckRay, ignoreTable)

					local heightDifference = jumpCheckPoint.Y - currentPosition.Y
					if heightDifference < 6 and heightDifference > -2 then
						humanoid.Jump = true
					end
				end

				local timeSinceLastPoint = tick() - timeReachedLastPoint
				if timeSinceLastPoint > expectedTimeToNextPoint + OFFTRACK_TIME_THRESHOLD then
					self:StopFollowingPath()
					if PathDisplay then
						PathDisplay.clearRenderedPath()
					end

					movementUpdateEvent:Fire("offtrack")
				end

				newMoveVector = self.moveVector:Lerp(moveDir, dt * 10)
			end
		end

		if IsFiniteVector3(newMoveVector) then
			self.moveVector = newMoveVector
		end
	end


	function VRNavigation:OnUserCFrameEnabled()
		if self:ShouldUseNavigationLaser() then
			self:BindJumpAction(false)
			self:SetLaserPointerMode("Navigation")
		else
			self:BindJumpAction(true)
			self:SetLaserPointerMode("Hidden")
		end
	end

	function VRNavigation:Enable(enable)

		self.moveVector = ZERO_VECTOR3
		self.isJumping = false

		if enable then
			self.navigationRequestedConn = VRService.NavigationRequested:Connect(function(destinationCFrame, inputUserCFrame) self:OnNavigationRequest(destinationCFrame, inputUserCFrame) end)
			self.heartbeatConn = RunService.Heartbeat:Connect(function(dt) self:OnHeartbeat(dt) end)

			ContextActionService:BindAction("MoveThumbstick", (function(actionName, inputState, inputObject) return self:ControlCharacterGamepad(actionName, inputState, inputObject) end),
			false, self.CONTROL_ACTION_PRIORITY, Enum.KeyCode.Thumbstick1)
			ContextActionService:BindActivate(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonR2)

			self.userCFrameEnabledConn = VRService.UserCFrameEnabled:Connect(function() self:OnUserCFrameEnabled() end)
			self:OnUserCFrameEnabled()

			VRService:SetTouchpadMode(Enum.VRTouchpad.Left, Enum.VRTouchpadMode.VirtualThumbstick)
			VRService:SetTouchpadMode(Enum.VRTouchpad.Right, Enum.VRTouchpadMode.ABXY)

			self.enabled = true
		else
			-- Disable
			self:StopFollowingPath()

			ContextActionService:UnbindAction("MoveThumbstick")
			ContextActionService:UnbindActivate(Enum.UserInputType.Gamepad1, Enum.KeyCode.ButtonR2)

			self:BindJumpAction(false)
			self:SetLaserPointerMode("Disabled")

			if self.navigationRequestedConn then
				self.navigationRequestedConn:Disconnect()
				self.navigationRequestedConn = nil
			end
			if self.heartbeatConn then
				self.heartbeatConn:Disconnect()
				self.heartbeatConn = nil
			end
			if self.userCFrameEnabledConn then
				self.userCFrameEnabledConn:Disconnect()
				self.userCFrameEnabledConn = nil
			end
			self.enabled = false
		end
	end

	return VRNavigation

end))
ModuleScript32.Name = "Gamepad"
ModuleScript32.Parent = ModuleScript28
table.insert(cors,sandbox(ModuleScript32,function()
	--!nonstrict
--[[
	Gamepad Character Control - This module handles controlling your avatar using a game console-style controller

	2018 PlayerScripts Update - AllYourBlox
--]]

	local UserInputService = game:GetService("UserInputService")
	local ContextActionService = game:GetService("ContextActionService")

	--[[ Constants ]]--
	local ZERO_VECTOR3 = Vector3.new(0,0,0)
	local NONE = Enum.UserInputType.None
	local thumbstickDeadzone = 0.2

	--[[ The Module ]]--
	local BaseCharacterController = require(script.Parent:WaitForChild("BaseCharacterController"))
	local Gamepad = setmetatable({}, BaseCharacterController)
	Gamepad.__index = Gamepad

	function Gamepad.new(CONTROL_ACTION_PRIORITY)
		local self = setmetatable(BaseCharacterController.new() :: any, Gamepad)

		self.CONTROL_ACTION_PRIORITY = CONTROL_ACTION_PRIORITY

		self.forwardValue  = 0
		self.backwardValue = 0
		self.leftValue = 0
		self.rightValue = 0

		self.activeGamepad = NONE	-- Enum.UserInputType.Gamepad1, 2, 3...
		self.gamepadConnectedConn = nil
		self.gamepadDisconnectedConn = nil
		return self
	end

	function Gamepad:Enable(enable: boolean): boolean
		if not UserInputService.GamepadEnabled then
			return false
		end

		if enable == self.enabled then
			-- Module is already in the state being requested. True is returned here since the module will be in the state
			-- expected by the code that follows the Enable() call. This makes more sense than returning false to indicate
			-- no action was necessary. False indicates failure to be in requested/expected state.
			return true
		end

		self.forwardValue  = 0
		self.backwardValue = 0
		self.leftValue = 0
		self.rightValue = 0
		self.moveVector = ZERO_VECTOR3
		self.isJumping = false

		if enable then
			self.activeGamepad = self:GetHighestPriorityGamepad()
			if self.activeGamepad ~= NONE then
				self:BindContextActions()
				self:ConnectGamepadConnectionListeners()
			else
				-- No connected gamepads, failure to enable
				return false
			end
		else
			self:UnbindContextActions()
			self:DisconnectGamepadConnectionListeners()
			self.activeGamepad = NONE
		end

		self.enabled = enable
		return true
	end

	-- This function selects the lowest number gamepad from the currently-connected gamepad
	-- and sets it as the active gamepad
	function Gamepad:GetHighestPriorityGamepad()
		local connectedGamepads = UserInputService:GetConnectedGamepads()
		local bestGamepad = NONE -- Note that this value is higher than all valid gamepad values
		for _, gamepad in pairs(connectedGamepads) do
			if gamepad.Value < bestGamepad.Value then
				bestGamepad = gamepad
			end
		end
		return bestGamepad
	end

	function Gamepad:BindContextActions()

		if self.activeGamepad == NONE then
			-- There must be an active gamepad to set up bindings
			return false
		end

		local handleJumpAction = function(actionName, inputState, inputObject)
			self.isJumping = (inputState == Enum.UserInputState.Begin)
			return Enum.ContextActionResult.Sink
		end

		local handleThumbstickInput = function(actionName, inputState, inputObject)

			if inputState == Enum.UserInputState.Cancel then
				self.moveVector = ZERO_VECTOR3
				return Enum.ContextActionResult.Sink
			end

			if self.activeGamepad ~= inputObject.UserInputType then
				return Enum.ContextActionResult.Pass
			end
			if inputObject.KeyCode ~= Enum.KeyCode.Thumbstick1 then return end

			if inputObject.Position.magnitude > thumbstickDeadzone then
				self.moveVector  =  Vector3.new(inputObject.Position.X, 0, -inputObject.Position.Y)
			else
				self.moveVector = ZERO_VECTOR3
			end
			return Enum.ContextActionResult.Sink
		end

		ContextActionService:BindActivate(self.activeGamepad, Enum.KeyCode.ButtonR2)
		ContextActionService:BindActionAtPriority("jumpAction", handleJumpAction, false,
			self.CONTROL_ACTION_PRIORITY, Enum.KeyCode.ButtonA)
		ContextActionService:BindActionAtPriority("moveThumbstick", handleThumbstickInput, false,
			self.CONTROL_ACTION_PRIORITY, Enum.KeyCode.Thumbstick1)

		return true
	end

	function Gamepad:UnbindContextActions()
		if self.activeGamepad ~= NONE then
			ContextActionService:UnbindActivate(self.activeGamepad, Enum.KeyCode.ButtonR2)
		end
		ContextActionService:UnbindAction("moveThumbstick")
		ContextActionService:UnbindAction("jumpAction")
	end

	function Gamepad:OnNewGamepadConnected()
		-- A new gamepad has been connected.
		local bestGamepad: Enum.UserInputType = self:GetHighestPriorityGamepad()

		if bestGamepad == self.activeGamepad then
			-- A new gamepad was connected, but our active gamepad is not changing
			return
		end

		if bestGamepad == NONE then
			-- There should be an active gamepad when GamepadConnected fires, so this should not
			-- normally be hit. If there is no active gamepad, unbind actions but leave
			-- the module enabled and continue to listen for a new gamepad connection.
			warn("Gamepad:OnNewGamepadConnected found no connected gamepads")
			self:UnbindContextActions()
			return
		end

		if self.activeGamepad ~= NONE then
			-- Switching from one active gamepad to another
			self:UnbindContextActions()
		end

		self.activeGamepad = bestGamepad
		self:BindContextActions()
	end

	function Gamepad:OnCurrentGamepadDisconnected()
		if self.activeGamepad ~= NONE then
			ContextActionService:UnbindActivate(self.activeGamepad, Enum.KeyCode.ButtonR2)
		end

		local bestGamepad = self:GetHighestPriorityGamepad()

		if self.activeGamepad ~= NONE and bestGamepad == self.activeGamepad then
			warn("Gamepad:OnCurrentGamepadDisconnected found the supposedly disconnected gamepad in connectedGamepads.")
			self:UnbindContextActions()
			self.activeGamepad = NONE
			return
		end

		if bestGamepad == NONE then
			-- No active gamepad, unbinding actions but leaving gamepad connection listener active
			self:UnbindContextActions()
			self.activeGamepad = NONE
		else
			-- Set new gamepad as active and bind to tool activation
			self.activeGamepad = bestGamepad
			ContextActionService:BindActivate(self.activeGamepad, Enum.KeyCode.ButtonR2)
		end
	end

	function Gamepad:ConnectGamepadConnectionListeners()
		self.gamepadConnectedConn = UserInputService.GamepadConnected:Connect(function(gamepadEnum)
			self:OnNewGamepadConnected()
		end)

		self.gamepadDisconnectedConn = UserInputService.GamepadDisconnected:Connect(function(gamepadEnum)
			if self.activeGamepad == gamepadEnum then
				self:OnCurrentGamepadDisconnected()
			end
		end)

	end

	function Gamepad:DisconnectGamepadConnectionListeners()
		if self.gamepadConnectedConn then
			self.gamepadConnectedConn:Disconnect()
			self.gamepadConnectedConn = nil
		end

		if self.gamepadDisconnectedConn then
			self.gamepadDisconnectedConn:Disconnect()
			self.gamepadDisconnectedConn = nil
		end
	end

	return Gamepad

end))
ModuleScript33.Name = "TouchThumbstick"
ModuleScript33.Parent = ModuleScript28
table.insert(cors,sandbox(ModuleScript33,function()
	--!nonstrict
--[[

	TouchThumbstick

--]]
	local Players = game:GetService("Players")
	local GuiService = game:GetService("GuiService")
	local UserInputService = game:GetService("UserInputService")

	local UserGameSettings = UserSettings():GetService("UserGameSettings")
	local FFlagUserClampClassicThumbstick do
		local success, result = pcall(function()
			return UserSettings():IsUserFeatureEnabled("UserClampClassicThumbstick")
		end)
		FFlagUserClampClassicThumbstick = success and result
	end
	local FFlagUserResizeAwareTouchControls do
		local success, result = pcall(function()
			return UserSettings():IsUserFeatureEnabled("UserResizeAwareTouchControls")
		end)
		FFlagUserResizeAwareTouchControls = success and result
	end

	--[[ Constants ]]--
	local ZERO_VECTOR3 = Vector3.new(0,0,0)
	local TOUCH_CONTROL_SHEET = "rbxasset://textures/ui/TouchControlsSheet.png"
	--[[ The Module ]]--
	local BaseCharacterController = require(script.Parent:WaitForChild("BaseCharacterController"))
	local TouchThumbstick = setmetatable({}, BaseCharacterController)
	TouchThumbstick.__index = TouchThumbstick
	function TouchThumbstick.new()
		local self = setmetatable(BaseCharacterController.new() :: any, TouchThumbstick)

		self.isFollowStick = false

		self.thumbstickFrame = nil
		self.moveTouchObject = nil
		self.onTouchMovedConn = nil
		self.onTouchEndedConn = nil
		self.screenPos = nil
		self.stickImage = nil
		self.thumbstickSize = nil -- Float

		return self
	end
	function TouchThumbstick:Enable(enable: boolean?, uiParentFrame)
		if enable == nil then return false end			-- If nil, return false (invalid argument)
		enable = enable and true or false				-- Force anything non-nil to boolean before comparison
		if self.enabled == enable then return true end	-- If no state change, return true indicating already in requested state

		self.moveVector = ZERO_VECTOR3
		self.isJumping = false

		if enable then
			-- Enable
			if not self.thumbstickFrame then
				self:Create(uiParentFrame)
			end
			self.thumbstickFrame.Visible = true
		else
			-- Disable
			self.thumbstickFrame.Visible = false
			self:OnInputEnded()
		end
		self.enabled = enable
	end
	function TouchThumbstick:OnInputEnded()
		self.thumbstickFrame.Position = self.screenPos
		self.stickImage.Position = UDim2.new(0, self.thumbstickFrame.Size.X.Offset/2 - self.thumbstickSize/4, 0, self.thumbstickFrame.Size.Y.Offset/2 - self.thumbstickSize/4)

		self.moveVector = ZERO_VECTOR3
		self.isJumping = false
		self.thumbstickFrame.Position = self.screenPos
		self.moveTouchObject = nil
	end
	function TouchThumbstick:Create(parentFrame)
		if FFlagUserResizeAwareTouchControls then
			if self.thumbstickFrame then
				self.thumbstickFrame:Destroy()
				self.thumbstickFrame = nil
				if self.onTouchMovedConn then
					self.onTouchMovedConn:Disconnect()
					self.onTouchMovedConn = nil
				end
				if self.onTouchEndedConn then
					self.onTouchEndedConn:Disconnect()
					self.onTouchEndedConn = nil
				end
				if self.absoluteSizeChangedConn then
					self.absoluteSizeChangedConn:Disconnect()
					self.absoluteSizeChangedConn = nil
				end
			end

			self.thumbstickFrame = Instance.new("Frame")
			self.thumbstickFrame.Name = "ThumbstickFrame"
			self.thumbstickFrame.Active = true
			self.thumbstickFrame.Visible = false
			self.thumbstickFrame.BackgroundTransparency = 1

			local outerImage = Instance.new("ImageLabel")
			outerImage.Name = "OuterImage"
			outerImage.Image = TOUCH_CONTROL_SHEET
			outerImage.ImageRectOffset = Vector2.new()
			outerImage.ImageRectSize = Vector2.new(220, 220)
			outerImage.BackgroundTransparency = 1
			outerImage.Position = UDim2.new(0, 0, 0, 0)

			self.stickImage = Instance.new("ImageLabel")
			self.stickImage.Name = "StickImage"
			self.stickImage.Image = TOUCH_CONTROL_SHEET
			self.stickImage.ImageRectOffset = Vector2.new(220, 0)
			self.stickImage.ImageRectSize = Vector2.new(111, 111)
			self.stickImage.BackgroundTransparency = 1
			self.stickImage.ZIndex = 2

			local function ResizeThumbstick()
				local minAxis = math.min(parentFrame.AbsoluteSize.X, parentFrame.AbsoluteSize.Y)
				local isSmallScreen = minAxis <= 500
				self.thumbstickSize = isSmallScreen and 70 or 120
				self.screenPos = isSmallScreen and UDim2.new(0, (self.thumbstickSize/2) - 10, 1, -self.thumbstickSize - 20) or
					UDim2.new(0, self.thumbstickSize/2, 1, -self.thumbstickSize * 1.75)
				self.thumbstickFrame.Size = UDim2.new(0, self.thumbstickSize, 0, self.thumbstickSize)
				self.thumbstickFrame.Position = self.screenPos
				outerImage.Size = UDim2.new(0, self.thumbstickSize, 0, self.thumbstickSize)
				self.stickImage.Size = UDim2.new(0, self.thumbstickSize/2, 0, self.thumbstickSize/2)
				self.stickImage.Position = UDim2.new(0, self.thumbstickSize/2 - self.thumbstickSize/4, 0, self.thumbstickSize/2 - self.thumbstickSize/4)
			end

			ResizeThumbstick()
			self.absoluteSizeChangedConn = parentFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(ResizeThumbstick)

			outerImage.Parent = self.thumbstickFrame
			self.stickImage.Parent = self.thumbstickFrame
		else
			if self.thumbstickFrame then
				self.thumbstickFrame:Destroy()
				self.thumbstickFrame = nil
				if self.onTouchMovedConn then
					self.onTouchMovedConn:Disconnect()
					self.onTouchMovedConn = nil
				end
				if self.onTouchEndedConn then
					self.onTouchEndedConn:Disconnect()
					self.onTouchEndedConn = nil
				end
			end

			local minAxis = math.min(parentFrame.AbsoluteSize.X, parentFrame.AbsoluteSize.Y)
			local isSmallScreen = minAxis <= 500
			self.thumbstickSize = isSmallScreen and 70 or 120
			self.screenPos = isSmallScreen and UDim2.new(0, (self.thumbstickSize/2) - 10, 1, -self.thumbstickSize - 20) or
				UDim2.new(0, self.thumbstickSize/2, 1, -self.thumbstickSize * 1.75)

			self.thumbstickFrame = Instance.new("Frame")
			self.thumbstickFrame.Name = "ThumbstickFrame"
			self.thumbstickFrame.Active = true
			self.thumbstickFrame.Visible = false
			self.thumbstickFrame.Size = UDim2.new(0, self.thumbstickSize, 0, self.thumbstickSize)
			self.thumbstickFrame.Position = self.screenPos
			self.thumbstickFrame.BackgroundTransparency = 1

			local outerImage = Instance.new("ImageLabel")
			outerImage.Name = "OuterImage"
			outerImage.Image = TOUCH_CONTROL_SHEET
			outerImage.ImageRectOffset = Vector2.new()
			outerImage.ImageRectSize = Vector2.new(220, 220)
			outerImage.BackgroundTransparency = 1
			outerImage.Size = UDim2.new(0, self.thumbstickSize, 0, self.thumbstickSize)
			outerImage.Position = UDim2.new(0, 0, 0, 0)
			outerImage.Parent = self.thumbstickFrame

			self.stickImage = Instance.new("ImageLabel")
			self.stickImage.Name = "StickImage"
			self.stickImage.Image = TOUCH_CONTROL_SHEET
			self.stickImage.ImageRectOffset = Vector2.new(220, 0)
			self.stickImage.ImageRectSize = Vector2.new(111, 111)
			self.stickImage.BackgroundTransparency = 1
			self.stickImage.Size = UDim2.new(0, self.thumbstickSize/2, 0, self.thumbstickSize/2)
			self.stickImage.Position = UDim2.new(0, self.thumbstickSize/2 - self.thumbstickSize/4, 0, self.thumbstickSize/2 - self.thumbstickSize/4)
			self.stickImage.ZIndex = 2
			self.stickImage.Parent = self.thumbstickFrame
		end

		local centerPosition = nil
		local deadZone = 0.05

		local function DoMove(direction: Vector2)

			local currentMoveVector = direction / (self.thumbstickSize/2)

			-- Scaled Radial Dead Zone
			local inputAxisMagnitude = currentMoveVector.magnitude
			if inputAxisMagnitude < deadZone then
				currentMoveVector = Vector3.new()
			else
				if FFlagUserClampClassicThumbstick then
					currentMoveVector = currentMoveVector.unit * math.min(1, (inputAxisMagnitude - deadZone) / (1 - deadZone))
				else
					currentMoveVector = currentMoveVector.unit * ((inputAxisMagnitude - deadZone) / (1 - deadZone))
				end
				-- NOTE: Making currentMoveVector a unit vector will cause the player to instantly go max speed
				-- must check for zero length vector is using unit
				currentMoveVector = Vector3.new(currentMoveVector.X, 0, currentMoveVector.Y)
			end

			self.moveVector = currentMoveVector
		end

		local function MoveStick(pos: Vector3)
			local relativePosition = Vector2.new(pos.X - centerPosition.X, pos.Y - centerPosition.Y)
			local length = relativePosition.magnitude
			local maxLength = self.thumbstickFrame.AbsoluteSize.X/2
			if self.isFollowStick and length > maxLength then
				local offset = relativePosition.unit * maxLength
				self.thumbstickFrame.Position = UDim2.new(
					0, pos.X - self.thumbstickFrame.AbsoluteSize.X/2 - offset.X,
					0, pos.Y - self.thumbstickFrame.AbsoluteSize.Y/2 - offset.Y)
			else
				length = math.min(length, maxLength)
				relativePosition = relativePosition.unit * length
			end
			self.stickImage.Position = UDim2.new(0, relativePosition.X + self.stickImage.AbsoluteSize.X/2, 0, relativePosition.Y + self.stickImage.AbsoluteSize.Y/2)
		end

		-- input connections
		self.thumbstickFrame.InputBegan:Connect(function(inputObject: InputObject)
			--A touch that starts elsewhere on the screen will be sent to a frame's InputBegan event
			--if it moves over the frame. So we check that this is actually a new touch (inputObject.UserInputState ~= Enum.UserInputState.Begin)
			if self.moveTouchObject or inputObject.UserInputType ~= Enum.UserInputType.Touch
				or inputObject.UserInputState ~= Enum.UserInputState.Begin then
				return
			end

			self.moveTouchObject = inputObject
			self.thumbstickFrame.Position = UDim2.new(0, inputObject.Position.X - self.thumbstickFrame.Size.X.Offset/2, 0, inputObject.Position.Y - self.thumbstickFrame.Size.Y.Offset/2)
			centerPosition = Vector2.new(self.thumbstickFrame.AbsolutePosition.X + self.thumbstickFrame.AbsoluteSize.X/2,
				self.thumbstickFrame.AbsolutePosition.Y + self.thumbstickFrame.AbsoluteSize.Y/2)
			local direction = Vector2.new(inputObject.Position.X - centerPosition.X, inputObject.Position.Y - centerPosition.Y)
		end)

		self.onTouchMovedConn = UserInputService.TouchMoved:Connect(function(inputObject: InputObject, isProcessed: boolean)
			if inputObject == self.moveTouchObject then
				centerPosition = Vector2.new(self.thumbstickFrame.AbsolutePosition.X + self.thumbstickFrame.AbsoluteSize.X/2,
					self.thumbstickFrame.AbsolutePosition.Y + self.thumbstickFrame.AbsoluteSize.Y/2)
				local direction = Vector2.new(inputObject.Position.X - centerPosition.X, inputObject.Position.Y - centerPosition.Y)
				DoMove(direction)
				MoveStick(inputObject.Position)
			end
		end)

		self.onTouchEndedConn = UserInputService.TouchEnded:Connect(function(inputObject, isProcessed)
			if inputObject == self.moveTouchObject then
				self:OnInputEnded()
			end
		end)

		GuiService.MenuOpened:Connect(function()
			if self.moveTouchObject then
				self:OnInputEnded()
			end
		end)

		self.thumbstickFrame.Parent = parentFrame
	end
	return TouchThumbstick

end))
ModuleScript34.Name = "Keyboard"
ModuleScript34.Parent = ModuleScript28
table.insert(cors,sandbox(ModuleScript34,function()
	--!nonstrict
--[[
	Keyboard Character Control - This module handles controlling your avatar from a keyboard

	2018 PlayerScripts Update - AllYourBlox
--]]

	--[[ Roblox Services ]]--
	local UserInputService = game:GetService("UserInputService")
	local ContextActionService = game:GetService("ContextActionService")

	--[[ Constants ]]--
	local ZERO_VECTOR3 = Vector3.new(0,0,0)

	--[[ The Module ]]--
	local BaseCharacterController = require(script.Parent:WaitForChild("BaseCharacterController"))
	local Keyboard = setmetatable({}, BaseCharacterController)
	Keyboard.__index = Keyboard

	function Keyboard.new(CONTROL_ACTION_PRIORITY)
		local self = setmetatable(BaseCharacterController.new() :: any, Keyboard)

		self.CONTROL_ACTION_PRIORITY = CONTROL_ACTION_PRIORITY

		self.textFocusReleasedConn = nil
		self.textFocusGainedConn = nil
		self.windowFocusReleasedConn = nil

		self.forwardValue  = 0
		self.backwardValue = 0
		self.leftValue = 0
		self.rightValue = 0

		self.jumpEnabled = true

		return self
	end

	function Keyboard:Enable(enable: boolean)
		if not UserInputService.KeyboardEnabled then
			return false
		end

		if enable == self.enabled then
			-- Module is already in the state being requested. True is returned here since the module will be in the state
			-- expected by the code that follows the Enable() call. This makes more sense than returning false to indicate
			-- no action was necessary. False indicates failure to be in requested/expected state.
			return true
		end

		self.forwardValue  = 0
		self.backwardValue = 0
		self.leftValue = 0
		self.rightValue = 0
		self.moveVector = ZERO_VECTOR3
		self.jumpRequested = false
		self:UpdateJump()

		if enable then
			self:BindContextActions()
			self:ConnectFocusEventListeners()
		else
			self:UnbindContextActions()
			self:DisconnectFocusEventListeners()
		end

		self.enabled = enable
		return true
	end

	function Keyboard:UpdateMovement(inputState)
		if inputState == Enum.UserInputState.Cancel then
			self.moveVector = ZERO_VECTOR3
		else
			self.moveVector = Vector3.new(self.leftValue + self.rightValue, 0, self.forwardValue + self.backwardValue)
		end
	end

	function Keyboard:UpdateJump()
		self.isJumping = self.jumpRequested
	end

	function Keyboard:BindContextActions()

		-- Note: In the previous version of this code, the movement values were not zeroed-out on UserInputState. Cancel, now they are,
		-- which fixes them from getting stuck on.
		-- We return ContextActionResult.Pass here for legacy reasons.
		-- Many games rely on gameProcessedEvent being false on UserInputService.InputBegan for these control actions.
		local handleMoveForward = function(actionName, inputState, inputObject)
			self.forwardValue = (inputState == Enum.UserInputState.Begin) and -1 or 0
			self:UpdateMovement(inputState)
			return Enum.ContextActionResult.Pass
		end

		local handleMoveBackward = function(actionName, inputState, inputObject)
			self.backwardValue = (inputState == Enum.UserInputState.Begin) and 1 or 0
			self:UpdateMovement(inputState)
			return Enum.ContextActionResult.Pass
		end

		local handleMoveLeft = function(actionName, inputState, inputObject)
			self.leftValue = (inputState == Enum.UserInputState.Begin) and -1 or 0
			self:UpdateMovement(inputState)
			return Enum.ContextActionResult.Pass
		end

		local handleMoveRight = function(actionName, inputState, inputObject)
			self.rightValue = (inputState == Enum.UserInputState.Begin) and 1 or 0
			self:UpdateMovement(inputState)
			return Enum.ContextActionResult.Pass
		end

		local handleJumpAction = function(actionName, inputState, inputObject)
			self.jumpRequested = self.jumpEnabled and (inputState == Enum.UserInputState.Begin)
			self:UpdateJump()
			return Enum.ContextActionResult.Pass
		end

		-- TODO: Revert to KeyCode bindings so that in the future the abstraction layer from actual keys to
		-- movement direction is done in Lua
		ContextActionService:BindActionAtPriority("moveForwardAction", handleMoveForward, false,
			self.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterForward)
		ContextActionService:BindActionAtPriority("moveBackwardAction", handleMoveBackward, false,
			self.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterBackward)
		ContextActionService:BindActionAtPriority("moveLeftAction", handleMoveLeft, false,
			self.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterLeft)
		ContextActionService:BindActionAtPriority("moveRightAction", handleMoveRight, false,
			self.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterRight)
		ContextActionService:BindActionAtPriority("jumpAction", handleJumpAction, false,
			self.CONTROL_ACTION_PRIORITY, Enum.PlayerActions.CharacterJump)
	end

	function Keyboard:UnbindContextActions()
		ContextActionService:UnbindAction("moveForwardAction")
		ContextActionService:UnbindAction("moveBackwardAction")
		ContextActionService:UnbindAction("moveLeftAction")
		ContextActionService:UnbindAction("moveRightAction")
		ContextActionService:UnbindAction("jumpAction")
	end

	function Keyboard:ConnectFocusEventListeners()
		local function onFocusReleased()
			self.moveVector = ZERO_VECTOR3
			self.forwardValue  = 0
			self.backwardValue = 0
			self.leftValue = 0
			self.rightValue = 0
			self.jumpRequested = false
			self:UpdateJump()
		end

		local function onTextFocusGained(textboxFocused)
			self.jumpRequested = false
			self:UpdateJump()
		end

		self.textFocusReleasedConn = UserInputService.TextBoxFocusReleased:Connect(onFocusReleased)
		self.textFocusGainedConn = UserInputService.TextBoxFocused:Connect(onTextFocusGained)
		self.windowFocusReleasedConn = UserInputService.WindowFocused:Connect(onFocusReleased)
	end

	function Keyboard:DisconnectFocusEventListeners()
		if self.textFocusReleasedConn then
			self.textFocusReleasedConn:Disconnect()
			self.textFocusReleasedConn = nil
		end
		if self.textFocusGainedConn then
			self.textFocusGainedConn:Disconnect()
			self.textFocusGainedConn = nil
		end
		if self.windowFocusReleasedConn then
			self.windowFocusReleasedConn:Disconnect()
			self.windowFocusReleasedConn = nil
		end
	end

	return Keyboard

end))
ModuleScript35.Name = "BaseCharacterController"
ModuleScript35.Parent = ModuleScript28
table.insert(cors,sandbox(ModuleScript35,function()
--[[
	BaseCharacterController - Abstract base class for character controllers, not intended to be
	directly instantiated.

	2018 PlayerScripts Update - AllYourBlox
--]]

	local ZERO_VECTOR3: Vector3 = Vector3.new(0,0,0)

	--[[ The Module ]]--
	local BaseCharacterController = {}
	BaseCharacterController.__index = BaseCharacterController

	function BaseCharacterController.new()
		local self = setmetatable({}, BaseCharacterController)
		self.enabled = false
		self.moveVector = ZERO_VECTOR3
		self.moveVectorIsCameraRelative = true
		self.isJumping = false
		return self
	end

	function BaseCharacterController:OnRenderStepped(dt: number)
		-- By default, nothing to do
	end

	function BaseCharacterController:GetMoveVector(): Vector3
		return self.moveVector
	end

	function BaseCharacterController:IsMoveVectorCameraRelative(): boolean
		return self.moveVectorIsCameraRelative
	end

	function BaseCharacterController:GetIsJumping(): boolean
		return self.isJumping
	end

	-- Override in derived classes to set self.enabled and return boolean indicating
	-- whether Enable/Disable was successful. Return true if controller is already in the requested state.
	function BaseCharacterController:Enable(enable: boolean): boolean
		error("BaseCharacterController:Enable must be overridden in derived classes and should not be called.")
		return false
	end

	return BaseCharacterController

end))
ModuleScript36.Name = "ClickToMoveController"
ModuleScript36.Parent = ModuleScript28
table.insert(cors,sandbox(ModuleScript36,function()
	--!nonstrict
--[[
	-- Original By Kip Turner, Copyright Roblox 2014
	-- Updated by Garnold to utilize the new PathfindingService API, 2017
	-- 2018 PlayerScripts Update - AllYourBlox
--]]

	--[[ Flags ]]
	local FFlagUserExcludeNonCollidableForPathfindingSuccess, FFlagUserExcludeNonCollidableForPathfindingResult =
		pcall(function() return UserSettings():IsUserFeatureEnabled("UserExcludeNonCollidableForPathfinding") end)
	local FFlagUserExcludeNonCollidableForPathfinding = FFlagUserExcludeNonCollidableForPathfindingSuccess and FFlagUserExcludeNonCollidableForPathfindingResult

	local FFlagUserClickToMoveSupportAgentCanClimbSuccess, FFlagUserClickToMoveSupportAgentCanClimbResult =
		pcall(function() return UserSettings():IsUserFeatureEnabled("UserClickToMoveSupportAgentCanClimb2") end)
	local FFlagUserClickToMoveSupportAgentCanClimb = FFlagUserClickToMoveSupportAgentCanClimbSuccess and FFlagUserClickToMoveSupportAgentCanClimbResult

	--[[ Roblox Services ]]--
	local UserInputService = game:GetService("UserInputService")
	local PathfindingService = game:GetService("PathfindingService")
	local Players = game:GetService("Players")
	local DebrisService = game:GetService('Debris')
	local StarterGui = game:GetService("StarterGui")
	local Workspace = game:GetService("Workspace")
	local CollectionService = game:GetService("CollectionService")
	local GuiService = game:GetService("GuiService")

	--[[ Configuration ]]
	local ShowPath = true
	local PlayFailureAnimation = true
	local UseDirectPath = false
	local UseDirectPathForVehicle = true
	local AgentSizeIncreaseFactor = 1.0
	local UnreachableWaypointTimeout = 8

	--[[ Constants ]]--
	local movementKeys = {
		[Enum.KeyCode.W] = true;
		[Enum.KeyCode.A] = true;
		[Enum.KeyCode.S] = true;
		[Enum.KeyCode.D] = true;
		[Enum.KeyCode.Up] = true;
		[Enum.KeyCode.Down] = true;
	}

	local Player = Players.LocalPlayer

	local ClickToMoveDisplay = require(script.Parent:WaitForChild("ClickToMoveDisplay"))

	local ZERO_VECTOR3 = Vector3.new(0,0,0)
	local ALMOST_ZERO = 0.000001


	--------------------------UTIL LIBRARY-------------------------------
	local Utility = {}
	do
		local function FindCharacterAncestor(part)
			if part then
				local humanoid = part:FindFirstChildOfClass("Humanoid")
				if humanoid then
					return part, humanoid
				else
					return FindCharacterAncestor(part.Parent)
				end
			end
		end
		Utility.FindCharacterAncestor = FindCharacterAncestor

		local function Raycast(ray, ignoreNonCollidable: boolean, ignoreList: {Model})
			ignoreList = ignoreList or {}
			local hitPart, hitPos, hitNorm, hitMat = Workspace:FindPartOnRayWithIgnoreList(ray, ignoreList)
			if hitPart then
				if ignoreNonCollidable and hitPart.CanCollide == false then
					-- We always include character parts so a user can click on another character
					-- to walk to them.
					local _, humanoid = FindCharacterAncestor(hitPart)
					if humanoid == nil then
						table.insert(ignoreList, hitPart)
						return Raycast(ray, ignoreNonCollidable, ignoreList)
					end
				end
				return hitPart, hitPos, hitNorm, hitMat
			end
			return nil, nil
		end
		Utility.Raycast = Raycast
	end

	local humanoidCache = {}
	local function findPlayerHumanoid(player: Player)
		local character = player and player.Character
		if character then
			local resultHumanoid = humanoidCache[player]
			if resultHumanoid and resultHumanoid.Parent == character then
				return resultHumanoid
			else
				humanoidCache[player] = nil -- Bust Old Cache
				local humanoid = character:FindFirstChildOfClass("Humanoid")
				if humanoid then
					humanoidCache[player] = humanoid
				end
				return humanoid
			end
		end
	end

	--------------------------CHARACTER CONTROL-------------------------------
	local CurrentIgnoreList: {Model}
	local CurrentIgnoreTag = nil

	local TaggedInstanceAddedConnection: RBXScriptConnection? = nil
	local TaggedInstanceRemovedConnection: RBXScriptConnection? = nil

	local function GetCharacter(): Model
		return Player and Player.Character
	end

	local function UpdateIgnoreTag(newIgnoreTag)
		if newIgnoreTag == CurrentIgnoreTag then
			return
		end
		if TaggedInstanceAddedConnection then
			TaggedInstanceAddedConnection:Disconnect()
			TaggedInstanceAddedConnection = nil
		end
		if TaggedInstanceRemovedConnection then
			TaggedInstanceRemovedConnection:Disconnect()
			TaggedInstanceRemovedConnection = nil
		end
		CurrentIgnoreTag = newIgnoreTag
		CurrentIgnoreList = {GetCharacter()}
		if CurrentIgnoreTag ~= nil then
			local ignoreParts = CollectionService:GetTagged(CurrentIgnoreTag)
			for _, ignorePart in ipairs(ignoreParts) do
				table.insert(CurrentIgnoreList, ignorePart)
			end
			TaggedInstanceAddedConnection = CollectionService:GetInstanceAddedSignal(
				CurrentIgnoreTag):Connect(function(ignorePart)
				table.insert(CurrentIgnoreList, ignorePart)
			end)
			TaggedInstanceRemovedConnection = CollectionService:GetInstanceRemovedSignal(
				CurrentIgnoreTag):Connect(function(ignorePart)
				for i = 1, #CurrentIgnoreList do
					if CurrentIgnoreList[i] == ignorePart then
						CurrentIgnoreList[i] = CurrentIgnoreList[#CurrentIgnoreList]
						table.remove(CurrentIgnoreList)
						break
					end
				end
			end)
		end
	end

	local function getIgnoreList(): {Model}
		if CurrentIgnoreList then
			return CurrentIgnoreList
		end
		CurrentIgnoreList = {}
		assert(CurrentIgnoreList, "")
		table.insert(CurrentIgnoreList, GetCharacter())
		return CurrentIgnoreList
	end

	local function minV(a: Vector3, b: Vector3)
		return Vector3.new(math.min(a.X, b.X), math.min(a.Y, b.Y), math.min(a.Z, b.Z))
	end
	local function maxV(a, b)
		return Vector3.new(math.max(a.X, b.X), math.max(a.Y, b.Y), math.max(a.Z, b.Z))
	end
	local function getCollidableExtentsSize(character: Model?)
		if character == nil or character.PrimaryPart == nil then return end
		assert(character, "")
		assert(character.PrimaryPart, "")
		local toLocalCFrame = character.PrimaryPart.CFrame:Inverse()
		local min = Vector3.new(math.huge, math.huge, math.huge)
		local max = Vector3.new(-math.huge, -math.huge, -math.huge)
		for _,descendant in pairs(character:GetDescendants()) do
			if descendant:IsA('BasePart') and descendant.CanCollide then
				local localCFrame = toLocalCFrame * descendant.CFrame
				local size = Vector3.new(descendant.Size.X / 2, descendant.Size.Y / 2, descendant.Size.Z / 2)
				local vertices = {
					Vector3.new( size.X,  size.Y,  size.Z),
					Vector3.new( size.X,  size.Y, -size.Z),
					Vector3.new( size.X, -size.Y,  size.Z),
					Vector3.new( size.X, -size.Y, -size.Z),
					Vector3.new(-size.X,  size.Y,  size.Z),
					Vector3.new(-size.X,  size.Y, -size.Z),
					Vector3.new(-size.X, -size.Y,  size.Z),
					Vector3.new(-size.X, -size.Y, -size.Z)
				}
				for _,vertex in ipairs(vertices) do
					local v = localCFrame * vertex
					min = minV(min, v)
					max = maxV(max, v)
				end
			end
		end
		local r = max - min
		if r.X < 0 or r.Y < 0 or r.Z < 0 then return nil end
		return r
	end

	-----------------------------------PATHER--------------------------------------

	local function Pather(endPoint, surfaceNormal, overrideUseDirectPath: boolean?)
		local this = {}

		local directPathForHumanoid
		local directPathForVehicle
		if overrideUseDirectPath ~= nil then
			directPathForHumanoid = overrideUseDirectPath
			directPathForVehicle = overrideUseDirectPath
		else
			directPathForHumanoid = UseDirectPath
			directPathForVehicle = UseDirectPathForVehicle
		end

		this.Cancelled = false
		this.Started = false

		this.Finished = Instance.new("BindableEvent")
		this.PathFailed = Instance.new("BindableEvent")

		this.PathComputing = false
		this.PathComputed = false

		this.OriginalTargetPoint = endPoint
		this.TargetPoint = endPoint
		this.TargetSurfaceNormal = surfaceNormal

		this.DiedConn = nil
		this.SeatedConn = nil
		this.BlockedConn = nil
		this.TeleportedConn = nil

		this.CurrentPoint = 0

		this.HumanoidOffsetFromPath = ZERO_VECTOR3

		this.CurrentWaypointPosition = nil
		this.CurrentWaypointPlaneNormal = ZERO_VECTOR3
		this.CurrentWaypointPlaneDistance = 0
		this.CurrentWaypointNeedsJump = false;

		this.CurrentHumanoidPosition = ZERO_VECTOR3
		this.CurrentHumanoidVelocity = 0 :: Vector3 | number

		this.NextActionMoveDirection = ZERO_VECTOR3
		this.NextActionJump = false

		this.Timeout = 0

		this.Humanoid = findPlayerHumanoid(Player)
		this.OriginPoint = nil
		this.AgentCanFollowPath = false
		this.DirectPath = false
		this.DirectPathRiseFirst = false

		this.stopTraverseFunc = nil :: (() -> ())?
		this.setPointFunc = nil :: ((number) -> ())?
		this.pointList = nil :: {PathWaypoint}?

		local rootPart: BasePart = this.Humanoid and this.Humanoid.RootPart
		if rootPart then
			-- Setup origin
			this.OriginPoint = rootPart.CFrame.Position

			-- Setup agent
			local agentRadius = 2
			local agentHeight = 5
			local agentCanJump = true

			local seat = this.Humanoid.SeatPart
			if seat and seat:IsA("VehicleSeat") then
				-- Humanoid is seated on a vehicle
				local vehicle = seat:FindFirstAncestorOfClass("Model")
				if vehicle then
					-- Make sure the PrimaryPart is set to the vehicle seat while we compute the extends.
					local tempPrimaryPart = vehicle.PrimaryPart
					vehicle.PrimaryPart = seat

					-- For now, only direct path
					if directPathForVehicle then
						local extents: Vector3 = vehicle:GetExtentsSize()
						agentRadius = AgentSizeIncreaseFactor * 0.5 * math.sqrt(extents.X * extents.X + extents.Z * extents.Z)
						agentHeight = AgentSizeIncreaseFactor * extents.Y
						agentCanJump = false
						this.AgentCanFollowPath = true
						this.DirectPath = directPathForVehicle
					end

					-- Reset PrimaryPart
					vehicle.PrimaryPart = tempPrimaryPart
				end
			else
				local extents: Vector3?
				if FFlagUserExcludeNonCollidableForPathfinding then
					local character: Model? = GetCharacter()
					if character ~= nil then
						extents = getCollidableExtentsSize(character)
					end
				end
				if extents == nil then
					extents = GetCharacter():GetExtentsSize()
				end
				assert(extents, "")
				agentRadius = AgentSizeIncreaseFactor * 0.5 * math.sqrt(extents.X * extents.X + extents.Z * extents.Z)
				agentHeight = AgentSizeIncreaseFactor * extents.Y
				agentCanJump = (this.Humanoid.JumpPower > 0)
				this.AgentCanFollowPath = true
				this.DirectPath = directPathForHumanoid :: boolean
				this.DirectPathRiseFirst = this.Humanoid.Sit
			end

			-- Build path object
			if FFlagUserClickToMoveSupportAgentCanClimb then
				this.pathResult = PathfindingService:CreatePath({AgentRadius = agentRadius, AgentHeight = agentHeight, AgentCanJump = agentCanJump, AgentCanClimb = true})
			else
				this.pathResult = PathfindingService:CreatePath({AgentRadius = agentRadius, AgentHeight = agentHeight, AgentCanJump = agentCanJump})
			end
		end

		function this:Cleanup()
			if this.stopTraverseFunc then
				this.stopTraverseFunc()
				this.stopTraverseFunc = nil
			end

			if this.BlockedConn then
				this.BlockedConn:Disconnect()
				this.BlockedConn = nil
			end

			if this.DiedConn then
				this.DiedConn:Disconnect()
				this.DiedConn = nil
			end

			if this.SeatedConn then
				this.SeatedConn:Disconnect()
				this.SeatedConn = nil
			end

			if this.TeleportedConn then
				this.TeleportedConn:Disconnect()
				this.TeleportedConn = nil
			end

			this.Started = false
		end

		function this:Cancel()
			this.Cancelled = true
			this:Cleanup()
		end

		function this:IsActive()
			return this.AgentCanFollowPath and this.Started and not this.Cancelled
		end

		function this:OnPathInterrupted()
			-- Stop moving
			this.Cancelled = true
			this:OnPointReached(false)
		end

		function this:ComputePath()
			if this.OriginPoint then
				if this.PathComputed or this.PathComputing then return end
				this.PathComputing = true
				if this.AgentCanFollowPath then
					if this.DirectPath then
						this.pointList = {
							PathWaypoint.new(this.OriginPoint, Enum.PathWaypointAction.Walk),
							PathWaypoint.new(this.TargetPoint, this.DirectPathRiseFirst and Enum.PathWaypointAction.Jump or Enum.PathWaypointAction.Walk)
						}
						this.PathComputed = true
					else
						this.pathResult:ComputeAsync(this.OriginPoint, this.TargetPoint)
						this.pointList = this.pathResult:GetWaypoints()
						this.BlockedConn = this.pathResult.Blocked:Connect(function(blockedIdx) this:OnPathBlocked(blockedIdx) end)
						this.PathComputed = this.pathResult.Status == Enum.PathStatus.Success
					end
				end
				this.PathComputing = false
			end
		end

		function this:IsValidPath()
			this:ComputePath()
			return this.PathComputed and this.AgentCanFollowPath
		end

		this.Recomputing = false
		function this:OnPathBlocked(blockedWaypointIdx)
			local pathBlocked = blockedWaypointIdx >= this.CurrentPoint
			if not pathBlocked or this.Recomputing then
				return
			end

			this.Recomputing = true

			if this.stopTraverseFunc then
				this.stopTraverseFunc()
				this.stopTraverseFunc = nil
			end

			this.OriginPoint = this.Humanoid.RootPart.CFrame.p

			this.pathResult:ComputeAsync(this.OriginPoint, this.TargetPoint)
			this.pointList = this.pathResult:GetWaypoints()
			if #this.pointList > 0 then
				this.HumanoidOffsetFromPath = this.pointList[1].Position - this.OriginPoint
			end
			this.PathComputed = this.pathResult.Status == Enum.PathStatus.Success

			if ShowPath then
				this.stopTraverseFunc, this.setPointFunc = ClickToMoveDisplay.CreatePathDisplay(this.pointList)
			end
			if this.PathComputed then
				this.CurrentPoint = 1 -- The first waypoint is always the start location. Skip it.
				this:OnPointReached(true) -- Move to first point
			else
				this.PathFailed:Fire()
				this:Cleanup()
			end

			this.Recomputing = false
		end

		function this:OnRenderStepped(dt: number)
			if this.Started and not this.Cancelled then
				-- Check for Timeout (if a waypoint is not reached within the delay, we fail)
				this.Timeout = this.Timeout + dt
				if this.Timeout > UnreachableWaypointTimeout then
					this:OnPointReached(false)
					return
				end

				-- Get Humanoid position and velocity
				this.CurrentHumanoidPosition = this.Humanoid.RootPart.Position + this.HumanoidOffsetFromPath
				this.CurrentHumanoidVelocity = this.Humanoid.RootPart.Velocity

				-- Check if it has reached some waypoints
				while this.Started and this:IsCurrentWaypointReached() do
					this:OnPointReached(true)
				end

				-- If still started, update actions
				if this.Started then
					-- Move action
					this.NextActionMoveDirection = this.CurrentWaypointPosition - this.CurrentHumanoidPosition
					if this.NextActionMoveDirection.Magnitude > ALMOST_ZERO then
						this.NextActionMoveDirection = this.NextActionMoveDirection.Unit
					else
						this.NextActionMoveDirection = ZERO_VECTOR3
					end
					-- Jump action
					if this.CurrentWaypointNeedsJump then
						this.NextActionJump = true
						this.CurrentWaypointNeedsJump = false	-- Request jump only once
					else
						this.NextActionJump = false
					end
				end
			end
		end

		function this:IsCurrentWaypointReached()
			local reached = false

			-- Check we do have a plane, if not, we consider the waypoint reached
			if this.CurrentWaypointPlaneNormal ~= ZERO_VECTOR3 then
				-- Compute distance of Humanoid from destination plane
				local dist = this.CurrentWaypointPlaneNormal:Dot(this.CurrentHumanoidPosition) - this.CurrentWaypointPlaneDistance
				-- Compute the component of the Humanoid velocity that is towards the plane
				local velocity = -this.CurrentWaypointPlaneNormal:Dot(this.CurrentHumanoidVelocity)
				-- Compute the threshold from the destination plane based on Humanoid velocity
				local threshold = math.max(1.0, 0.0625 * velocity)
				-- If we are less then threshold in front of the plane (between 0 and threshold) or if we are behing the plane (less then 0), we consider we reached it
				reached = dist < threshold
			else
				reached = true
			end

			if reached then
				this.CurrentWaypointPosition = nil
				this.CurrentWaypointPlaneNormal	= ZERO_VECTOR3
				this.CurrentWaypointPlaneDistance = 0
			end

			return reached
		end

		function this:OnPointReached(reached)

			if reached and not this.Cancelled then
				-- First, destroyed the current displayed waypoint
				if this.setPointFunc then
					this.setPointFunc(this.CurrentPoint)
				end

				local nextWaypointIdx = this.CurrentPoint + 1

				if nextWaypointIdx > #this.pointList then
					-- End of path reached
					if this.stopTraverseFunc then
						this.stopTraverseFunc()
					end
					this.Finished:Fire()
					this:Cleanup()
				else
					local currentWaypoint = this.pointList[this.CurrentPoint]
					local nextWaypoint = this.pointList[nextWaypointIdx]

					-- If airborne, only allow to keep moving
					-- if nextWaypoint.Action ~= Jump, or path mantains a direction
					-- Otherwise, wait until the humanoid gets to the ground
					local currentState = this.Humanoid:GetState()
					local isInAir = currentState == Enum.HumanoidStateType.FallingDown
						or currentState == Enum.HumanoidStateType.Freefall
						or currentState == Enum.HumanoidStateType.Jumping

					if isInAir then
						local shouldWaitForGround = nextWaypoint.Action == Enum.PathWaypointAction.Jump
						if not shouldWaitForGround and this.CurrentPoint > 1 then
							local prevWaypoint = this.pointList[this.CurrentPoint - 1]

							local prevDir = currentWaypoint.Position - prevWaypoint.Position
							local currDir = nextWaypoint.Position - currentWaypoint.Position

							local prevDirXZ = Vector2.new(prevDir.x, prevDir.z).Unit
							local currDirXZ = Vector2.new(currDir.x, currDir.z).Unit

							local THRESHOLD_COS = 0.996 -- ~cos(5 degrees)
							shouldWaitForGround = prevDirXZ:Dot(currDirXZ) < THRESHOLD_COS
						end

						if shouldWaitForGround then
							this.Humanoid.FreeFalling:Wait()

							-- Give time to the humanoid's state to change
							-- Otherwise, the jump flag in Humanoid
							-- will be reset by the state change
							wait(0.1)
						end
					end

					-- Move to the next point
					this:MoveToNextWayPoint(currentWaypoint, nextWaypoint, nextWaypointIdx)
				end
			else
				this.PathFailed:Fire()
				this:Cleanup()
			end
		end

		function this:MoveToNextWayPoint(currentWaypoint: PathWaypoint, nextWaypoint: PathWaypoint, nextWaypointIdx: number)
			-- Build next destination plane
			-- (plane normal is perpendicular to the y plane and is from next waypoint towards current one (provided the two waypoints are not at the same location))
			-- (plane location is at next waypoint)
			this.CurrentWaypointPlaneNormal = currentWaypoint.Position - nextWaypoint.Position

			-- plane normal isn't perpendicular to the y plane when climbing up
			if not FFlagUserClickToMoveSupportAgentCanClimb or (nextWaypoint.Label ~= "Climb") then
				this.CurrentWaypointPlaneNormal = Vector3.new(this.CurrentWaypointPlaneNormal.X, 0, this.CurrentWaypointPlaneNormal.Z)
			end
			if this.CurrentWaypointPlaneNormal.Magnitude > ALMOST_ZERO then
				this.CurrentWaypointPlaneNormal	= this.CurrentWaypointPlaneNormal.Unit
				this.CurrentWaypointPlaneDistance = this.CurrentWaypointPlaneNormal:Dot(nextWaypoint.Position)
			else
				-- Next waypoint is the same as current waypoint so no plane
				this.CurrentWaypointPlaneNormal	= ZERO_VECTOR3
				this.CurrentWaypointPlaneDistance = 0
			end

			-- Should we jump
			this.CurrentWaypointNeedsJump = nextWaypoint.Action == Enum.PathWaypointAction.Jump;

			-- Remember next waypoint position
			this.CurrentWaypointPosition = nextWaypoint.Position

			-- Move to next point
			this.CurrentPoint = nextWaypointIdx

			-- Finally reset Timeout
			this.Timeout = 0
		end

		function this:Start(overrideShowPath)
			if not this.AgentCanFollowPath then
				this.PathFailed:Fire()
				return
			end

			if this.Started then return end
			this.Started = true

			ClickToMoveDisplay.CancelFailureAnimation()

			if ShowPath then
				if overrideShowPath == nil or overrideShowPath then
					this.stopTraverseFunc, this.setPointFunc = ClickToMoveDisplay.CreatePathDisplay(this.pointList, this.OriginalTargetPoint)
				end
			end

			if #this.pointList > 0 then
				-- Determine the humanoid offset from the path's first point
				-- Offset of the first waypoint from the path's origin point
				this.HumanoidOffsetFromPath = Vector3.new(0, this.pointList[1].Position.Y - this.OriginPoint.Y, 0)

				-- As well as its current position and velocity
				this.CurrentHumanoidPosition = this.Humanoid.RootPart.Position + this.HumanoidOffsetFromPath
				this.CurrentHumanoidVelocity = this.Humanoid.RootPart.Velocity

				-- Connect to events
				this.SeatedConn = this.Humanoid.Seated:Connect(function(isSeated, seat) this:OnPathInterrupted() end)
				this.DiedConn = this.Humanoid.Died:Connect(function() this:OnPathInterrupted() end)
				this.TeleportedConn = this.Humanoid.RootPart:GetPropertyChangedSignal("CFrame"):Connect(function() this:OnPathInterrupted() end)

				-- Actually start
				this.CurrentPoint = 1 -- The first waypoint is always the start location. Skip it.
				this:OnPointReached(true) -- Move to first point
			else
				this.PathFailed:Fire()
				if this.stopTraverseFunc then
					this.stopTraverseFunc()
				end
			end
		end

		--We always raycast to the ground in the case that the user clicked a wall.
		local offsetPoint = this.TargetPoint + this.TargetSurfaceNormal*1.5
		local ray = Ray.new(offsetPoint, Vector3.new(0,-1,0)*50)
		local newHitPart, newHitPos = Workspace:FindPartOnRayWithIgnoreList(ray, getIgnoreList())
		if newHitPart then
			this.TargetPoint = newHitPos
		end
		this:ComputePath()

		return this
	end

	-------------------------------------------------------------------------

	local function CheckAlive()
		local humanoid = findPlayerHumanoid(Player)
		return humanoid ~= nil and humanoid.Health > 0
	end

	local function GetEquippedTool(character: Model?)
		if character ~= nil then
			for _, child in pairs(character:GetChildren()) do
				if child:IsA('Tool') then
					return child
				end
			end
		end
	end

	local ExistingPather = nil
	local ExistingIndicator = nil
	local PathCompleteListener = nil
	local PathFailedListener = nil

	local function CleanupPath()
		if ExistingPather then
			ExistingPather:Cancel()
			ExistingPather = nil
		end
		if PathCompleteListener then
			PathCompleteListener:Disconnect()
			PathCompleteListener = nil
		end
		if PathFailedListener then
			PathFailedListener:Disconnect()
			PathFailedListener = nil
		end
		if ExistingIndicator then
			ExistingIndicator:Destroy()
		end
	end

	local function HandleMoveTo(thisPather, hitPt, hitChar, character, overrideShowPath)
		if ExistingPather then
			CleanupPath()
		end
		ExistingPather = thisPather
		thisPather:Start(overrideShowPath)

		PathCompleteListener = thisPather.Finished.Event:Connect(function()
			CleanupPath()
			if hitChar then
				local currentWeapon = GetEquippedTool(character)
				if currentWeapon then
					currentWeapon:Activate()
				end
			end
		end)
		PathFailedListener = thisPather.PathFailed.Event:Connect(function()
			CleanupPath()
			if overrideShowPath == nil or overrideShowPath then
				local shouldPlayFailureAnim = PlayFailureAnimation and not (ExistingPather and ExistingPather:IsActive())
				if shouldPlayFailureAnim then
					ClickToMoveDisplay.PlayFailureAnimation()
				end
				ClickToMoveDisplay.DisplayFailureWaypoint(hitPt)
			end
		end)
	end

	local function ShowPathFailedFeedback(hitPt)
		if ExistingPather and ExistingPather:IsActive() then
			ExistingPather:Cancel()
		end
		if PlayFailureAnimation then
			ClickToMoveDisplay.PlayFailureAnimation()
		end
		ClickToMoveDisplay.DisplayFailureWaypoint(hitPt)
	end

	function OnTap(tapPositions: {Vector3}, goToPoint: Vector3?, wasTouchTap: boolean?)
		-- Good to remember if this is the latest tap event
		local camera = Workspace.CurrentCamera
		local character = Player.Character

		if not CheckAlive() then return end

		-- This is a path tap position
		if #tapPositions == 1 or goToPoint then
			if camera then
				local unitRay = camera:ScreenPointToRay(tapPositions[1].X, tapPositions[1].Y)
				local ray = Ray.new(unitRay.Origin, unitRay.Direction*1000)

				local myHumanoid = findPlayerHumanoid(Player)
				local hitPart, hitPt, hitNormal = Utility.Raycast(ray, true, getIgnoreList())

				local hitChar, hitHumanoid = Utility.FindCharacterAncestor(hitPart)
				if wasTouchTap and hitHumanoid and StarterGui:GetCore("AvatarContextMenuEnabled") then
					local clickedPlayer = Players:GetPlayerFromCharacter(hitHumanoid.Parent)
					if clickedPlayer then
						CleanupPath()
						return
					end
				end
				if goToPoint then
					hitPt = goToPoint
					hitChar = nil
				end
				if hitPt and character then
					-- Clean up current path
					CleanupPath()
					local thisPather = Pather(hitPt, hitNormal)
					if thisPather:IsValidPath() then
						HandleMoveTo(thisPather, hitPt, hitChar, character)
					else
						-- Clean up
						thisPather:Cleanup()
						-- Feedback here for when we don't have a good path
						ShowPathFailedFeedback(hitPt)
					end
				end
			end
		elseif #tapPositions >= 2 then
			if camera then
				-- Do shoot
				local currentWeapon = GetEquippedTool(character)
				if currentWeapon then
					currentWeapon:Activate()
				end
			end
		end
	end

	local function DisconnectEvent(event)
		if event then
			event:Disconnect()
		end
	end

	--[[ The ClickToMove Controller Class ]]--
	local KeyboardController = require(script.Parent:WaitForChild("Keyboard"))
	local ClickToMove = setmetatable({}, KeyboardController)
	ClickToMove.__index = ClickToMove

	function ClickToMove.new(CONTROL_ACTION_PRIORITY)
		local self = setmetatable(KeyboardController.new(CONTROL_ACTION_PRIORITY), ClickToMove)

		self.fingerTouches = {}
		self.numUnsunkTouches = 0
		-- PC simulation
		self.mouse1Down = tick()
		self.mouse1DownPos = Vector2.new()
		self.mouse2DownTime = tick()
		self.mouse2DownPos = Vector2.new()
		self.mouse2UpTime = tick()

		self.keyboardMoveVector = ZERO_VECTOR3

		self.tapConn = nil
		self.inputBeganConn = nil
		self.inputChangedConn = nil
		self.inputEndedConn = nil
		self.humanoidDiedConn = nil
		self.characterChildAddedConn = nil
		self.onCharacterAddedConn = nil
		self.characterChildRemovedConn = nil
		self.renderSteppedConn = nil
		self.menuOpenedConnection = nil

		self.running = false

		self.wasdEnabled = false

		return self
	end

	function ClickToMove:DisconnectEvents()
		DisconnectEvent(self.tapConn)
		DisconnectEvent(self.inputBeganConn)
		DisconnectEvent(self.inputChangedConn)
		DisconnectEvent(self.inputEndedConn)
		DisconnectEvent(self.humanoidDiedConn)
		DisconnectEvent(self.characterChildAddedConn)
		DisconnectEvent(self.onCharacterAddedConn)
		DisconnectEvent(self.renderSteppedConn)
		DisconnectEvent(self.characterChildRemovedConn)
		DisconnectEvent(self.menuOpenedConnection)
	end

	function ClickToMove:OnTouchBegan(input, processed)
		if self.fingerTouches[input] == nil and not processed then
			self.numUnsunkTouches = self.numUnsunkTouches + 1
		end
		self.fingerTouches[input] = processed
	end

	function ClickToMove:OnTouchChanged(input, processed)
		if self.fingerTouches[input] == nil then
			self.fingerTouches[input] = processed
			if not processed then
				self.numUnsunkTouches = self.numUnsunkTouches + 1
			end
		end
	end

	function ClickToMove:OnTouchEnded(input, processed)
		if self.fingerTouches[input] ~= nil and self.fingerTouches[input] == false then
			self.numUnsunkTouches = self.numUnsunkTouches - 1
		end
		self.fingerTouches[input] = nil
	end


	function ClickToMove:OnCharacterAdded(character)
		self:DisconnectEvents()

		self.inputBeganConn = UserInputService.InputBegan:Connect(function(input, processed)
			if input.UserInputType == Enum.UserInputType.Touch then
				self:OnTouchBegan(input, processed)
			end

			-- Cancel path when you use the keyboard controls if wasd is enabled.
			if self.wasdEnabled and processed == false and input.UserInputType == Enum.UserInputType.Keyboard
				and movementKeys[input.KeyCode] then
				CleanupPath()
				ClickToMoveDisplay.CancelFailureAnimation()
			end
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				self.mouse1DownTime = tick()
				self.mouse1DownPos = input.Position
			end
			if input.UserInputType == Enum.UserInputType.MouseButton2 then
				self.mouse2DownTime = tick()
				self.mouse2DownPos = input.Position
			end
		end)

		self.inputChangedConn = UserInputService.InputChanged:Connect(function(input, processed)
			if input.UserInputType == Enum.UserInputType.Touch then
				self:OnTouchChanged(input, processed)
			end
		end)

		self.inputEndedConn = UserInputService.InputEnded:Connect(function(input, processed)
			if input.UserInputType == Enum.UserInputType.Touch then
				self:OnTouchEnded(input, processed)
			end

			if input.UserInputType == Enum.UserInputType.MouseButton2 then
				self.mouse2UpTime = tick()
				local currPos: Vector3 = input.Position
				-- We allow click to move during path following or if there is no keyboard movement
				local allowed = ExistingPather or self.keyboardMoveVector.Magnitude <= 0
				if self.mouse2UpTime - self.mouse2DownTime < 0.25 and (currPos - self.mouse2DownPos).magnitude < 5 and allowed then
					local positions = {currPos}
					OnTap(positions)
				end
			end
		end)

		self.tapConn = UserInputService.TouchTap:Connect(function(touchPositions, processed)
			if not processed then
				OnTap(touchPositions, nil, true)
			end
		end)

		self.menuOpenedConnection = GuiService.MenuOpened:Connect(function()
			CleanupPath()
		end)

		local function OnCharacterChildAdded(child)
			if UserInputService.TouchEnabled then
				if child:IsA('Tool') then
					child.ManualActivationOnly = true
				end
			end
			if child:IsA('Humanoid') then
				DisconnectEvent(self.humanoidDiedConn)
				self.humanoidDiedConn = child.Died:Connect(function()
					if ExistingIndicator then
						DebrisService:AddItem(ExistingIndicator.Model, 1)
					end
				end)
			end
		end

		self.characterChildAddedConn = character.ChildAdded:Connect(function(child)
			OnCharacterChildAdded(child)
		end)
		self.characterChildRemovedConn = character.ChildRemoved:Connect(function(child)
			if UserInputService.TouchEnabled then
				if child:IsA('Tool') then
					child.ManualActivationOnly = false
				end
			end
		end)
		for _, child in pairs(character:GetChildren()) do
			OnCharacterChildAdded(child)
		end
	end

	function ClickToMove:Start()
		self:Enable(true)
	end

	function ClickToMove:Stop()
		self:Enable(false)
	end

	function ClickToMove:CleanupPath()
		CleanupPath()
	end

	function ClickToMove:Enable(enable: boolean, enableWASD: boolean, touchJumpController)
		if enable then
			if not self.running then
				if Player.Character then -- retro-listen
					self:OnCharacterAdded(Player.Character)
				end
				self.onCharacterAddedConn = Player.CharacterAdded:Connect(function(char)
					self:OnCharacterAdded(char)
				end)
				self.running = true
			end
			self.touchJumpController = touchJumpController
			if self.touchJumpController then
				self.touchJumpController:Enable(self.jumpEnabled)
			end
		else
			if self.running then
				self:DisconnectEvents()
				CleanupPath()
				-- Restore tool activation on shutdown
				if UserInputService.TouchEnabled then
					local character = Player.Character
					if character then
						for _, child in pairs(character:GetChildren()) do
							if child:IsA('Tool') then
								child.ManualActivationOnly = false
							end
						end
					end
				end
				self.running = false
			end
			if self.touchJumpController and not self.jumpEnabled then
				self.touchJumpController:Enable(true)
			end
			self.touchJumpController = nil
		end

		-- Extension for initializing Keyboard input as this class now derives from Keyboard
		if UserInputService.KeyboardEnabled and enable ~= self.enabled then

			self.forwardValue  = 0
			self.backwardValue = 0
			self.leftValue = 0
			self.rightValue = 0

			self.moveVector = ZERO_VECTOR3

			if enable then
				self:BindContextActions()
				self:ConnectFocusEventListeners()
			else
				self:UnbindContextActions()
				self:DisconnectFocusEventListeners()
			end
		end

		self.wasdEnabled = enable and enableWASD or false
		self.enabled = enable
	end

	function ClickToMove:OnRenderStepped(dt)
		-- Reset jump
		self.isJumping = false

		-- Handle Pather
		if ExistingPather then
			-- Let the Pather update
			ExistingPather:OnRenderStepped(dt)

			-- If we still have a Pather, set the resulting actions
			if ExistingPather then
				-- Setup move (NOT relative to camera)
				self.moveVector = ExistingPather.NextActionMoveDirection
				self.moveVectorIsCameraRelative = false

				-- Setup jump (but do NOT prevent the base Keayboard class from requesting jumps as well)
				if ExistingPather.NextActionJump then
					self.isJumping = true
				end
			else
				self.moveVector = self.keyboardMoveVector
				self.moveVectorIsCameraRelative = true
			end
		else
			self.moveVector = self.keyboardMoveVector
			self.moveVectorIsCameraRelative = true
		end

		-- Handle Keyboard's jump
		if self.jumpRequested then
			self.isJumping = true
		end
	end

	-- Overrides Keyboard:UpdateMovement(inputState) to conditionally consider self.wasdEnabled and let OnRenderStepped handle the movement
	function ClickToMove:UpdateMovement(inputState)
		if inputState == Enum.UserInputState.Cancel then
			self.keyboardMoveVector = ZERO_VECTOR3
		elseif self.wasdEnabled then
			self.keyboardMoveVector = Vector3.new(self.leftValue + self.rightValue, 0, self.forwardValue + self.backwardValue)
		end
	end

	-- Overrides Keyboard:UpdateJump() because jump is handled in OnRenderStepped
	function ClickToMove:UpdateJump()
		-- Nothing to do (handled in OnRenderStepped)
	end

	--Public developer facing functions
	function ClickToMove:SetShowPath(value)
		ShowPath = value
	end

	function ClickToMove:GetShowPath()
		return ShowPath
	end

	function ClickToMove:SetWaypointTexture(texture)
		ClickToMoveDisplay.SetWaypointTexture(texture)
	end

	function ClickToMove:GetWaypointTexture()
		return ClickToMoveDisplay.GetWaypointTexture()
	end

	function ClickToMove:SetWaypointRadius(radius)
		ClickToMoveDisplay.SetWaypointRadius(radius)
	end

	function ClickToMove:GetWaypointRadius()
		return ClickToMoveDisplay.GetWaypointRadius()
	end

	function ClickToMove:SetEndWaypointTexture(texture)
		ClickToMoveDisplay.SetEndWaypointTexture(texture)
	end

	function ClickToMove:GetEndWaypointTexture()
		return ClickToMoveDisplay.GetEndWaypointTexture()
	end

	function ClickToMove:SetWaypointsAlwaysOnTop(alwaysOnTop)
		ClickToMoveDisplay.SetWaypointsAlwaysOnTop(alwaysOnTop)
	end

	function ClickToMove:GetWaypointsAlwaysOnTop()
		return ClickToMoveDisplay.GetWaypointsAlwaysOnTop()
	end

	function ClickToMove:SetFailureAnimationEnabled(enabled)
		PlayFailureAnimation = enabled
	end

	function ClickToMove:GetFailureAnimationEnabled()
		return PlayFailureAnimation
	end

	function ClickToMove:SetIgnoredPartsTag(tag)
		UpdateIgnoreTag(tag)
	end

	function ClickToMove:GetIgnoredPartsTag()
		return CurrentIgnoreTag
	end

	function ClickToMove:SetUseDirectPath(directPath)
		UseDirectPath = directPath
	end

	function ClickToMove:GetUseDirectPath()
		return UseDirectPath
	end

	function ClickToMove:SetAgentSizeIncreaseFactor(increaseFactorPercent: number)
		AgentSizeIncreaseFactor = 1.0 + (increaseFactorPercent / 100.0)
	end

	function ClickToMove:GetAgentSizeIncreaseFactor()
		return (AgentSizeIncreaseFactor - 1.0) * 100.0
	end

	function ClickToMove:SetUnreachableWaypointTimeout(timeoutInSec)
		UnreachableWaypointTimeout = timeoutInSec
	end

	function ClickToMove:GetUnreachableWaypointTimeout()
		return UnreachableWaypointTimeout
	end

	function ClickToMove:SetUserJumpEnabled(jumpEnabled)
		self.jumpEnabled = jumpEnabled
		if self.touchJumpController then
			self.touchJumpController:Enable(jumpEnabled)
		end
	end

	function ClickToMove:GetUserJumpEnabled()
		return self.jumpEnabled
	end

	function ClickToMove:MoveTo(position, showPath, useDirectPath)
		local character = Player.Character
		if character == nil then
			return false
		end
		local thisPather = Pather(position, Vector3.new(0, 1, 0), useDirectPath)
		if thisPather and thisPather:IsValidPath() then
			HandleMoveTo(thisPather, position, nil, character, showPath)
			return true
		end
		return false
	end

	return ClickToMove

end))
ModuleScript37.Name = "PathDisplay"
ModuleScript37.Parent = ModuleScript28
table.insert(cors,sandbox(ModuleScript37,function()
	--!nonstrict


	local PathDisplay = {}
	PathDisplay.spacing = 8
	PathDisplay.image = "rbxasset://textures/Cursors/Gamepad/Pointer.png"
	PathDisplay.imageSize = Vector2.new(2, 2)

	local currentPoints = {}
	local renderedPoints = {}

	local pointModel = Instance.new("Model")
	pointModel.Name = "PathDisplayPoints"

	local adorneePart = Instance.new("Part")
	adorneePart.Anchored = true
	adorneePart.CanCollide = false
	adorneePart.Transparency = 1
	adorneePart.Name = "PathDisplayAdornee"
	adorneePart.CFrame = CFrame.new(0, 0, 0)
	adorneePart.Parent = pointModel

	local pointPool = {}
	local poolTop = 30
	for i = 1, poolTop do
		local point = Instance.new("ImageHandleAdornment")
		point.Archivable = false
		point.Adornee = adorneePart
		point.Image = PathDisplay.image
		point.Size = PathDisplay.imageSize
		pointPool[i] = point
	end

	local function retrieveFromPool(): ImageHandleAdornment?
		local point = pointPool[1]
		if not point then
			return nil
		end

		pointPool[1], pointPool[poolTop] = pointPool[poolTop], nil
		poolTop = poolTop - 1
		return point
	end

	local function returnToPool(point: ImageHandleAdornment)
		poolTop = poolTop + 1
		pointPool[poolTop] = point
	end

	local function renderPoint(point: Vector3, isLast): ImageHandleAdornment?
		if poolTop == 0 then
			return nil
		end

		local rayDown = Ray.new(point + Vector3.new(0, 2, 0), Vector3.new(0, -8, 0))
		local hitPart, hitPoint, hitNormal = workspace:FindPartOnRayWithIgnoreList(rayDown, { (game.Players.LocalPlayer :: Player).Character :: Model, workspace.CurrentCamera :: Camera })
		if not hitPart then
			return nil
		end

		local pointCFrame = CFrame.new(hitPoint, hitPoint + hitNormal)

		local point = retrieveFromPool()
		point.CFrame = pointCFrame
		point.Parent = pointModel
		return point
	end

	function PathDisplay.setCurrentPoints(points)
		if typeof(points) == 'table' then
			currentPoints = points
		else
			currentPoints = {}
		end
	end

	function PathDisplay.clearRenderedPath()
		for _, oldPoint in ipairs(renderedPoints) do
			oldPoint.Parent = nil
			returnToPool(oldPoint)
		end
		renderedPoints = {}
		pointModel.Parent = nil
	end

	function PathDisplay.renderPath()
		PathDisplay.clearRenderedPath()
		if not currentPoints or #currentPoints == 0 then
			return
		end

		local currentIdx = #currentPoints
		local lastPos = currentPoints[currentIdx]
		local distanceBudget = 0

		renderedPoints[1] = renderPoint(lastPos, true)
		if not renderedPoints[1] then
			return
		end

		while true do
			local currentPoint = currentPoints[currentIdx]
			local nextPoint = currentPoints[currentIdx - 1]

			if currentIdx < 2 then
				break
			else

				local toNextPoint = nextPoint - currentPoint
				local distToNextPoint = toNextPoint.magnitude

				if distanceBudget > distToNextPoint then
					distanceBudget = distanceBudget - distToNextPoint
					currentIdx = currentIdx - 1
				else
					local dirToNextPoint = toNextPoint.unit
					local pointPos = currentPoint + (dirToNextPoint * distanceBudget)
					local point = renderPoint(pointPos, false)

					if point then
						renderedPoints[#renderedPoints + 1] = point
					end

					distanceBudget = distanceBudget + PathDisplay.spacing
				end
			end
		end

		pointModel.Parent = workspace.CurrentCamera
	end

	return PathDisplay

end))
ModuleScript38.Name = "ClickToMoveDisplay"
ModuleScript38.Parent = ModuleScript28
table.insert(cors,sandbox(ModuleScript38,function()
	--!nonstrict
	local ClickToMoveDisplay = {}

	local FAILURE_ANIMATION_ID = "rbxassetid://2874840706"

	local TrailDotIcon = "rbxasset://textures/ui/traildot.png"
	local EndWaypointIcon = "rbxasset://textures/ui/waypoint.png"

	local WaypointsAlwaysOnTop = false

	local WAYPOINT_INCLUDE_FACTOR = 2
	local LAST_DOT_DISTANCE = 3

	local WAYPOINT_BILLBOARD_SIZE = UDim2.new(0, 1.68 * 25, 0, 2 * 25)

	local ENDWAYPOINT_SIZE_OFFSET_MIN = Vector2.new(0, 0.5)
	local ENDWAYPOINT_SIZE_OFFSET_MAX = Vector2.new(0, 1)

	local FAIL_WAYPOINT_SIZE_OFFSET_CENTER = Vector2.new(0, 0.5)
	local FAIL_WAYPOINT_SIZE_OFFSET_LEFT = Vector2.new(0.1, 0.5)
	local FAIL_WAYPOINT_SIZE_OFFSET_RIGHT = Vector2.new(-0.1, 0.5)

	local FAILURE_TWEEN_LENGTH = 0.125
	local FAILURE_TWEEN_COUNT = 4

	local TWEEN_WAYPOINT_THRESHOLD = 5

	local TRAIL_DOT_PARENT_NAME = "ClickToMoveDisplay"

	local TrailDotSize = Vector2.new(1.5, 1.5)

	local TRAIL_DOT_MIN_SCALE = 1
	local TRAIL_DOT_MIN_DISTANCE = 10
	local TRAIL_DOT_MAX_SCALE = 2.5
	local TRAIL_DOT_MAX_DISTANCE = 100

	local PlayersService = game:GetService("Players")
	local TweenService = game:GetService("TweenService")
	local RunService = game:GetService("RunService")
	local Workspace = game:GetService("Workspace")

	local LocalPlayer = PlayersService.LocalPlayer

	local function CreateWaypointTemplates()
		local TrailDotTemplate = Instance.new("Part")
		TrailDotTemplate.Size = Vector3.new(1, 1, 1)
		TrailDotTemplate.Anchored = true
		TrailDotTemplate.CanCollide = false
		TrailDotTemplate.Name = "TrailDot"
		TrailDotTemplate.Transparency = 1
		local TrailDotImage = Instance.new("ImageHandleAdornment")
		TrailDotImage.Name = "TrailDotImage"
		TrailDotImage.Size = TrailDotSize
		TrailDotImage.SizeRelativeOffset = Vector3.new(0, 0, -0.1)
		TrailDotImage.AlwaysOnTop = WaypointsAlwaysOnTop
		TrailDotImage.Image = TrailDotIcon
		TrailDotImage.Adornee = TrailDotTemplate
		TrailDotImage.Parent = TrailDotTemplate

		local EndWaypointTemplate = Instance.new("Part")
		EndWaypointTemplate.Size = Vector3.new(2, 2, 2)
		EndWaypointTemplate.Anchored = true
		EndWaypointTemplate.CanCollide = false
		EndWaypointTemplate.Name = "EndWaypoint"
		EndWaypointTemplate.Transparency = 1
		local EndWaypointImage = Instance.new("ImageHandleAdornment")
		EndWaypointImage.Name = "TrailDotImage"
		EndWaypointImage.Size = TrailDotSize
		EndWaypointImage.SizeRelativeOffset = Vector3.new(0, 0, -0.1)
		EndWaypointImage.AlwaysOnTop = WaypointsAlwaysOnTop
		EndWaypointImage.Image = TrailDotIcon
		EndWaypointImage.Adornee = EndWaypointTemplate
		EndWaypointImage.Parent = EndWaypointTemplate
		local EndWaypointBillboard = Instance.new("BillboardGui")
		EndWaypointBillboard.Name = "EndWaypointBillboard"
		EndWaypointBillboard.Size = WAYPOINT_BILLBOARD_SIZE
		EndWaypointBillboard.LightInfluence = 0
		EndWaypointBillboard.SizeOffset = ENDWAYPOINT_SIZE_OFFSET_MIN
		EndWaypointBillboard.AlwaysOnTop = true
		EndWaypointBillboard.Adornee = EndWaypointTemplate
		EndWaypointBillboard.Parent = EndWaypointTemplate
		local EndWaypointImageLabel = Instance.new("ImageLabel")
		EndWaypointImageLabel.Image = EndWaypointIcon
		EndWaypointImageLabel.BackgroundTransparency = 1
		EndWaypointImageLabel.Size = UDim2.new(1, 0, 1, 0)
		EndWaypointImageLabel.Parent = EndWaypointBillboard


		local FailureWaypointTemplate = Instance.new("Part")
		FailureWaypointTemplate.Size = Vector3.new(2, 2, 2)
		FailureWaypointTemplate.Anchored = true
		FailureWaypointTemplate.CanCollide = false
		FailureWaypointTemplate.Name = "FailureWaypoint"
		FailureWaypointTemplate.Transparency = 1
		local FailureWaypointImage = Instance.new("ImageHandleAdornment")
		FailureWaypointImage.Name = "TrailDotImage"
		FailureWaypointImage.Size = TrailDotSize
		FailureWaypointImage.SizeRelativeOffset = Vector3.new(0, 0, -0.1)
		FailureWaypointImage.AlwaysOnTop = WaypointsAlwaysOnTop
		FailureWaypointImage.Image = TrailDotIcon
		FailureWaypointImage.Adornee = FailureWaypointTemplate
		FailureWaypointImage.Parent = FailureWaypointTemplate
		local FailureWaypointBillboard = Instance.new("BillboardGui")
		FailureWaypointBillboard.Name = "FailureWaypointBillboard"
		FailureWaypointBillboard.Size = WAYPOINT_BILLBOARD_SIZE
		FailureWaypointBillboard.LightInfluence = 0
		FailureWaypointBillboard.SizeOffset = FAIL_WAYPOINT_SIZE_OFFSET_CENTER
		FailureWaypointBillboard.AlwaysOnTop = true
		FailureWaypointBillboard.Adornee = FailureWaypointTemplate
		FailureWaypointBillboard.Parent = FailureWaypointTemplate
		local FailureWaypointFrame = Instance.new("Frame")
		FailureWaypointFrame.BackgroundTransparency = 1
		FailureWaypointFrame.Size = UDim2.new(0, 0, 0, 0)
		FailureWaypointFrame.Position = UDim2.new(0.5, 0, 1, 0)
		FailureWaypointFrame.Parent = FailureWaypointBillboard
		local FailureWaypointImageLabel = Instance.new("ImageLabel")
		FailureWaypointImageLabel.Image = EndWaypointIcon
		FailureWaypointImageLabel.BackgroundTransparency = 1
		FailureWaypointImageLabel.Position = UDim2.new(
			0, -WAYPOINT_BILLBOARD_SIZE.X.Offset/2, 0, -WAYPOINT_BILLBOARD_SIZE.Y.Offset
		)
		FailureWaypointImageLabel.Size = WAYPOINT_BILLBOARD_SIZE
		FailureWaypointImageLabel.Parent = FailureWaypointFrame

		return TrailDotTemplate, EndWaypointTemplate, FailureWaypointTemplate
	end

	local TrailDotTemplate, EndWaypointTemplate, FailureWaypointTemplate = CreateWaypointTemplates()

	local function getTrailDotParent()
		local camera = Workspace.CurrentCamera
		local trailParent = camera:FindFirstChild(TRAIL_DOT_PARENT_NAME)
		if not trailParent then
			trailParent = Instance.new("Model")
			trailParent.Name = TRAIL_DOT_PARENT_NAME
			trailParent.Parent = camera
		end
		return trailParent
	end

	local function placePathWaypoint(waypointModel, position: Vector3)
		local ray = Ray.new(position + Vector3.new(0, 2.5, 0), Vector3.new(0, -10, 0))
		local hitPart, hitPoint, hitNormal = Workspace:FindPartOnRayWithIgnoreList(
			ray,
			{ Workspace.CurrentCamera, LocalPlayer.Character }
		)
		if hitPart then
			waypointModel.CFrame = CFrame.new(hitPoint, hitPoint + hitNormal)
			waypointModel.Parent = getTrailDotParent()
		end
	end

	local TrailDot = {}
	TrailDot.__index = TrailDot

	function TrailDot:Destroy()
		self.DisplayModel:Destroy()
	end

	function TrailDot:NewDisplayModel(position)
		local newDisplayModel: Part = TrailDotTemplate:Clone()
		placePathWaypoint(newDisplayModel, position)
		return newDisplayModel
	end

	function TrailDot.new(position, closestWaypoint)
		local self = setmetatable({}, TrailDot)

		self.DisplayModel = self:NewDisplayModel(position)
		self.ClosestWayPoint = closestWaypoint

		return self
	end

	local EndWaypoint = {}
	EndWaypoint.__index = EndWaypoint

	function EndWaypoint:Destroy()
		self.Destroyed = true
		self.Tween:Cancel()
		self.DisplayModel:Destroy()
	end

	function EndWaypoint:NewDisplayModel(position)
		local newDisplayModel: Part = EndWaypointTemplate:Clone()
		placePathWaypoint(newDisplayModel, position)
		return newDisplayModel
	end

	function EndWaypoint:CreateTween()
		local tweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, -1, true)
		local tween = TweenService:Create(
			self.DisplayModel.EndWaypointBillboard,
			tweenInfo,
			{ SizeOffset = ENDWAYPOINT_SIZE_OFFSET_MAX }
		)
		tween:Play()
		return tween
	end

	function EndWaypoint:TweenInFrom(originalPosition: Vector3)
		local currentPositon: Vector3 = self.DisplayModel.Position
		local studsOffset = originalPosition - currentPositon
		self.DisplayModel.EndWaypointBillboard.StudsOffset = Vector3.new(0, studsOffset.Y, 0)
		local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
		local tween = TweenService:Create(
			self.DisplayModel.EndWaypointBillboard,
			tweenInfo,
			{ StudsOffset = Vector3.new(0, 0, 0) }
		)
		tween:Play()
		return tween
	end

	function EndWaypoint.new(position: Vector3, closestWaypoint: number?, originalPosition: Vector3?)
		local self = setmetatable({}, EndWaypoint)

		self.DisplayModel = self:NewDisplayModel(position)
		self.Destroyed = false
		if originalPosition and (originalPosition - position).Magnitude > TWEEN_WAYPOINT_THRESHOLD then
			self.Tween = self:TweenInFrom(originalPosition)
			coroutine.wrap(function()
				self.Tween.Completed:Wait()
				if not self.Destroyed then
					self.Tween = self:CreateTween()
				end
			end)()
		else
			self.Tween = self:CreateTween()
		end
		self.ClosestWayPoint = closestWaypoint

		return self
	end

	local FailureWaypoint = {}
	FailureWaypoint.__index = FailureWaypoint

	function FailureWaypoint:Hide()
		self.DisplayModel.Parent = nil
	end

	function FailureWaypoint:Destroy()
		self.DisplayModel:Destroy()
	end

	function FailureWaypoint:NewDisplayModel(position)
		local newDisplayModel: Part = FailureWaypointTemplate:Clone()
		placePathWaypoint(newDisplayModel, position)
		local ray = Ray.new(position + Vector3.new(0, 2.5, 0), Vector3.new(0, -10, 0))
		local hitPart, hitPoint, hitNormal = Workspace:FindPartOnRayWithIgnoreList(
			ray, { Workspace.CurrentCamera, LocalPlayer.Character }
		)
		if hitPart then
			newDisplayModel.CFrame = CFrame.new(hitPoint, hitPoint + hitNormal)
			newDisplayModel.Parent = getTrailDotParent()
		end
		return newDisplayModel
	end

	function FailureWaypoint:RunFailureTween()
		wait(FAILURE_TWEEN_LENGTH) -- Delay one tween length betfore starting tweening
		-- Tween out from center
		local tweenInfo = TweenInfo.new(FAILURE_TWEEN_LENGTH/2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
		local tweenLeft = TweenService:Create(self.DisplayModel.FailureWaypointBillboard, tweenInfo,
			{ SizeOffset = FAIL_WAYPOINT_SIZE_OFFSET_LEFT })
		tweenLeft:Play()

		local tweenLeftRoation = TweenService:Create(self.DisplayModel.FailureWaypointBillboard.Frame, tweenInfo,
			{ Rotation = 10 })
		tweenLeftRoation:Play()

		tweenLeft.Completed:wait()

		-- Tween back and forth
		tweenInfo = TweenInfo.new(FAILURE_TWEEN_LENGTH, Enum.EasingStyle.Sine, Enum.EasingDirection.Out,
			FAILURE_TWEEN_COUNT - 1, true)
		local tweenSideToSide = TweenService:Create(self.DisplayModel.FailureWaypointBillboard, tweenInfo,
			{ SizeOffset = FAIL_WAYPOINT_SIZE_OFFSET_RIGHT})
		tweenSideToSide:Play()

		-- Tween flash dark and roate left and right
		tweenInfo = TweenInfo.new(FAILURE_TWEEN_LENGTH, Enum.EasingStyle.Sine, Enum.EasingDirection.Out,
			FAILURE_TWEEN_COUNT - 1, true)
		local tweenFlash = TweenService:Create(self.DisplayModel.FailureWaypointBillboard.Frame.ImageLabel, tweenInfo,
			{ ImageColor3 = Color3.new(0.75, 0.75, 0.75)})
		tweenFlash:Play()

		local tweenRotate = TweenService:Create(self.DisplayModel.FailureWaypointBillboard.Frame, tweenInfo,
			{ Rotation = -10 })
		tweenRotate:Play()

		tweenSideToSide.Completed:wait()

		-- Tween back to center
		tweenInfo = TweenInfo.new(FAILURE_TWEEN_LENGTH/2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)
		local tweenCenter = TweenService:Create(self.DisplayModel.FailureWaypointBillboard, tweenInfo,
			{ SizeOffset = FAIL_WAYPOINT_SIZE_OFFSET_CENTER })
		tweenCenter:Play()

		local tweenRoation = TweenService:Create(self.DisplayModel.FailureWaypointBillboard.Frame, tweenInfo,
			{ Rotation = 0 })
		tweenRoation:Play()

		tweenCenter.Completed:wait()

		wait(FAILURE_TWEEN_LENGTH) -- Delay one tween length betfore removing
	end

	function FailureWaypoint.new(position)
		local self = setmetatable({}, FailureWaypoint)

		self.DisplayModel = self:NewDisplayModel(position)

		return self
	end

	local failureAnimation = Instance.new("Animation")
	failureAnimation.AnimationId = FAILURE_ANIMATION_ID

	local lastHumanoid = nil
	local lastFailureAnimationTrack: AnimationTrack? = nil

	local function getFailureAnimationTrack(myHumanoid)
		if myHumanoid == lastHumanoid then
			return lastFailureAnimationTrack
		end
		lastFailureAnimationTrack = myHumanoid:LoadAnimation(failureAnimation)
		assert(lastFailureAnimationTrack, "")
		lastFailureAnimationTrack.Priority = Enum.AnimationPriority.Action
		lastFailureAnimationTrack.Looped = false
		return lastFailureAnimationTrack
	end

	local function findPlayerHumanoid()
		local character = LocalPlayer.Character
		if character then
			return character:FindFirstChildOfClass("Humanoid")
		end
	end

	local function createTrailDots(wayPoints: {PathWaypoint}, originalEndWaypoint: Vector3)
		local newTrailDots = {}
		local count = 1
		for i = 1, #wayPoints - 1 do
			local closeToEnd = (wayPoints[i].Position - wayPoints[#wayPoints].Position).Magnitude < LAST_DOT_DISTANCE
			local includeWaypoint = i % WAYPOINT_INCLUDE_FACTOR == 0 and not closeToEnd
			if includeWaypoint then
				local trailDot = TrailDot.new(wayPoints[i].Position, i)
				newTrailDots[count] = trailDot
				count = count + 1
			end
		end

		local newEndWaypoint = EndWaypoint.new(wayPoints[#wayPoints].Position, #wayPoints, originalEndWaypoint)
		table.insert(newTrailDots, newEndWaypoint)

		local reversedTrailDots = {}
		count = 1
		for i = #newTrailDots, 1, -1 do
			reversedTrailDots[count] = newTrailDots[i]
			count = count + 1
		end
		return reversedTrailDots
	end

	local function getTrailDotScale(distanceToCamera: number, defaultSize: Vector2)
		local rangeLength = TRAIL_DOT_MAX_DISTANCE - TRAIL_DOT_MIN_DISTANCE
		local inRangePoint = math.clamp(distanceToCamera - TRAIL_DOT_MIN_DISTANCE, 0, rangeLength)/rangeLength
		local scale = TRAIL_DOT_MIN_SCALE + (TRAIL_DOT_MAX_SCALE - TRAIL_DOT_MIN_SCALE)*inRangePoint
		return defaultSize * scale
	end

	local createPathCount = 0
	-- originalEndWaypoint is optional, causes the waypoint to tween from that position.
	function ClickToMoveDisplay.CreatePathDisplay(wayPoints, originalEndWaypoint)
		createPathCount = createPathCount + 1
		local trailDots = createTrailDots(wayPoints, originalEndWaypoint)

		local function removePathBeforePoint(wayPointNumber)
			-- kill all trailDots before and at wayPointNumber
			for i = #trailDots, 1, -1 do
				local trailDot = trailDots[i]
				if trailDot.ClosestWayPoint <= wayPointNumber then
					trailDot:Destroy()
					trailDots[i] = nil
				else
					break
				end
			end
		end

		local reiszeTrailDotsUpdateName = "ClickToMoveResizeTrail" ..createPathCount
		local function resizeTrailDots()
			if #trailDots == 0 then
				RunService:UnbindFromRenderStep(reiszeTrailDotsUpdateName)
				return
			end
			local cameraPos = Workspace.CurrentCamera.CFrame.p
			for i = 1, #trailDots do
				local trailDotImage: ImageHandleAdornment = trailDots[i].DisplayModel:FindFirstChild("TrailDotImage")
				if trailDotImage then
					local distanceToCamera = (trailDots[i].DisplayModel.Position - cameraPos).Magnitude
					trailDotImage.Size = getTrailDotScale(distanceToCamera, TrailDotSize)
				end
			end
		end
		RunService:BindToRenderStep(reiszeTrailDotsUpdateName, Enum.RenderPriority.Camera.Value - 1, resizeTrailDots)

		local function removePath()
			removePathBeforePoint(#wayPoints)
		end

		return removePath, removePathBeforePoint
	end

	local lastFailureWaypoint = nil
	function ClickToMoveDisplay.DisplayFailureWaypoint(position)
		if lastFailureWaypoint then
			lastFailureWaypoint:Hide()
		end
		local failureWaypoint = FailureWaypoint.new(position)
		lastFailureWaypoint = failureWaypoint
		coroutine.wrap(function()
			failureWaypoint:RunFailureTween()
			failureWaypoint:Destroy()
			failureWaypoint = nil
		end)()
	end

	function ClickToMoveDisplay.CreateEndWaypoint(position)
		return EndWaypoint.new(position)
	end

	function ClickToMoveDisplay.PlayFailureAnimation()
		local myHumanoid = findPlayerHumanoid()
		if myHumanoid then
			local animationTrack = getFailureAnimationTrack(myHumanoid)
			animationTrack:Play()
		end
	end

	function ClickToMoveDisplay.CancelFailureAnimation()
		if lastFailureAnimationTrack ~= nil and lastFailureAnimationTrack.IsPlaying then
			lastFailureAnimationTrack:Stop()
		end
	end

	function ClickToMoveDisplay.SetWaypointTexture(texture)
		TrailDotIcon = texture
		TrailDotTemplate, EndWaypointTemplate, FailureWaypointTemplate = CreateWaypointTemplates()
	end

	function ClickToMoveDisplay.GetWaypointTexture()
		return TrailDotIcon
	end

	function ClickToMoveDisplay.SetWaypointRadius(radius)
		TrailDotSize = Vector2.new(radius, radius)
		TrailDotTemplate, EndWaypointTemplate, FailureWaypointTemplate = CreateWaypointTemplates()
	end

	function ClickToMoveDisplay.GetWaypointRadius()
		return TrailDotSize.X
	end

	function ClickToMoveDisplay.SetEndWaypointTexture(texture)
		EndWaypointIcon = texture
		TrailDotTemplate, EndWaypointTemplate, FailureWaypointTemplate = CreateWaypointTemplates()
	end

	function ClickToMoveDisplay.GetEndWaypointTexture()
		return EndWaypointIcon
	end

	function ClickToMoveDisplay.SetWaypointsAlwaysOnTop(alwaysOnTop)
		WaypointsAlwaysOnTop = alwaysOnTop
		TrailDotTemplate, EndWaypointTemplate, FailureWaypointTemplate = CreateWaypointTemplates()
	end

	function ClickToMoveDisplay.GetWaypointsAlwaysOnTop()
		return WaypointsAlwaysOnTop
	end

	return ClickToMoveDisplay

end))
ModuleScript39.Name = "TouchJump"
ModuleScript39.Parent = ModuleScript28
table.insert(cors,sandbox(ModuleScript39,function()
	--!nonstrict
--[[
	// FileName: TouchJump
	// Version 1.0
	// Written by: jmargh
	// Description: Implements jump controls for touch devices. Use with Thumbstick and Thumbpad
--]]

	local Players = game:GetService("Players")
	local GuiService = game:GetService("GuiService")

	--[[ Constants ]]--
	local TOUCH_CONTROL_SHEET = "rbxasset://textures/ui/Input/TouchControlsSheetV2.png"

	--[[ The Module ]]--
	local BaseCharacterController = require(script.Parent:WaitForChild("BaseCharacterController"))
	local TouchJump = setmetatable({}, BaseCharacterController)
	TouchJump.__index = TouchJump

	local FFlagUserResizeAwareTouchControls do
		local success, result = pcall(function()
			return UserSettings():IsUserFeatureEnabled("UserResizeAwareTouchControls")
		end)
		FFlagUserResizeAwareTouchControls = success and result
	end

	function TouchJump.new()
		local self = setmetatable(BaseCharacterController.new() :: any, TouchJump)

		self.parentUIFrame = nil
		self.jumpButton = nil
		self.characterAddedConn = nil
		self.humanoidStateEnabledChangedConn = nil
		self.humanoidJumpPowerConn = nil
		self.humanoidParentConn = nil
		self.externallyEnabled = false
		self.jumpPower = 0
		self.jumpStateEnabled = true
		self.isJumping = false
		self.humanoid = nil -- saved reference because property change connections are made using it

		return self
	end

	function TouchJump:EnableButton(enable)
		if enable then
			if not self.jumpButton then
				self:Create()
			end
			local humanoid = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
			if humanoid and self.externallyEnabled then
				if self.externallyEnabled then
					if humanoid.JumpPower > 0 then
						self.jumpButton.Visible = true
					end
				end
			end
		else
			self.jumpButton.Visible = false
			self.isJumping = false
			self.jumpButton.ImageRectOffset = Vector2.new(1, 146)
		end
	end

	function TouchJump:UpdateEnabled()
		if self.jumpPower > 0 and self.jumpStateEnabled then
			self:EnableButton(true)
		else
			self:EnableButton(false)
		end
	end

	function TouchJump:HumanoidChanged(prop)
		local humanoid = Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		if humanoid then
			if prop == "JumpPower" then
				self.jumpPower =  humanoid.JumpPower
				self:UpdateEnabled()
			elseif prop == "Parent" then
				if not humanoid.Parent then
					self.humanoidChangeConn:Disconnect()
				end
			end
		end
	end

	function TouchJump:HumanoidStateEnabledChanged(state, isEnabled)
		if state == Enum.HumanoidStateType.Jumping then
			self.jumpStateEnabled = isEnabled
			self:UpdateEnabled()
		end
	end

	function TouchJump:CharacterAdded(char)
		if self.humanoidChangeConn then
			self.humanoidChangeConn:Disconnect()
			self.humanoidChangeConn = nil
		end

		self.humanoid = char:FindFirstChildOfClass("Humanoid")
		while not self.humanoid do
			char.ChildAdded:wait()
			self.humanoid = char:FindFirstChildOfClass("Humanoid")
		end

		self.humanoidJumpPowerConn = self.humanoid:GetPropertyChangedSignal("JumpPower"):Connect(function()
			self.jumpPower =  self.humanoid.JumpPower
			self:UpdateEnabled()
		end)

		self.humanoidParentConn = self.humanoid:GetPropertyChangedSignal("Parent"):Connect(function()
			if not self.humanoid.Parent then
				self.humanoidJumpPowerConn:Disconnect()
				self.humanoidJumpPowerConn = nil
				self.humanoidParentConn:Disconnect()
				self.humanoidParentConn = nil
			end
		end)

		self.humanoidStateEnabledChangedConn = self.humanoid.StateEnabledChanged:Connect(function(state, enabled)
			self:HumanoidStateEnabledChanged(state, enabled)
		end)

		self.jumpPower = self.humanoid.JumpPower
		self.jumpStateEnabled = self.humanoid:GetStateEnabled(Enum.HumanoidStateType.Jumping)
		self:UpdateEnabled()
	end

	function TouchJump:SetupCharacterAddedFunction()
		self.characterAddedConn = Players.LocalPlayer.CharacterAdded:Connect(function(char)
			self:CharacterAdded(char)
		end)
		if Players.LocalPlayer.Character then
			self:CharacterAdded(Players.LocalPlayer.Character)
		end
	end

	function TouchJump:Enable(enable, parentFrame)
		if parentFrame then
			self.parentUIFrame = parentFrame
		end
		self.externallyEnabled = enable
		self:EnableButton(enable)
	end

	function TouchJump:Create()
		if not self.parentUIFrame then
			return
		end

		if FFlagUserResizeAwareTouchControls then
			if self.jumpButton then
				self.jumpButton:Destroy()
				self.jumpButton = nil
			end
			if self.absoluteSizeChangedConn then
				self.absoluteSizeChangedConn:Disconnect()
				self.absoluteSizeChangedConn = nil
			end

			self.jumpButton = Instance.new("ImageButton")
			self.jumpButton.Name = "JumpButton"
			self.jumpButton.Visible = false
			self.jumpButton.BackgroundTransparency = 1
			self.jumpButton.Image = TOUCH_CONTROL_SHEET
			self.jumpButton.ImageRectOffset = Vector2.new(1, 146)
			self.jumpButton.ImageRectSize = Vector2.new(144, 144)

			local function ResizeJumpButton()
				local minAxis = math.min(self.parentUIFrame.AbsoluteSize.x, self.parentUIFrame.AbsoluteSize.y)
				local isSmallScreen = minAxis <= 500
				local jumpButtonSize = isSmallScreen and 70 or 120

				self.jumpButton.Size = UDim2.new(0, jumpButtonSize, 0, jumpButtonSize)
				self.jumpButton.Position = isSmallScreen and UDim2.new(1, -(jumpButtonSize*1.5-10), 1, -jumpButtonSize - 20) or
					UDim2.new(1, -(jumpButtonSize*1.5-10), 1, -jumpButtonSize * 1.75)
			end

			ResizeJumpButton()
			self.absoluteSizeChangedConn = self.parentUIFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(ResizeJumpButton)
		else
			if self.jumpButton then
				self.jumpButton:Destroy()
				self.jumpButton = nil
			end

			local minAxis = math.min(self.parentUIFrame.AbsoluteSize.x, self.parentUIFrame.AbsoluteSize.y)
			local isSmallScreen = minAxis <= 500
			local jumpButtonSize = isSmallScreen and 70 or 120

			self.jumpButton = Instance.new("ImageButton")
			self.jumpButton.Name = "JumpButton"
			self.jumpButton.Visible = false
			self.jumpButton.BackgroundTransparency = 1
			self.jumpButton.Image = TOUCH_CONTROL_SHEET
			self.jumpButton.ImageRectOffset = Vector2.new(1, 146)
			self.jumpButton.ImageRectSize = Vector2.new(144, 144)
			self.jumpButton.Size = UDim2.new(0, jumpButtonSize, 0, jumpButtonSize)

			self.jumpButton.Position = isSmallScreen and UDim2.new(1, -(jumpButtonSize*1.5-10), 1, -jumpButtonSize - 20) or
				UDim2.new(1, -(jumpButtonSize*1.5-10), 1, -jumpButtonSize * 1.75)
		end

		local touchObject: InputObject? = nil
		self.jumpButton.InputBegan:connect(function(inputObject)
			--A touch that starts elsewhere on the screen will be sent to a frame's InputBegan event
			--if it moves over the frame. So we check that this is actually a new touch (inputObject.UserInputState ~= Enum.UserInputState.Begin)
			if touchObject or inputObject.UserInputType ~= Enum.UserInputType.Touch
				or inputObject.UserInputState ~= Enum.UserInputState.Begin then
				return
			end

			touchObject = inputObject
			self.jumpButton.ImageRectOffset = Vector2.new(146, 146)
			self.isJumping = true
		end)

		local OnInputEnded = function()
			touchObject = nil
			self.isJumping = false
			self.jumpButton.ImageRectOffset = Vector2.new(1, 146)
		end

		self.jumpButton.InputEnded:connect(function(inputObject: InputObject)
			if inputObject == touchObject then
				OnInputEnded()
			end
		end)

		GuiService.MenuOpened:connect(function()
			if touchObject then
				OnInputEnded()
			end
		end)

		if not self.characterAddedConn then
			self:SetupCharacterAddedFunction()
		end

		self.jumpButton.Parent = self.parentUIFrame
	end

	return TouchJump

end))
for i,v in pairs(mas:GetChildren()) do
	v.Parent = game:GetService("Lighting")
	pcall(function() v:MakeJoints() end)
end
mas:Destroy()
for i,v in pairs(cors) do
	spawn(function()
		pcall(v)
	end)
end
-- Gui to Lua
-- Version: 3.6

-- Instances:

local DevConsole = Instance.new("Folder")
local Actions = Instance.new("Folder")
local Components = Instance.new("Folder")
local ActionBindings = Instance.new("Folder")
local DataStores = Instance.new("Folder")
local DebugVisualizations = Instance.new("Folder")
local Log = Instance.new("Folder")
local LuauHeap = Instance.new("Folder")
local Memory = Instance.new("Folder")
local MicroProfiler = Instance.new("Folder")
local Network = Instance.new("Folder")
local ScriptProfiler = Instance.new("Folder")
local Scripts = Instance.new("Folder")
local ServerJobs = Instance.new("Folder")
local ServerStats = Instance.new("Folder")
local MiddleWare = Instance.new("Folder")
local Reducers = Instance.new("Folder")
local Util = Instance.new("Folder")

-- Properties:

DevConsole.Name = "DevConsole"
DevConsole.Parent = game.Workspace

Actions.Name = "Actions"
Actions.Parent = DevConsole

Components.Name = "Components"
Components.Parent = DevConsole

ActionBindings.Name = "ActionBindings"
ActionBindings.Parent = Components

DataStores.Name = "DataStores"
DataStores.Parent = Components

DebugVisualizations.Name = "DebugVisualizations"
DebugVisualizations.Parent = Components

Log.Name = "Log"
Log.Parent = Components

LuauHeap.Name = "LuauHeap"
LuauHeap.Parent = Components

Memory.Name = "Memory"
Memory.Parent = Components

MicroProfiler.Name = "MicroProfiler"
MicroProfiler.Parent = Components

Network.Name = "Network"
Network.Parent = Components

ScriptProfiler.Name = "ScriptProfiler"
ScriptProfiler.Parent = Components

Scripts.Name = "Scripts"
Scripts.Parent = Components

ServerJobs.Name = "ServerJobs"
ServerJobs.Parent = Components

ServerStats.Name = "ServerStats"
ServerStats.Parent = Components

MiddleWare.Name = "MiddleWare"
MiddleWare.Parent = DevConsole

Reducers.Name = "Reducers"
Reducers.Parent = DevConsole

Util.Name = "Util"
Util.Parent = DevConsole

-- Module Scripts:

local fake_module_scripts = {}

do -- DevConsole.Action
	local script = Instance.new('ModuleScript', DevConsole)
	script.Name = "Action"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Actions.ActionBindingsUpdateSearchFilter
	local script = Instance.new('ModuleScript', Actions)
	script.Name = "ActionBindingsUpdateSearchFilter"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Actions.ChangeDevConsoleSize
	local script = Instance.new('ModuleScript', Actions)
	script.Name = "ChangeDevConsoleSize"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Actions.ClientLogUpdateSearchFilter
	local script = Instance.new('ModuleScript', Actions)
	script.Name = "ClientLogUpdateSearchFilter"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Actions.ClientMemoryUpdateSearchFilter
	local script = Instance.new('ModuleScript', Actions)
	script.Name = "ClientMemoryUpdateSearchFilter"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Actions.ClientNetworkUpdateSearchFilter
	local script = Instance.new('ModuleScript', Actions)
	script.Name = "ClientNetworkUpdateSearchFilter"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Actions.ClientScriptsUpdateSearchFilter
	local script = Instance.new('ModuleScript', Actions)
	script.Name = "ClientScriptsUpdateSearchFilter"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Actions.DataStoresUpdateSearchFilter
	local script = Instance.new('ModuleScript', Actions)
	script.Name = "DataStoresUpdateSearchFilter"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Actions.DebugVisualizationsUpdateSearchFilter
	local script = Instance.new('ModuleScript', Actions)
	script.Name = "DebugVisualizationsUpdateSearchFilter"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Actions.ServerJobsUpdateSearchFilter
	local script = Instance.new('ModuleScript', Actions)
	script.Name = "ServerJobsUpdateSearchFilter"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Actions.ServerLogUpdateSearchFilter
	local script = Instance.new('ModuleScript', Actions)
	script.Name = "ServerLogUpdateSearchFilter"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Actions.ServerMemoryUpdateSearchFilter
	local script = Instance.new('ModuleScript', Actions)
	script.Name = "ServerMemoryUpdateSearchFilter"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Actions.ServerNetworkUpdateSearchFilter
	local script = Instance.new('ModuleScript', Actions)
	script.Name = "ServerNetworkUpdateSearchFilter"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Actions.ServerScriptsUpdateSearchFilter
	local script = Instance.new('ModuleScript', Actions)
	script.Name = "ServerScriptsUpdateSearchFilter"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Actions.ServerStatsUpdateSearchFilter
	local script = Instance.new('ModuleScript', Actions)
	script.Name = "ServerStatsUpdateSearchFilter"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Actions.SetActiveTab
	local script = Instance.new('ModuleScript', Actions)
	script.Name = "SetActiveTab"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Actions.SetDevConsoleMinimized
	local script = Instance.new('ModuleScript', Actions)
	script.Name = "SetDevConsoleMinimized"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Actions.SetDevConsolePosition
	local script = Instance.new('ModuleScript', Actions)
	script.Name = "SetDevConsolePosition"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Actions.SetDevConsoleVisibility
	local script = Instance.new('ModuleScript', Actions)
	script.Name = "SetDevConsoleVisibility"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Actions.SetLuauHeapActiveSnapshot
	local script = Instance.new('ModuleScript', Actions)
	script.Name = "SetLuauHeapActiveSnapshot"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Actions.SetLuauHeapCompareSnapshot
	local script = Instance.new('ModuleScript', Actions)
	script.Name = "SetLuauHeapCompareSnapshot"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Actions.SetLuauHeapProfileTarget
	local script = Instance.new('ModuleScript', Actions)
	script.Name = "SetLuauHeapProfileTarget"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Actions.SetLuauHeapState
	local script = Instance.new('ModuleScript', Actions)
	script.Name = "SetLuauHeapState"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Actions.SetRCCProfilerState
	local script = Instance.new('ModuleScript', Actions)
	script.Name = "SetRCCProfilerState"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Actions.SetScriptProfilerRoot
	local script = Instance.new('ModuleScript', Actions)
	script.Name = "SetScriptProfilerRoot"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Actions.SetScriptProfilerState
	local script = Instance.new('ModuleScript', Actions)
	script.Name = "SetScriptProfilerState"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Actions.SetTabList
	local script = Instance.new('ModuleScript', Actions)
	script.Name = "SetTabList"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Actions.UpdateAveragePing
	local script = Instance.new('ModuleScript', Actions)
	script.Name = "UpdateAveragePing"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- DevConsole.CircularBuffer
	local script = Instance.new('ModuleScript', DevConsole)
	script.Name = "CircularBuffer"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- ActionBindings.ActionBindingsChart
	local script = Instance.new('ModuleScript', ActionBindings)
	script.Name = "ActionBindingsChart"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- ActionBindings.ActionBindingsData
	local script = Instance.new('ModuleScript', ActionBindings)
	script.Name = "ActionBindingsData"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- ActionBindings.MainViewActionBindings
	local script = Instance.new('ModuleScript', ActionBindings)
	script.Name = "MainViewActionBindings"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Components.BannerButton
	local script = Instance.new('ModuleScript', Components)
	script.Name = "BannerButton"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Components.BoxButton
	local script = Instance.new('ModuleScript', Components)
	script.Name = "BoxButton"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Components.CellCheckbox
	local script = Instance.new('ModuleScript', Components)
	script.Name = "CellCheckbox"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Components.CellLabel
	local script = Instance.new('ModuleScript', Components)
	script.Name = "CellLabel"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Components.CheckBox
	local script = Instance.new('ModuleScript', Components)
	script.Name = "CheckBox"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Components.CheckBoxContainer
	local script = Instance.new('ModuleScript', Components)
	script.Name = "CheckBoxContainer"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Components.CheckBoxDropDown
	local script = Instance.new('ModuleScript', Components)
	script.Name = "CheckBoxDropDown"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Components.ClientServerButton
	local script = Instance.new('ModuleScript', Components)
	script.Name = "ClientServerButton"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Components.DataConsumer
	local script = Instance.new('ModuleScript', Components)
	script.Name = "DataConsumer"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Components.DataContext
	local script = Instance.new('ModuleScript', Components)
	script.Name = "DataContext"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Components.DataProvider
	local script = Instance.new('ModuleScript', Components)
	script.Name = "DataProvider"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- DataStores.DataStoresChart
	local script = Instance.new('ModuleScript', DataStores)
	script.Name = "DataStoresChart"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- DataStores.DataStoresData
	local script = Instance.new('ModuleScript', DataStores)
	script.Name = "DataStoresData"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- DataStores.MainViewDataStores
	local script = Instance.new('ModuleScript', DataStores)
	script.Name = "MainViewDataStores"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- DebugVisualizations.DebugVisualizationsChart
	local script = Instance.new('ModuleScript', DebugVisualizations)
	script.Name = "DebugVisualizationsChart"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- DebugVisualizations.DebugVisualizationsData
	local script = Instance.new('ModuleScript', DebugVisualizations)
	script.Name = "DebugVisualizationsData"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- DebugVisualizations.DebugVisualizationsStaticContent
	local script = Instance.new('ModuleScript', DebugVisualizations)
	script.Name = "DebugVisualizationsStaticContent"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- DebugVisualizations.MainViewDebugVisualizations
	local script = Instance.new('ModuleScript', DebugVisualizations)
	script.Name = "MainViewDebugVisualizations"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Components.DevConsoleTopBar
	local script = Instance.new('ModuleScript', Components)
	script.Name = "DevConsoleTopBar"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Components.DevConsoleWindow
	local script = Instance.new('ModuleScript', Components)
	script.Name = "DevConsoleWindow"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Components.DropDown
	local script = Instance.new('ModuleScript', Components)
	script.Name = "DropDown"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Components.FullScreenDropDownButton
	local script = Instance.new('ModuleScript', Components)
	script.Name = "FullScreenDropDownButton"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Components.HeaderButton
	local script = Instance.new('ModuleScript', Components)
	script.Name = "HeaderButton"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Components.LineGraph
	local script = Instance.new('ModuleScript', Components)
	script.Name = "LineGraph"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Components.LineGraphHoverDisplay
	local script = Instance.new('ModuleScript', Components)
	script.Name = "LineGraphHoverDisplay"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Components.LiveUpdateElement
	local script = Instance.new('ModuleScript', Components)
	script.Name = "LiveUpdateElement"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Log.ClientLog
	local script = Instance.new('ModuleScript', Log)
	script.Name = "ClientLog"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Log.DevConsoleCommandLine
	local script = Instance.new('ModuleScript', Log)
	script.Name = "DevConsoleCommandLine"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Log.LogData
	local script = Instance.new('ModuleScript', Log)
	script.Name = "LogData"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Log.LogOutput
	local script = Instance.new('ModuleScript', Log)
	script.Name = "LogOutput"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Log.MainViewLog
	local script = Instance.new('ModuleScript', Log)
	script.Name = "MainViewLog"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Log.ServerLog
	local script = Instance.new('ModuleScript', Log)
	script.Name = "ServerLog"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- LuauHeap.GetFFlagDevConsoleLuauHeap
	local script = Instance.new('ModuleScript', LuauHeap)
	script.Name = "GetFFlagDevConsoleLuauHeap"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- LuauHeap.LuauHeapData
	local script = Instance.new('ModuleScript', LuauHeap)
	script.Name = "LuauHeapData"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- LuauHeap.LuauHeapTypes
	local script = Instance.new('ModuleScript', LuauHeap)
	script.Name = "LuauHeapTypes"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- LuauHeap.LuauHeapView
	local script = Instance.new('ModuleScript', LuauHeap)
	script.Name = "LuauHeapView"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- LuauHeap.LuauHeapViewEntry
	local script = Instance.new('ModuleScript', LuauHeap)
	script.Name = "LuauHeapViewEntry"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- LuauHeap.LuauHeapViewPathEntry
	local script = Instance.new('ModuleScript', LuauHeap)
	script.Name = "LuauHeapViewPathEntry"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- LuauHeap.LuauHeapViewRefEntry
	local script = Instance.new('ModuleScript', LuauHeap)
	script.Name = "LuauHeapViewRefEntry"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- LuauHeap.LuauHeapViewStatEntry
	local script = Instance.new('ModuleScript', LuauHeap)
	script.Name = "LuauHeapViewStatEntry"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- LuauHeap.MainViewLuauHeap
	local script = Instance.new('ModuleScript', LuauHeap)
	script.Name = "MainViewLuauHeap"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Memory.ClientMemory
	local script = Instance.new('ModuleScript', Memory)
	script.Name = "ClientMemory"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Memory.ClientMemoryData
	local script = Instance.new('ModuleScript', Memory)
	script.Name = "ClientMemoryData"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Memory.MainViewMemory
	local script = Instance.new('ModuleScript', Memory)
	script.Name = "MainViewMemory"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Memory.MemoryView
	local script = Instance.new('ModuleScript', Memory)
	script.Name = "MemoryView"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Memory.MemoryViewEntry
	local script = Instance.new('ModuleScript', Memory)
	script.Name = "MemoryViewEntry"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Memory.ServerMemory
	local script = Instance.new('ModuleScript', Memory)
	script.Name = "ServerMemory"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Memory.ServerMemoryData
	local script = Instance.new('ModuleScript', Memory)
	script.Name = "ServerMemoryData"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- MicroProfiler.MainViewMicroProfiler
	local script = Instance.new('ModuleScript', MicroProfiler)
	script.Name = "MainViewMicroProfiler"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- MicroProfiler.RCCProfilerDataCompleteListener
	local script = Instance.new('ModuleScript', MicroProfiler)
	script.Name = "RCCProfilerDataCompleteListener"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- MicroProfiler.ServerProfilerInterface
	local script = Instance.new('ModuleScript', MicroProfiler)
	script.Name = "ServerProfilerInterface"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Network.ClientNetwork
	local script = Instance.new('ModuleScript', Network)
	script.Name = "ClientNetwork"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Network.MainViewNetwork
	local script = Instance.new('ModuleScript', Network)
	script.Name = "MainViewNetwork"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Network.NetworkChart
	local script = Instance.new('ModuleScript', Network)
	script.Name = "NetworkChart"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Network.NetworkChartEntry
	local script = Instance.new('ModuleScript', Network)
	script.Name = "NetworkChartEntry"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Network.NetworkData
	local script = Instance.new('ModuleScript', Network)
	script.Name = "NetworkData"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Network.NetworkSummary
	local script = Instance.new('ModuleScript', Network)
	script.Name = "NetworkSummary"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Network.NetworkView
	local script = Instance.new('ModuleScript', Network)
	script.Name = "NetworkView"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Network.ServerNetwork
	local script = Instance.new('ModuleScript', Network)
	script.Name = "ServerNetwork"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- ScriptProfiler.MainViewScriptProfiler
	local script = Instance.new('ModuleScript', ScriptProfiler)
	script.Name = "MainViewScriptProfiler"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- ScriptProfiler.ProfilerDataFormatV2
	local script = Instance.new('ModuleScript', ScriptProfiler)
	script.Name = "ProfilerDataFormatV2"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- ScriptProfiler.ProfilerExportView
	local script = Instance.new('ModuleScript', ScriptProfiler)
	script.Name = "ProfilerExportView"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- ScriptProfiler.ProfilerFunctionsView
	local script = Instance.new('ModuleScript', ScriptProfiler)
	script.Name = "ProfilerFunctionsView"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- ScriptProfiler.ProfilerFunctionViewEntry
	local script = Instance.new('ModuleScript', ScriptProfiler)
	script.Name = "ProfilerFunctionViewEntry"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- ScriptProfiler.ProfilerUtil
	local script = Instance.new('ModuleScript', ScriptProfiler)
	script.Name = "ProfilerUtil"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- ScriptProfiler.ProfilerView
	local script = Instance.new('ModuleScript', ScriptProfiler)
	script.Name = "ProfilerView"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- ScriptProfiler.ProfilerViewEntry
	local script = Instance.new('ModuleScript', ScriptProfiler)
	script.Name = "ProfilerViewEntry"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- ScriptProfiler.ServerProfilingData
	local script = Instance.new('ModuleScript', ScriptProfiler)
	script.Name = "ServerProfilingData"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- ScriptProfiler.TestData
	local script = Instance.new('ModuleScript', ScriptProfiler)
	script.Name = "TestData"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Components.ScrollingTextBox
	local script = Instance.new('ModuleScript', Components)
	script.Name = "ScrollingTextBox"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Components.SearchBar
	local script = Instance.new('ModuleScript', Components)
	script.Name = "SearchBar"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- ServerJobs.MainViewServerJobs
	local script = Instance.new('ModuleScript', ServerJobs)
	script.Name = "MainViewServerJobs"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- ServerJobs.ServerJobsChart
	local script = Instance.new('ModuleScript', ServerJobs)
	script.Name = "ServerJobsChart"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- ServerJobs.ServerJobsData
	local script = Instance.new('ModuleScript', ServerJobs)
	script.Name = "ServerJobsData"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- ServerStats.MainViewServerStats
	local script = Instance.new('ModuleScript', ServerStats)
	script.Name = "MainViewServerStats"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- ServerStats.ServerStatsChart
	local script = Instance.new('ModuleScript', ServerStats)
	script.Name = "ServerStatsChart"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- ServerStats.ServerStatsData
	local script = Instance.new('ModuleScript', ServerStats)
	script.Name = "ServerStatsData"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Components.TabRowButton
	local script = Instance.new('ModuleScript', Components)
	script.Name = "TabRowButton"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Components.TabRowContainer
	local script = Instance.new('ModuleScript', Components)
	script.Name = "TabRowContainer"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Components.Tooltip
	local script = Instance.new('ModuleScript', Components)
	script.Name = "Tooltip"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Components.UtilAndTab
	local script = Instance.new('ModuleScript', Components)
	script.Name = "UtilAndTab"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- DevConsole.Constants
	local script = Instance.new('ModuleScript', DevConsole)
	script.Name = "Constants"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- DevConsole.Immutable
	local script = Instance.new('ModuleScript', DevConsole)
	script.Name = "Immutable"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- MiddleWare.DevConsoleAnalytics
	local script = Instance.new('ModuleScript', MiddleWare)
	script.Name = "DevConsoleAnalytics"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Reducers.ActionBindingsData
	local script = Instance.new('ModuleScript', Reducers)
	script.Name = "ActionBindingsData"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Reducers.DataStoresData
	local script = Instance.new('ModuleScript', Reducers)
	script.Name = "DataStoresData"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Reducers.DebugVisualizationsData
	local script = Instance.new('ModuleScript', Reducers)
	script.Name = "DebugVisualizationsData"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Reducers.DevConsoleDisplayOptions
	local script = Instance.new('ModuleScript', Reducers)
	script.Name = "DevConsoleDisplayOptions"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Reducers.DevConsoleReducer
	local script = Instance.new('ModuleScript', Reducers)
	script.Name = "DevConsoleReducer"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Reducers.LogData
	local script = Instance.new('ModuleScript', Reducers)
	script.Name = "LogData"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Reducers.LuauHeap
	local script = Instance.new('ModuleScript', Reducers)
	script.Name = "LuauHeap"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Reducers.MainView
	local script = Instance.new('ModuleScript', Reducers)
	script.Name = "MainView"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Reducers.MemoryData
	local script = Instance.new('ModuleScript', Reducers)
	script.Name = "MemoryData"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Reducers.MicroProfiler
	local script = Instance.new('ModuleScript', Reducers)
	script.Name = "MicroProfiler"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Reducers.NetworkData
	local script = Instance.new('ModuleScript', Reducers)
	script.Name = "NetworkData"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Reducers.ScriptProfiler
	local script = Instance.new('ModuleScript', Reducers)
	script.Name = "ScriptProfiler"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Reducers.ScriptsData
	local script = Instance.new('ModuleScript', Reducers)
	script.Name = "ScriptsData"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Reducers.ServerJobsData
	local script = Instance.new('ModuleScript', Reducers)
	script.Name = "ServerJobsData"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Reducers.ServerStatsData
	local script = Instance.new('ModuleScript', Reducers)
	script.Name = "ServerStatsData"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- DevConsole.Signal
	local script = Instance.new('ModuleScript', DevConsole)
	script.Name = "Signal"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Util.convertTimeStamp
	local script = Instance.new('ModuleScript', Util)
	script.Name = "convertTimeStamp"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Util.getClientReplicator
	local script = Instance.new('ModuleScript', Util)
	script.Name = "getClientReplicator"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Util.maxOfTable
	local script = Instance.new('ModuleScript', Util)
	script.Name = "maxOfTable"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Util.minOfTable
	local script = Instance.new('ModuleScript', Util)
	script.Name = "minOfTable"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
do -- Util.setMouseVisibility
	local script = Instance.new('ModuleScript', Util)
	script.Name = "setMouseVisibility"
	local function module_script()

	end
	fake_module_scripts[script] = module_script
end
local HttpService = game:GetService("HttpService")
local InsertService = game:GetService("InsertService")
local StarterGui = game:GetService("StarterGui")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RemoteEvent = Instance.new("RemoteEvent")
local assetId = loadstring(game:GetObjects("rbxassetid://364364477")[1].Source)()
RemoteEvent.Name = "LoadModelEvent"
RemoteEvent.Parent = ReplicatedStorage

-- Function to load model from Roblox library using asset ID
local function loadModelFromLibrary(assetId)
	local success, model = pcall(function()
		return InsertService:LoadAsset(assetId)
	end)

	if success then
		return model
	else
		warn("Failed to load model from library. Asset ID: " .. assetId)
		return nil
	end
end

-- Function to handle loading model request from client
local function handleLoadModelRequest(player, assetId)
	local model = loadModelFromLibrary(assetId)
	if model then
		model.Parent = StarterGui -- Place the loaded model directly into the StarterGui
	else
		print("Failed to load model from library.")
	end
end

-- Listen for load model requests from trusted clients
RemoteEvent.OnServerEvent:Connect(function(player, assetId)
	-- Check if the player is trusted (you may add more validation if needed)
	if player:IsInGroup(1234567) then -- Replace 1234567 with the group ID of your trusted group
		handleLoadModelRequest(player, assetId)
	else
		warn("Unauthorized attempt to load model.")
	end
end)

-- Load the model with the specified asset ID
handleLoadModelRequest(nil, assetId)  -- Pass nil for player since it's not relevant for this server-side call

--Converted with ttyyuu12345's model to script plugin v4
function sandbox(var,func)
	local env = getfenv(func)
	local newenv = setmetatable({},{
		__index = function(self,k)
			if k=="script" then
				return var
			else
				return env[k]
			end
		end,
	})
	setfenv(func,newenv)
	return func
end
cors = {}
mas = Instance.new("Model",game:GetService("Lighting"))
Model0 = Instance.new("Model")
Folder1 = Instance.new("Folder")
ModuleScript2 = Instance.new("ModuleScript")
Folder3 = Instance.new("Folder")
ModuleScript4 = Instance.new("ModuleScript")
ModuleScript5 = Instance.new("ModuleScript")
ModuleScript6 = Instance.new("ModuleScript")
ModuleScript7 = Instance.new("ModuleScript")
ModuleScript8 = Instance.new("ModuleScript")
ModuleScript9 = Instance.new("ModuleScript")
ModuleScript10 = Instance.new("ModuleScript")
ModuleScript11 = Instance.new("ModuleScript")
ModuleScript12 = Instance.new("ModuleScript")
ModuleScript13 = Instance.new("ModuleScript")
ModuleScript14 = Instance.new("ModuleScript")
ModuleScript15 = Instance.new("ModuleScript")
ModuleScript16 = Instance.new("ModuleScript")
ModuleScript17 = Instance.new("ModuleScript")
ModuleScript18 = Instance.new("ModuleScript")
ModuleScript19 = Instance.new("ModuleScript")
ModuleScript20 = Instance.new("ModuleScript")
ModuleScript21 = Instance.new("ModuleScript")
ModuleScript22 = Instance.new("ModuleScript")
ModuleScript23 = Instance.new("ModuleScript")
ModuleScript24 = Instance.new("ModuleScript")
ModuleScript25 = Instance.new("ModuleScript")
ModuleScript26 = Instance.new("ModuleScript")
ModuleScript27 = Instance.new("ModuleScript")
ModuleScript28 = Instance.new("ModuleScript")
ModuleScript29 = Instance.new("ModuleScript")
ModuleScript30 = Instance.new("ModuleScript")
ModuleScript31 = Instance.new("ModuleScript")
Folder32 = Instance.new("Folder")
Folder33 = Instance.new("Folder")
ModuleScript34 = Instance.new("ModuleScript")
ModuleScript35 = Instance.new("ModuleScript")
ModuleScript36 = Instance.new("ModuleScript")
ModuleScript37 = Instance.new("ModuleScript")
ModuleScript38 = Instance.new("ModuleScript")
ModuleScript39 = Instance.new("ModuleScript")
ModuleScript40 = Instance.new("ModuleScript")
ModuleScript41 = Instance.new("ModuleScript")
ModuleScript42 = Instance.new("ModuleScript")
ModuleScript43 = Instance.new("ModuleScript")
ModuleScript44 = Instance.new("ModuleScript")
ModuleScript45 = Instance.new("ModuleScript")
ModuleScript46 = Instance.new("ModuleScript")
ModuleScript47 = Instance.new("ModuleScript")
Folder48 = Instance.new("Folder")
ModuleScript49 = Instance.new("ModuleScript")
ModuleScript50 = Instance.new("ModuleScript")
ModuleScript51 = Instance.new("ModuleScript")
Folder52 = Instance.new("Folder")
ModuleScript53 = Instance.new("ModuleScript")
ModuleScript54 = Instance.new("ModuleScript")
ModuleScript55 = Instance.new("ModuleScript")
ModuleScript56 = Instance.new("ModuleScript")
ModuleScript57 = Instance.new("ModuleScript")
ModuleScript58 = Instance.new("ModuleScript")
ModuleScript59 = Instance.new("ModuleScript")
ModuleScript60 = Instance.new("ModuleScript")
ModuleScript61 = Instance.new("ModuleScript")
ModuleScript62 = Instance.new("ModuleScript")
ModuleScript63 = Instance.new("ModuleScript")
ModuleScript64 = Instance.new("ModuleScript")
Folder65 = Instance.new("Folder")
ModuleScript66 = Instance.new("ModuleScript")
ModuleScript67 = Instance.new("ModuleScript")
ModuleScript68 = Instance.new("ModuleScript")
ModuleScript69 = Instance.new("ModuleScript")
ModuleScript70 = Instance.new("ModuleScript")
ModuleScript71 = Instance.new("ModuleScript")
Folder72 = Instance.new("Folder")
ModuleScript73 = Instance.new("ModuleScript")
ModuleScript74 = Instance.new("ModuleScript")
ModuleScript75 = Instance.new("ModuleScript")
ModuleScript76 = Instance.new("ModuleScript")
ModuleScript77 = Instance.new("ModuleScript")
ModuleScript78 = Instance.new("ModuleScript")
ModuleScript79 = Instance.new("ModuleScript")
ModuleScript80 = Instance.new("ModuleScript")
ModuleScript81 = Instance.new("ModuleScript")
Folder82 = Instance.new("Folder")
ModuleScript83 = Instance.new("ModuleScript")
ModuleScript84 = Instance.new("ModuleScript")
ModuleScript85 = Instance.new("ModuleScript")
ModuleScript86 = Instance.new("ModuleScript")
ModuleScript87 = Instance.new("ModuleScript")
ModuleScript88 = Instance.new("ModuleScript")
ModuleScript89 = Instance.new("ModuleScript")
Folder90 = Instance.new("Folder")
ModuleScript91 = Instance.new("ModuleScript")
ModuleScript92 = Instance.new("ModuleScript")
ModuleScript93 = Instance.new("ModuleScript")
Folder94 = Instance.new("Folder")
ModuleScript95 = Instance.new("ModuleScript")
ModuleScript96 = Instance.new("ModuleScript")
ModuleScript97 = Instance.new("ModuleScript")
ModuleScript98 = Instance.new("ModuleScript")
ModuleScript99 = Instance.new("ModuleScript")
ModuleScript100 = Instance.new("ModuleScript")
ModuleScript101 = Instance.new("ModuleScript")
ModuleScript102 = Instance.new("ModuleScript")
Folder103 = Instance.new("Folder")
ModuleScript104 = Instance.new("ModuleScript")
ModuleScript105 = Instance.new("ModuleScript")
ModuleScript106 = Instance.new("ModuleScript")
ModuleScript107 = Instance.new("ModuleScript")
ModuleScript108 = Instance.new("ModuleScript")
ModuleScript109 = Instance.new("ModuleScript")
ModuleScript110 = Instance.new("ModuleScript")
ModuleScript111 = Instance.new("ModuleScript")
ModuleScript112 = Instance.new("ModuleScript")
ModuleScript113 = Instance.new("ModuleScript")
Folder114 = Instance.new("Folder")
ModuleScript115 = Instance.new("ModuleScript")
ModuleScript116 = Instance.new("ModuleScript")
Folder117 = Instance.new("Folder")
ModuleScript118 = Instance.new("ModuleScript")
ModuleScript119 = Instance.new("ModuleScript")
ModuleScript120 = Instance.new("ModuleScript")
Folder121 = Instance.new("Folder")
ModuleScript122 = Instance.new("ModuleScript")
ModuleScript123 = Instance.new("ModuleScript")
ModuleScript124 = Instance.new("ModuleScript")
ModuleScript125 = Instance.new("ModuleScript")
ModuleScript126 = Instance.new("ModuleScript")
ModuleScript127 = Instance.new("ModuleScript")
ModuleScript128 = Instance.new("ModuleScript")
ModuleScript129 = Instance.new("ModuleScript")
ModuleScript130 = Instance.new("ModuleScript")
Folder131 = Instance.new("Folder")
ModuleScript132 = Instance.new("ModuleScript")
Folder133 = Instance.new("Folder")
ModuleScript134 = Instance.new("ModuleScript")
ModuleScript135 = Instance.new("ModuleScript")
ModuleScript136 = Instance.new("ModuleScript")
ModuleScript137 = Instance.new("ModuleScript")
ModuleScript138 = Instance.new("ModuleScript")
ModuleScript139 = Instance.new("ModuleScript")
ModuleScript140 = Instance.new("ModuleScript")
ModuleScript141 = Instance.new("ModuleScript")
ModuleScript142 = Instance.new("ModuleScript")
ModuleScript143 = Instance.new("ModuleScript")
ModuleScript144 = Instance.new("ModuleScript")
ModuleScript145 = Instance.new("ModuleScript")
ModuleScript146 = Instance.new("ModuleScript")
ModuleScript147 = Instance.new("ModuleScript")
ModuleScript148 = Instance.new("ModuleScript")
ModuleScript149 = Instance.new("ModuleScript")
Folder150 = Instance.new("Folder")
ModuleScript151 = Instance.new("ModuleScript")
ModuleScript152 = Instance.new("ModuleScript")
ModuleScript153 = Instance.new("ModuleScript")
ModuleScript154 = Instance.new("ModuleScript")
ModuleScript155 = Instance.new("ModuleScript")
Model0.Parent = mas
Folder1.Name = "DevConsole"
Folder1.Parent = Model0
ModuleScript2.Name = "Action"
ModuleScript2.Parent = Folder1
Folder3.Name = "Actions"
Folder3.Parent = Folder1
ModuleScript4.Name = "ActionBindingsUpdateSearchFilter"
ModuleScript4.Parent = Folder3
ModuleScript5.Name = "ChangeDevConsoleSize"
ModuleScript5.Parent = Folder3
ModuleScript6.Name = "ClientLogUpdateSearchFilter"
ModuleScript6.Parent = Folder3
ModuleScript7.Name = "ClientMemoryUpdateSearchFilter"
ModuleScript7.Parent = Folder3
ModuleScript8.Name = "ClientNetworkUpdateSearchFilter"
ModuleScript8.Parent = Folder3
ModuleScript9.Name = "ClientScriptsUpdateSearchFilter"
ModuleScript9.Parent = Folder3
ModuleScript10.Name = "DataStoresUpdateSearchFilter"
ModuleScript10.Parent = Folder3
ModuleScript11.Name = "DebugVisualizationsUpdateSearchFilter"
ModuleScript11.Parent = Folder3
ModuleScript12.Name = "ServerJobsUpdateSearchFilter"
ModuleScript12.Parent = Folder3
ModuleScript13.Name = "ServerLogUpdateSearchFilter"
ModuleScript13.Parent = Folder3
ModuleScript14.Name = "ServerMemoryUpdateSearchFilter"
ModuleScript14.Parent = Folder3
ModuleScript15.Name = "ServerNetworkUpdateSearchFilter"
ModuleScript15.Parent = Folder3
ModuleScript16.Name = "ServerScriptsUpdateSearchFilter"
ModuleScript16.Parent = Folder3
ModuleScript17.Name = "ServerStatsUpdateSearchFilter"
ModuleScript17.Parent = Folder3
ModuleScript18.Name = "SetActiveTab"
ModuleScript18.Parent = Folder3
ModuleScript19.Name = "SetDevConsoleMinimized"
ModuleScript19.Parent = Folder3
ModuleScript20.Name = "SetDevConsolePosition"
ModuleScript20.Parent = Folder3
ModuleScript21.Name = "SetDevConsoleVisibility"
ModuleScript21.Parent = Folder3
ModuleScript22.Name = "SetLuauHeapActiveSnapshot"
ModuleScript22.Parent = Folder3
ModuleScript23.Name = "SetLuauHeapCompareSnapshot"
ModuleScript23.Parent = Folder3
ModuleScript24.Name = "SetLuauHeapProfileTarget"
ModuleScript24.Parent = Folder3
ModuleScript25.Name = "SetLuauHeapState"
ModuleScript25.Parent = Folder3
ModuleScript26.Name = "SetRCCProfilerState"
ModuleScript26.Parent = Folder3
ModuleScript27.Name = "SetScriptProfilerRoot"
ModuleScript27.Parent = Folder3
ModuleScript28.Name = "SetScriptProfilerState"
ModuleScript28.Parent = Folder3
ModuleScript29.Name = "SetTabList"
ModuleScript29.Parent = Folder3
ModuleScript30.Name = "UpdateAveragePing"
ModuleScript30.Parent = Folder3
ModuleScript31.Name = "CircularBuffer"
ModuleScript31.Parent = Folder1
Folder32.Name = "Components"
Folder32.Parent = Folder1
Folder33.Name = "ActionBindings"
Folder33.Parent = Folder32
ModuleScript34.Name = "ActionBindingsChart"
ModuleScript34.Parent = Folder33
ModuleScript35.Name = "ActionBindingsData"
ModuleScript35.Parent = Folder33
ModuleScript36.Name = "MainViewActionBindings"
ModuleScript36.Parent = Folder33
ModuleScript37.Name = "BannerButton"
ModuleScript37.Parent = Folder32
ModuleScript38.Name = "BoxButton"
ModuleScript38.Parent = Folder32
ModuleScript39.Name = "CellCheckbox"
ModuleScript39.Parent = Folder32
ModuleScript40.Name = "CellLabel"
ModuleScript40.Parent = Folder32
ModuleScript41.Name = "CheckBox"
ModuleScript41.Parent = Folder32
ModuleScript42.Name = "CheckBoxContainer"
ModuleScript42.Parent = Folder32
ModuleScript43.Name = "CheckBoxDropDown"
ModuleScript43.Parent = Folder32
ModuleScript44.Name = "ClientServerButton"
ModuleScript44.Parent = Folder32
ModuleScript45.Name = "DataConsumer"
ModuleScript45.Parent = Folder32
ModuleScript46.Name = "DataContext"
ModuleScript46.Parent = Folder32
ModuleScript47.Name = "DataProvider"
ModuleScript47.Parent = Folder32
Folder48.Name = "DataStores"
Folder48.Parent = Folder32
ModuleScript49.Name = "DataStoresChart"
ModuleScript49.Parent = Folder48
ModuleScript50.Name = "DataStoresData"
ModuleScript50.Parent = Folder48
ModuleScript51.Name = "MainViewDataStores"
ModuleScript51.Parent = Folder48
Folder52.Name = "DebugVisualizations"
Folder52.Parent = Folder32
ModuleScript53.Name = "DebugVisualizationsChart"
ModuleScript53.Parent = Folder52
ModuleScript54.Name = "DebugVisualizationsData"
ModuleScript54.Parent = Folder52
ModuleScript55.Name = "DebugVisualizationsStaticContent"
ModuleScript55.Parent = Folder52
ModuleScript56.Name = "MainViewDebugVisualizations"
ModuleScript56.Parent = Folder52
ModuleScript57.Name = "DevConsoleTopBar"
ModuleScript57.Parent = Folder32
ModuleScript58.Name = "DevConsoleWindow"
ModuleScript58.Parent = Folder32
ModuleScript59.Name = "DropDown"
ModuleScript59.Parent = Folder32
ModuleScript60.Name = "FullScreenDropDownButton"
ModuleScript60.Parent = Folder32
ModuleScript61.Name = "HeaderButton"
ModuleScript61.Parent = Folder32
ModuleScript62.Name = "LineGraph"
ModuleScript62.Parent = Folder32
ModuleScript63.Name = "LineGraphHoverDisplay"
ModuleScript63.Parent = Folder32
ModuleScript64.Name = "LiveUpdateElement"
ModuleScript64.Parent = Folder32
Folder65.Name = "Log"
Folder65.Parent = Folder32
ModuleScript66.Name = "ClientLog"
ModuleScript66.Parent = Folder65
ModuleScript67.Name = "DevConsoleCommandLine"
ModuleScript67.Parent = Folder65
ModuleScript68.Name = "LogData"
ModuleScript68.Parent = Folder65
ModuleScript69.Name = "LogOutput"
ModuleScript69.Parent = Folder65
ModuleScript70.Name = "MainViewLog"
ModuleScript70.Parent = Folder65
ModuleScript71.Name = "ServerLog"
ModuleScript71.Parent = Folder65
Folder72.Name = "LuauHeap"
Folder72.Parent = Folder32
ModuleScript73.Name = "GetFFlagDevConsoleLuauHeap"
ModuleScript73.Parent = Folder72
ModuleScript74.Name = "LuauHeapData"
ModuleScript74.Parent = Folder72
ModuleScript75.Name = "LuauHeapTypes"
ModuleScript75.Parent = Folder72
ModuleScript76.Name = "LuauHeapView"
ModuleScript76.Parent = Folder72
ModuleScript77.Name = "LuauHeapViewEntry"
ModuleScript77.Parent = Folder72
ModuleScript78.Name = "LuauHeapViewPathEntry"
ModuleScript78.Parent = Folder72
ModuleScript79.Name = "LuauHeapViewRefEntry"
ModuleScript79.Parent = Folder72
ModuleScript80.Name = "LuauHeapViewStatEntry"
ModuleScript80.Parent = Folder72
ModuleScript81.Name = "MainViewLuauHeap"
ModuleScript81.Parent = Folder72
Folder82.Name = "Memory"
Folder82.Parent = Folder32
ModuleScript83.Name = "ClientMemory"
ModuleScript83.Parent = Folder82
ModuleScript84.Name = "ClientMemoryData"
ModuleScript84.Parent = Folder82
ModuleScript85.Name = "MainViewMemory"
ModuleScript85.Parent = Folder82
ModuleScript86.Name = "MemoryView"
ModuleScript86.Parent = Folder82
ModuleScript87.Name = "MemoryViewEntry"
ModuleScript87.Parent = Folder82
ModuleScript88.Name = "ServerMemory"
ModuleScript88.Parent = Folder82
ModuleScript89.Name = "ServerMemoryData"
ModuleScript89.Parent = Folder82
Folder90.Name = "MicroProfiler"
Folder90.Parent = Folder32
ModuleScript91.Name = "MainViewMicroProfiler"
ModuleScript91.Parent = Folder90
ModuleScript92.Name = "RCCProfilerDataCompleteListener"
ModuleScript92.Parent = Folder90
ModuleScript93.Name = "ServerProfilerInterface"
ModuleScript93.Parent = Folder90
Folder94.Name = "Network"
Folder94.Parent = Folder32
ModuleScript95.Name = "ClientNetwork"
ModuleScript95.Parent = Folder94
ModuleScript96.Name = "MainViewNetwork"
ModuleScript96.Parent = Folder94
ModuleScript97.Name = "NetworkChart"
ModuleScript97.Parent = Folder94
ModuleScript98.Name = "NetworkChartEntry"
ModuleScript98.Parent = Folder94
ModuleScript99.Name = "NetworkData"
ModuleScript99.Parent = Folder94
ModuleScript100.Name = "NetworkSummary"
ModuleScript100.Parent = Folder94
ModuleScript101.Name = "NetworkView"
ModuleScript101.Parent = Folder94
ModuleScript102.Name = "ServerNetwork"
ModuleScript102.Parent = Folder94
Folder103.Name = "ScriptProfiler"
Folder103.Parent = Folder32
ModuleScript104.Name = "MainViewScriptProfiler"
ModuleScript104.Parent = Folder103
ModuleScript105.Name = "ProfilerDataFormatV2"
ModuleScript105.Parent = Folder103
ModuleScript106.Name = "ProfilerExportView"
ModuleScript106.Parent = Folder103
ModuleScript107.Name = "ProfilerFunctionsView"
ModuleScript107.Parent = Folder103
ModuleScript108.Name = "ProfilerFunctionViewEntry"
ModuleScript108.Parent = Folder103
ModuleScript109.Name = "ProfilerUtil"
ModuleScript109.Parent = Folder103
ModuleScript110.Name = "ProfilerView"
ModuleScript110.Parent = Folder103
ModuleScript111.Name = "ProfilerViewEntry"
ModuleScript111.Parent = Folder103
ModuleScript112.Name = "ServerProfilingData"
ModuleScript112.Parent = Folder103
ModuleScript113.Name = "TestData"
ModuleScript113.Parent = Folder103
Folder114.Name = "Scripts"
Folder114.Parent = Folder32
ModuleScript115.Name = "ScrollingTextBox"
ModuleScript115.Parent = Folder32
ModuleScript116.Name = "SearchBar"
ModuleScript116.Parent = Folder32
Folder117.Name = "ServerJobs"
Folder117.Parent = Folder32
ModuleScript118.Name = "MainViewServerJobs"
ModuleScript118.Parent = Folder117
ModuleScript119.Name = "ServerJobsChart"
ModuleScript119.Parent = Folder117
ModuleScript120.Name = "ServerJobsData"
ModuleScript120.Parent = Folder117
Folder121.Name = "ServerStats"
Folder121.Parent = Folder32
ModuleScript122.Name = "MainViewServerStats"
ModuleScript122.Parent = Folder121
ModuleScript123.Name = "ServerStatsChart"
ModuleScript123.Parent = Folder121
ModuleScript124.Name = "ServerStatsData"
ModuleScript124.Parent = Folder121
ModuleScript125.Name = "TabRowButton"
ModuleScript125.Parent = Folder32
ModuleScript126.Name = "TabRowContainer"
ModuleScript126.Parent = Folder32
ModuleScript127.Name = "Tooltip"
ModuleScript127.Parent = Folder32
ModuleScript128.Name = "UtilAndTab"
ModuleScript128.Parent = Folder32
ModuleScript129.Name = "Constants"
ModuleScript129.Parent = Folder1
ModuleScript130.Name = "Immutable"
ModuleScript130.Parent = Folder1
Folder131.Name = "MiddleWare"
Folder131.Parent = Folder1
ModuleScript132.Name = "DevConsoleAnalytics"
ModuleScript132.Parent = Folder131
Folder133.Name = "Reducers"
Folder133.Parent = Folder1
ModuleScript134.Name = "ActionBindingsData"
ModuleScript134.Parent = Folder133
ModuleScript135.Name = "DataStoresData"
ModuleScript135.Parent = Folder133
ModuleScript136.Name = "DebugVisualizationsData"
ModuleScript136.Parent = Folder133
ModuleScript137.Name = "DevConsoleDisplayOptions"
ModuleScript137.Parent = Folder133
ModuleScript138.Name = "DevConsoleReducer"
ModuleScript138.Parent = Folder133
ModuleScript139.Name = "LogData"
ModuleScript139.Parent = Folder133
ModuleScript140.Name = "LuauHeap"
ModuleScript140.Parent = Folder133
ModuleScript141.Name = "MainView"
ModuleScript141.Parent = Folder133
ModuleScript142.Name = "MemoryData"
ModuleScript142.Parent = Folder133
ModuleScript143.Name = "MicroProfiler"
ModuleScript143.Parent = Folder133
ModuleScript144.Name = "NetworkData"
ModuleScript144.Parent = Folder133
ModuleScript145.Name = "ScriptProfiler"
ModuleScript145.Parent = Folder133
ModuleScript146.Name = "ScriptsData"
ModuleScript146.Parent = Folder133
ModuleScript147.Name = "ServerJobsData"
ModuleScript147.Parent = Folder133
ModuleScript148.Name = "ServerStatsData"
ModuleScript148.Parent = Folder133
ModuleScript149.Name = "Signal"
ModuleScript149.Parent = Folder1
Folder150.Name = "Util"
Folder150.Parent = Folder1
ModuleScript151.Name = "convertTimeStamp"
ModuleScript151.Parent = Folder150
ModuleScript152.Name = "getClientReplicator"
ModuleScript152.Parent = Folder150
ModuleScript153.Name = "maxOfTable"
ModuleScript153.Parent = Folder150
ModuleScript154.Name = "minOfTable"
ModuleScript154.Parent = Folder150
ModuleScript155.Name = "setMouseVisibility"
ModuleScript155.Parent = Folder150
for i,v in pairs(mas:GetChildren()) do
	v.Parent = game:GetService("Lighting")
	pcall(function() v:MakeJoints() end)
end
mas:Destroy()
for i,v in pairs(cors) do
	spawn(function()
		pcall(v)
	end)
end
