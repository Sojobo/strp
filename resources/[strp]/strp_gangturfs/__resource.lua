resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

server_script '@mysql-async/lib/MySQL.lua'

client_scripts {
    'cl_turfs.lua'
}

server_scripts {
    'sv_turfs.lua'
}

export 'getTurfData'