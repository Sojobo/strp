resource_type 'map' { gameTypes = { STRP = true } }
description 'STRP'

-- Manifest
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

-- General
client_scripts {
    'config.lua',
    'cl_strp.lua',
}

server_scripts {
    'sv_strp.lua',
}