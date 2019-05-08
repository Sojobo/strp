resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

ui_page('html/index.html') 

files({
  'html/index.html',
  'html/script.js',
  'html/style.css',
	'html/img/burger.png',
	'html/img/bottle.png',
  'html/font/vibes.ttf',
  'html/img/box.png',
  'html/img/carticon.png',
  'html/img/carticon.png',
  'html/img/beer.png',
    'html/img/binoculars.png',
    'html/img/bread.png',
    'html/img/cannabis.png',
    'html/img/cocaine.png',
    'html/img/coke_pooch.png',
    'html/img/papers.png',
    'html/img/hamburger.png',
    'html/img/wine.png',
    'html/img/cash.png',
    'html/img/jewels.png',
    'html/img/medikit.png',
    'html/img/water.png',
    'html/img/croquettes.png',
    'html/img/bolpistache.png',
    'html/img/bolnoixcajou.png',
    'html/img/bolcacahuetes.png',
    'html/img/fixkit.png',
    'html/img/bolchips.png',
    ---burglary shit & etc
    'html/img/goldchain.png',
    'html/img/goldbracelet.png',
    'html/img/sojobeans.png',
    'html/img/cocaplant.png',
    'html/img/console.png',
    'html/img/cloth.png',
    'html/img/contrat.png',
    'html/img/metal.png',
    'html/img/bottle.png',
    'html/img/trigger.png',
    'html/img/semiautotrigger.png',
    'html/img/autotrigger.png',
    'html/img/pistolbody.png',
    'html/img/semiautobody.png',
    'html/img/autobody.png',
    'html/img/pistolclip.png',
    'html/img/smgclip.png',
    'html/img/grapes.png',
    'html/img/lockpick.png',
    'html/img/lotteryticket.png',
    'html/img/metalpipe.png',

})

client_scripts {
  'config.lua',
  'client/main.lua',
  '@es_extended/locale.lua',
  'locales/en.lua',
  'locales/fr.lua',	
  'locales/sv.lua',
}

server_scripts {
  'config.lua',
  'server/main.lua',
  '@mysql-async/lib/MySQL.lua'
}
