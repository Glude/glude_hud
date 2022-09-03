-- Resource Metadata
fx_version 'cerulean'
games { 'rdr3', 'gta5' }

author 'Glude'
description 'StreetV Hud by Glude'
version '1.0.0'
shared_script '@es_extended/imports.lua'

client_scripts {
    'client.lua',
}

-- server_scripts {
--     '@mysql-async/lib/MySQL.lua',
--     'config.lua',
--     'server.lua',
-- }

ui_page 'html/index.html'

files {
    'html/*.*',
    'html/**/*.*',
    'css/*.css',
    'js/*.js',
    'img/*.*',
}

-- shared_script '@epm-anticheat/secly.lua'