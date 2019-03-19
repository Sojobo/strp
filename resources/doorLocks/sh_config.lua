DoorConfig = {}
DoorConfig = setmetatable(DoorConfig, {})

DoorConfig.doors = {
  {model = "v_ilev_arm_secdoor", x = 453.13, y = -982.51, z = 30.68, isLocked = true, jobRestriction = "police"}, -- ARMORY DOOR
  {model = "v_ilev_ph_gendoor004", x = 450.16, y = -986.33, z = 30.68, isLocked = false, jobRestriction = "police"}, -- LOCKER ROOM HALLWAY
  {model = "v_ilev_ph_gendoor002", x = 447.12, y = -979.93, z = 30.68, isLocked = true, jobRestriction = "police", gradeRestriction = 6}, -- CAPTAIN ROOM - RESTRICTION LT+
  {model = "v_ilev_ph_gendoor005", x = 445.40, y = -989.47, z = 30.68, isLocked = true, jobRestriction = "police"}, -- DOWNSTAIRS HALLWAY DOOR
  {model = "v_ilev_ph_gendoor005", x = 444.06, y = -989.48, z = 30.68, isLocked = true, jobRestriction = "police"}, -- DOWNSTAIRS HALLWAY DOOR
  {model = "v_ilev_ph_cellgate", x = 463.96, y = -992.61, z = 24.91, isLocked = true, jobRestriction = "police"}, -- CELL ENTRANCE
  {model = "v_ilev_ph_cellgate", x = 461.79, y = -993.77, z = 24.91, isLocked = true, jobRestriction = "police"}, -- CELL
  {model = "v_ilev_ph_cellgate", x = 461.83, y = -998.34, z = 24.91, isLocked = true, jobRestriction = "police"}, -- CELL
  {model = "v_ilev_ph_cellgate", x = 461.85, y = -1001.97, z = 24.91, isLocked = true, jobRestriction = "police"}, -- CELL
  {model = "v_ilev_gtdoor", x = 464.16, y = -1003.51, z = 24.91, isLocked = true, jobRestriction = "police"} -- BACK ENTRANCE CELLS
}

function getDoorConfig()
  return DoorConfig
end
