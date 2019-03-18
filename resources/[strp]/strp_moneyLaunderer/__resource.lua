-- Manifest
resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

-- General
client_scripts {
    'cl_dirtymoney.lua'
}

server_script '@mysql-async/lib/MySQL.lua'

server_scripts {
    'sv_dirtymoney.lua'
}
