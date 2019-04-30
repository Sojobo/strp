--Truck
Config	=	{}

 -- Limit, unit can be whatever you want. Originally grams (as average people can hold 25kg)
Config.Limit = 20

-- Default weight for an item:
	-- weight == 0 : The item do not affect character inventory weight
	-- weight > 0 : The item cost place on inventory
	-- weight < 0 : The item add place on inventory. Smart people will love it.
Config.DefaultWeight = 1

-- If true, ignore rest of file
Config.WeightSqlBased = false

-- I Prefer to edit weight on the config.lua and I have switched Config.WeightSqlBased to false:

Config.localWeight = {
	black_money = 0, -- poids pour un argent
}

Config.VehicleLimit = {
    [850565707] = { trunksize = 75 }, -- BJXL
    -- Boats
    [1033245328] = { trunksize = 15 }, -- Dinghy
    [276773164] = { trunksize = 15 }, -- Dinghy2
    [509498602] = { trunksize = 15 }, -- Dinghy3
    [867467158] = { trunksize = 15 }, -- Dinghy4
    [861409633] = { trunksize = 80 }, -- Jet Max
    [-1043459709] = { trunksize = 150 }, -- Marquis (sail boat)
    [-1030275036] = { trunksize = 10 }, -- Seashark
    [-616331036] = { trunksize = 10 }, -- Seashark2
    [-311022263] = { trunksize = 10 }, -- Seashark3
    [231083307] = { trunksize = 80 }, -- Speeder
    [437538602] = { trunksize = 80 }, -- Speeder2
    [400514754] = { trunksize = 75 }, -- Squalo
    [771711535] = { trunksize = 55 }, -- Submersible
    [-1066334226] = { trunksize = 60 }, -- Submersible2
    [-282946103] = { trunksize = 35 }, -- Simtrap
    [1070967343] = { trunksize = 75 }, -- Toro
    [908897389] = { trunksize = 75 }, -- Toro2
    [290013743] = { trunksize = 55 }, -- Tropic
    [1448677353] = { trunksize = 55 }, -- Tropic2
    [-2100640717] = { trunksize = 500 }, -- Tug
    -- Commerical Trucks
    [2053223216] = { trunksize = 0 }, -- Benson
    [850991848] = { trunksize = 0 }, -- Biff
    [1518533038] = { trunksize = 0 }, -- Hauler
    [387748548] = { trunksize = 0 }, -- Hauler2
    [904750859] = { trunksize = 0 }, -- Mule
    [-1050465301] = { trunksize = 0 }, -- Mule2
    [-2052737935] = { trunksize = 0 }, -- Mule3
    [569305213] = { trunksize = 0 }, -- Packer
    [-2137348917] = { trunksize = 0 }, -- Phantom
    [-1649536104] = { trunksize = 0 }, -- Phantom2
    [177270108] = { trunksize = 0 }, -- Phantom3
    [2112052861] = { trunksize = 0 }, -- Pounder
    [1747439474] = { trunksize = 0 }, -- Stockade
    [-214455498] = { trunksize = 0 }, -- Stockade3
    -- Compacts
    [-344943009] = { trunksize = 30 }, -- Blista
    [1039032026] = { trunksize = 30 }, -- Blista2
    [-591651781] = { trunksize = 30 }, -- Blista3
    [1549126457] = { trunksize = 20 }, -- Brioso
    [-1130810103] = { trunksize = 45 }, -- Dilettante
    [-1682114128] = { trunksize = 45 }, -- Dilettante2
    [-1177863319] = { trunksize = 25 }, -- Issi2
    [-431692672] = { trunksize = 15 }, -- panto
    [-1450650718] = { trunksize = 30 }, -- Prairie
    [841808271] = { trunksize = 30 }, -- Rhapsody
    -- Coupes
    [330661258] = { trunksize = 45 }, -- CogCabrio
    [-5153954] = { trunksize = 40 }, -- Exemplar
    [-591610296] = { trunksize = 40 }, -- F620
    [-391594584] = { trunksize = 35 }, -- Felon
    [-89291282] = { trunksize = 35 }, -- Felon2
    [-624529134] = { trunksize = 35 }, -- Jackal
    [1348744438] = { trunksize = 40 }, -- Oracle
    [-511601230] = { trunksize = 40 }, -- Oracle2
    [1349725314] = { trunksize = 40 }, -- Sentinel
    [873639469] = { trunksize = 40 }, -- Sentinel2
    [1581459400] = { trunksize = 35 }, -- Windsor
    [-1930048799] = { trunksize = 55 }, -- Windsor2
    [-1122289213] = { trunksize = 30 }, -- Zion
    [-1193103848] = { trunksize = 30 }, -- Zion2
    --Emergency
    [1171614426] = { trunksize = 80 }, -- Ambulance
    [794924083] = { trunksize = 80 }, -- Ambulance2
    [-74454596] = { trunksize = 40 }, -- emscar
    [-1351786721] = { trunksize = 70 }, -- emssuv
    [-1270651975] = { trunksize = 85 }, -- emsvan
    [1127131465] = { trunksize = 45 }, -- FBI
    [-1647941228] = { trunksize = 65 }, -- Fbi2
    [-1417902848] = { trunksize = 40 }, -- Fbi3
    [-1185144641] = { trunksize = 60 }, -- Fbi4
    [-1038306700] = { trunksize = 40 }, -- Fbi5
    [-799748380] = { trunksize = 40 }, -- Fbi6
    [1938952078] = { trunksize = 45 }, -- Firetruck
    [-2007026063] = { trunksize = 70 }, -- Prison Bus
    [2046537925] = { trunksize = 40 }, -- Police
    [-1627000575] = { trunksize = 40 }, -- Police2
    [1912215274] = { trunksize = 40 }, -- Police3
    [-1973172295] = { trunksize = 40 }, -- Police4
    [-1674384553] = { trunksize = 55 }, -- Police5
    [-1291872016] = { trunksize = 45 }, -- Police6
    [-994755493] = { trunksize = 40 }, -- Police7
    [-793815985] = { trunksize = 40 }, -- Police8
    [-1536924937] = { trunksize = 40 }, -- Snow police 1
    [-1779120616] = { trunksize = 60 }, -- Snow Police 2
    [456714581] = { trunksize = 85 }, -- Police Van
    [-34623805] = { trunksize = 15 }, -- Police Bike
    [353883353] = { trunksize = 45 }, -- Police Heli
    [741586030] = { trunksize = 60 }, -- Park Ranger SUV
    [-488123221] = { trunksize = 25 }, -- Police Boat
    [-1205689942] = { trunksize = 65 }, -- Riot Truck
    [-1683328900] = { trunksize = 35 }, -- Sheriff
    [-1922257928] = { trunksize = 60 }, -- Sheriff2
    [-253767517] = { trunksize = 40 }, -- Sheriff3
    [-1412512130] = { trunksize = 70 }, -- Sheriff6
    -- Helicopters
    [837858166] = { trunksize = 55 }, -- Annihilator
    [788747387] = { trunksize = 30 }, -- Buzzard
    [745926877] = { trunksize = 35 }, -- Buzzard2
    [-50547061] = { trunksize = 95 }, -- Cargobob
    [1621617168] = { trunksize = 95 }, -- Cargobob2
    [1394036463] = { trunksize = 95 }, -- Cargobob3
    [2025593404] = { trunksize = 95 }, -- Cargobob4
    [744705981] = { trunksize = 50 }, -- Frogger
    [1949211328] = { trunksize = 50 }, -- Frogger2
    [-1660661558] = { trunksize = 45 }, -- Maverick
    [-82626025] = { trunksize = 30 }, -- Savage
    [1044954915] = { trunksize = 15 }, -- Skylift
    [710198397] = { trunksize = 50 }, -- Supervolito
    [-1671539132] = { trunksize = 50 }, -- Supervolito2
    [-339587598] = { trunksize = 45 }, -- Swift
    [1075432268] = { trunksize = 45 }, -- Swift2
    [-1600252419] = { trunksize = 55 }, -- Valkyrie
    [1543134283] = { trunksize = 55 }, -- Valkyrie
    [-1845487887] = { trunksize = 75 }, -- Valtus
    --Industrial
    [1886712733] = { trunksize = 0 }, -- Bulldozer
    [-1006919392] = { trunksize = 0 }, -- Cutter
    [-2130482718] = { trunksize = 0 }, -- Dump
    [1353720154] = { trunksize = 0 }, -- Flatbed
    [-2107990196] = { trunksize = 0 }, -- Guardian
    [444583674] = { trunksize = 0 }, -- Handler
    [-784816453] = { trunksize = 0 }, -- Mixer
    [475220373] = { trunksize = 0 }, -- Mixer2
    [-1705304628] = { trunksize = 0 }, -- Rubble
    [48339065] = { trunksize = 0 }, -- Tip Truck
    [-947761570] = { trunksize = 0 }, -- Tip Truck2
    -- Military
    [562680400] = { trunksize = 0 }, -- APC
    [-823509173] = { trunksize = 0 }, -- Barracks
    [1074326203] = { trunksize = 0 }, -- Barracks2
    [630371791] = { trunksize = 0 }, -- Barracks3
    [321739290] = { trunksize = 0 }, -- Crusader
    [-32236122] = { trunksize = 0 }, -- Halftrack
    [782665360] = { trunksize = 0 }, -- Rhino
    [-1881846085] = { trunksize = 0 }, -- Trailersmall2
    -- Motorcycles
    [1672195559] = { trunksize = 10 }, -- Akuma
    [-2115793025] = { trunksize = 10 }, -- Avarus
    [-2140431165] = { trunksize = 15 }, -- Bagger
    [-891462355] = { trunksize = 10 }, -- Bati2
    [-114291515] = { trunksize = 10 }, -- Bati
    [86520421] = { trunksize = 15 }, -- Bf400
    [-440768424] = { trunksize = 20 }, -- Blazer4
    [11251904] = { trunksize = 10 }, -- Carbonrs
    [6774487] = { trunksize = 15 }, -- Chimera
    [390201602] = { trunksize = 10 }, -- Cliffhanger
    [-1404136503] = { trunksize = 10 }, -- Daemon2
    [2006142190] = { trunksize = 10 }, -- Daemon
    [822018448] = { trunksize = 10 }, -- Defiler
    [-1670998136] = { trunksize = 10 }, -- Double
    [1753414259] = { trunksize = 8 }, -- Enduro
    [2035069708] = { trunksize = 10 }, -- Esskey
    [-1842748181] = { trunksize = 8 }, -- Faggio
    [55628203] = { trunksize = 8 }, -- Faggio2
    [-1289178744] = { trunksize = 8 }, -- Faggio3
    [-757735410] = { trunksize = 9 }, -- Fcr2
    [627535535] = { trunksize = 8 }, -- Fcr
    [741090084] = { trunksize = 11 }, -- Gargoyle
    [-255678177] = { trunksize = 15 }, -- Hakuchou2
    [1265391242] = { trunksize = 10 }, -- Hakuchou
    [301427732] = { trunksize = 10 }, -- Hexer
    [-159126838] = { trunksize = 12 }, -- Innovation
    [640818791] = { trunksize = 10 }, -- Lectro
    [-1523428744] = { trunksize = 10 }, -- Manchez
    [-634879114] = { trunksize = 10 }, -- Nemesis
    [-1606187161] = { trunksize = 20 }, -- Nightlbade
    [884483972] = { trunksize = 10 }, -- Opressor
    [-909201658] = { trunksize = 10 }, -- PCJ
    [1873600305] = { trunksize = 8 }, -- Ratbike
    [-893578776] = { trunksize = 10 }, -- Ruffian
    [-1453280962] = { trunksize = 5 }, -- Sanchez2
    [788045382] = { trunksize = 5 }, -- Sanchez
    [1491277511] = { trunksize = 35 }, -- Sanctus
    [-405626514] = { trunksize = 50 }, -- Shotaro (tron bike)
    [743478836] = { trunksize = 15 }, -- Soverign
    [1836027715] = { trunksize = 20 }, -- Thrust
    [-140902153] = { trunksize = 10 }, -- Vader
    [-1353081087] = { trunksize = 25 }, -- Vindicator
    [-609625092] = { trunksize = 10 }, -- Vorex
    [-618617997] = { trunksize = 10 }, -- Wolfsbane
    [-1009268949] = { trunksize = 8 }, -- Zombiea
    [-570033273] = { trunksize = 8 }, -- Zombieb
    -- Muscle
    [-1205801634] = { trunksize = 40 }, -- Blade
    [-682211828] = { trunksize = 35 }, -- Buccaneer
    [-1013450936] = { trunksize = 35 }, -- Buccaneer2
    [349605904] = { trunksize = 30 }, -- Chino
    [-1361687965] = { trunksize = 30 }, -- Chino2
    [80636076] = { trunksize = 35 }, -- Dominator
    [-915704871] = { trunksize = 35 }, -- Domintor2
    [723973206] = { trunksize = 25 }, -- Dukes
    [-326143852] = { trunksize = 15 }, -- Dukes2
    [-2119578145] = { trunksize = 25 }, -- Faction
    [-1790546981] = { trunksize = 25 }, -- Faction2
    [-2039755226] = { trunksize = 35 }, -- Faction3
    [-1800170043] = { trunksize = 25 }, -- Gauntlet
    [349315417] = { trunksize = 25 }, -- Gauntlet2
    [37348240] = { trunksize = 25 }, -- Hotknife
    [2068293287] = { trunksize = 45 }, -- Lurcher
    [525509695] = { trunksize = 75 }, -- Moonbeam
    [1896491931] = { trunksize = 75 }, -- Moonbeam2
    [-1943285540] = { trunksize = 35 }, -- Nightshae
    [-2095439403] = { trunksize = 35 }, -- Pheonix
    [1507916787] = { trunksize = 25 }, -- Picador
    [-667151410] = { trunksize = 45 }, -- Ratloader
    [-589178377] = { trunksize = 55 }, -- Ratloader2
    [-227741703] = { trunksize = 35 }, -- Ruiner
    [941494461] = { trunksize = 35 }, -- Ruiner2
    [-1685021548] = { trunksize = 25 }, -- SabreGT
    [223258115] = { trunksize = 65 }, -- Sadler2
    [734217681] = { trunksize = 55 }, -- Slamvan
    [729783779] = { trunksize = 65 }, -- Slamvan2
    [833469436] = { trunksize = 55 }, -- Slamvan3
    [1119641113] = { trunksize = 25 }, -- Stalion
    [1923400478] = { trunksize = 25 }, -- Stalion2
    [972671128] = { trunksize = 25 }, -- Tampa
    [-1210451983] = { trunksize = 35 }, -- Tampa3
    [-825837129] = { trunksize = 25 }, -- Vigero
    [-498054846] = { trunksize = 35 }, -- Virgo
    [-899509638] = { trunksize = 35 }, -- Virgo2
    [16646064] = { trunksize = 35 }, -- Virgo3
    [2006667053] = { trunksize = 35 }, -- Voodoo
    [523724515] = { trunksize = 35 }, -- Voodoo2
    -- Off-Road
    [1126868326] = { trunksize = 25 }, -- Bfinjection (rust bettle)
    [-349601129] = { trunksize = 20 }, -- Bifto
    [-2128233223] = { trunksize = 10 }, -- Blazer
    [-48031959] = { trunksize = 10 }, -- Blazer2
    [-1269889662] = { trunksize = 10 }, -- Blazer3
    [-1590337689] = { trunksize = 20 }, -- Blazer5
    [-1435919434] = { trunksize = 40 }, -- Bodhi2
    [-1479664699] = { trunksize = 30 }, -- Brawler
    [1770332643] = { trunksize = 50 }, -- DLoader
    [-1661854193] = { trunksize = 10 }, -- Dune
    [534258863] = { trunksize = 10 }, -- Dune2
    [1897744184] = { trunksize = 5 }, -- Dune3
    [-827162039] = { trunksize = 5 }, -- Dune4
    [-827162039] = { trunksize = 5 }, -- Dune5
    [-1860900134] = { trunksize = 40 }, -- Insurgent
    [2071877360] = { trunksize = 45 }, -- Insurgent2
    [-1924433270] = { trunksize = 45 }, -- Insurgent3
    [92612664] = { trunksize = 50 }, -- Kalahari
    [469291905] = { trunksize = 55 }, -- Lguard
    [1233534620] = { trunksize = 40 }, -- Marshall
    [914654722] = { trunksize = 50 }, -- Mesa
    [-748008636] = { trunksize = 50 }, -- Mesa2
    [-2064372143] = { trunksize = 75 }, -- Mesa3
    [-845961253] = { trunksize = 50 }, -- Monster
    [433954513] = { trunksize = 50 }, -- Nightshark
    [1645267888] = { trunksize = 60 }, -- RancherXL
    [1933662059] = { trunksize = 60 }, -- RancherXL2
    [-1207771834] = { trunksize = 75 }, -- Rebel
    [-2045594037] = { trunksize = 75 }, -- Rebel2
    [-1189015600] = { trunksize = 80 }, -- Sandking
    [989381445] = { trunksize = 60 }, -- Sandking2
    [-2096818938] = { trunksize = 25 }, -- Technical
    [1180875963] = { trunksize = 20 }, -- Technical2
    [1356124575] = { trunksize = 25 }, -- Technical3
    [101905590] = { trunksize = 20 }, -- Trophy Truck
    [-663299102] = { trunksize = 25 }, -- TrophyTruck2
    -- Planes
    [1824333165] = { trunksize = 25 }, -- Besra
    [-150975354] = { trunksize = 80 }, -- Blimp
    [-613725916] = { trunksize = 80 }, -- Blimp2
    [368211810] = { trunksize = 10000 }, -- CargoPlane
    [-644710429] = { trunksize = 150 }, -- Cuban800
    [-901163259] = { trunksize = 125 }, -- Dodo
    [970356638] = { trunksize = 40 }, -- Duster
    [970385471] = { trunksize = 20 }, -- Hydra
    [1058115860] = { trunksize = 1250 }, -- Jet
    [-1281684762] = { trunksize = 30 }, -- Lazer
    [621481054] = { trunksize = 200 }, -- Luxor
    [-1214293858] = { trunksize = 210 }, -- Luxor2
    [-1746576111] = { trunksize = 80 }, -- Mammatus
    [165154707] = { trunksize = 250 }, -- MiliJet
    [-1295027632] = { trunksize = 225 }, -- Nimbus
    [-1214505995] = { trunksize = 215 }, -- Shamal
    [-2122757008] = { trunksize = 20 }, -- Stunt
    [1981688531] = { trunksize = 5000 }, -- Titan
    [-1673356438] = { trunksize = 115 }, -- Velum
    [1077420264] = { trunksize = 115 }, -- Velum2
    [1341619767] = { trunksize = 140 }, -- Vestra
    -- SUVs
    [-808831384] = { trunksize = 65 }, -- Baller
    [142944341] = { trunksize = 70 }, -- Baller2
    [1878062887] = { trunksize = 60 }, -- Baller3
    [634118882] = { trunksize = 60 }, -- Baller4
    [470404958] = { trunksize = 40 }, -- Baller5
    [666166960] = { trunksize = 40 }, -- Baller6
    [2006918058] = { trunksize = 65 }, -- Cavalcade
    [-789894171] = { trunksize = 65 }, -- Cavalcade2
    [683047626] = { trunksize = 85 }, -- Contender
    [1177543287] = { trunksize = 55 }, -- Dubsta
    [-394074634] = { trunksize = 55 }, -- Dubsta2
    [-1237253773] = { trunksize = 65 }, -- Dubsta3
    [-1137532101] = { trunksize = 50 }, -- FQ2
    [-1775728740] = { trunksize = 75 }, -- Granger
    [-1543762099] = { trunksize = 65 }, -- Gresley
    [884422927] = { trunksize = 40 }, -- Habanero
    [486987393] = { trunksize = 55 }, -- Huntley
    [1269098716] = { trunksize = 60 }, -- Landstalker
    [-808457413] = { trunksize = 85 }, -- Patriot
    [-1651067813] = { trunksize = 50 }, -- Radi
    [2136773105] = { trunksize = 50 }, -- Rocoto
    [1221512915] = { trunksize = 55 }, -- Seminole
    [1337041428] = { trunksize = 45 }, -- Serrano
    [1203490606] = { trunksize = 45 }, -- XLS
    [-432008408] = { trunksize = 35 }, -- XLS2
    -- Sedans
    [-1809822327] = { trunksize = 30 }, -- Asea
    [-1807623979] = { trunksize = 30 }, -- Asea2
    [-1903012613] = { trunksize = 35 }, -- Asterope
    [906642318] = { trunksize = 40 }, -- Cog55
    [704435172] = { trunksize = 45 }, -- Cog552
    [-2030171296] = { trunksize = 50 }, -- Cognoscenti
    [-604842630] = { trunksize = 50 }, -- Cognoscenti2
    [-685276541] = { trunksize = 35 }, -- Emperor
    [-1883002148] = { trunksize = 25 }, -- Emperor2
    [-1241712818] = { trunksize = 35 }, -- Emperor3
    [1909141499] = { trunksize = 45 }, -- Fugitive
    [75131841] = { trunksize = 40 }, -- Glendale
    [-1289722222] = { trunksize = 35 }, -- Ingot
    [886934177] = { trunksize = 35 }, -- Intruder
    [-114627507] = { trunksize = 65 }, -- Limo2
    [-1883869285] = { trunksize = 35 }, -- Premier
    [-1150599089] = { trunksize = 45 }, -- Primo
    [-2040426790] = { trunksize = 40 }, -- Primo2
    [-14495224] = { trunksize = 55 }, -- Regina
    [627094268] = { trunksize = 75 }, -- Romero
    [-1477580979] = { trunksize = 45 }, -- Stanier
    [1723137093] = { trunksize = 35 }, -- Stratum
    [-1961627517] = { trunksize = 85 }, -- Stretch
    [-1894894188] = { trunksize = 45 }, -- Surge
    [-1008861746] = { trunksize = 45 }, -- Tailgater
    [1373123368] = { trunksize = 35 }, -- Warrener
    [1777363799] = { trunksize = 50 }, -- Washington
    -- Service
    [1283517198] = { trunksize = 0 }, -- Airbus
    [-305727417] = { trunksize = 0 }, -- Brickade
    [-713569950] = { trunksize = 0 }, -- Bus
    [-2072933068] = { trunksize = 0 }, -- Coach
    [-2103821244] = { trunksize = 0 }, -- Rallytruck
    [-1098802077] = { trunksize = 0 }, -- RentalBus
    [-956048545] = { trunksize = 40 }, -- Taxi
    [1941029835] = { trunksize = 0 }, -- Tourbus
    [1917016601] = { trunksize = 0 }, -- Trash
    [-1255698084] = { trunksize = 0 }, -- Trash2
    -- Sports
    [767087018] = { trunksize = 40 }, -- Alpha
    [-1041692462] = { trunksize = 30 }, -- Banshee
    [633712403] = { trunksize = 30 }, -- Banshee2
    [1274868363] = { trunksize = 40 }, -- BastiaGTS
    [-304802106] = { trunksize = 45 }, -- Buffalo
    [736902334] = { trunksize = 45 }, -- Buffalo2
    [237764926] = { trunksize = 35 }, -- Buffalo3
    [2072687711] = { trunksize = 30 }, -- Carbonizzare
    [-1045541610] = { trunksize = 25 }, -- Comet2
    [-2022483795] = { trunksize = 25 }, -- Comet3
    [108773431] = { trunksize = 25 }, -- Coquette
    [196747873] = { trunksize = 35 }, -- Elegy
    [-566387422] = { trunksize = 30 }, -- Elegy2
    [-1995326987] = { trunksize = 40 }, -- Feltzer2
    [-1566741232] = { trunksize = 25 }, -- Felzter3
    [-1089039904] = { trunksize = 30 }, -- Furoregt
    [499169875] = { trunksize = 35 }, -- Fusilade
    [2016857647] = { trunksize = 25 }, -- Futo
    [-1405937764] = { trunksize = 20 }, -- Infernus2
    [-1297672541] = { trunksize = 25 }, -- Jester
    [-1106353882] = { trunksize = 20 }, -- Jester2
    [544021352] = { trunksize = 30 }, -- Khamelion
    [-1372848492] = { trunksize = 40 }, -- Kuruma
    [410882957] = { trunksize = 25 }, -- Kuruma2
    [482197771] = { trunksize = 20 }, -- Lynx
    [-142942670] = { trunksize = 25 }, -- Massacro
    [-631760477] = { trunksize = 20 }, -- Massacro2
    [1032823388] = { trunksize = 25 }, -- Ninef
    [-1461482751] = { trunksize = 25 }, -- Ninef2
    [-777172681] = { trunksize = 20 }, -- Omnis
    [-377465520] = { trunksize = 35 }, -- Penumbra
    [-1934452204] = { trunksize = 25 }, -- RapidGT
    [1737773231] = { trunksize = 25 }, -- RapidGT2
    [-674927303] = { trunksize = 5 }, -- Raptor
    [719660200] = { trunksize = 10 }, -- Ruston
    [-1255452397] = { trunksize = 55 }, -- Schafter2
    [-1485523546] = { trunksize = 55 }, -- Schafter3
    [1489967196] = { trunksize = 40 }, -- Schafter4
    [-888242983] = { trunksize = 40 }, -- Schafter5
    [1922255844] = { trunksize = 40 }, -- Schafter6
    [-746882698] = { trunksize = 35 }, -- Schwarzer
    [-1757836725] = { trunksize = 20 }, -- Seven70
    [1886268224] = { trunksize = 25 }, -- Specter
    [1074745671] = { trunksize = 20 }, -- Specter2
    [970598228] = { trunksize = 40 }, -- Sultan
    [384071873] = { trunksize = 30 }, -- Surano
    [-1071380347] = { trunksize = 30 }, -- Tampa2
    [1887331236] = { trunksize = 25 }, -- Tropos
    [1102544804] = { trunksize = 35 }, -- Verlierer2
    -- Sport Classic
    [159274291] = { trunksize = 35 }, -- Ardent
    [117401876] = { trunksize = 25 }, -- BType
    [-831834716] = { trunksize = 25 }, -- BType2
    [-602287871] = { trunksize = 25 }, -- BType3
    [941800958] = { trunksize = 25 }, -- Casco
    [223240013] = { trunksize = 25 }, -- Cheetah2
    [1011753235] = { trunksize = 25 }, -- Coquette2
    [784565758] = { trunksize = 25 }, -- Coquette3
    [1051415893] = { trunksize = 25 }, -- JB700
    [-1660945322] = { trunksize = 15 }, -- Mamaba
    [-2124201592] = { trunksize = 35 }, -- Manana
    [-433375717] = { trunksize = 25 }, -- Monroe
    [1830407356] = { trunksize = 25 }, -- Peyote
    [1078682497] = { trunksize = 35 }, -- Pigalle
    [1545842587] = { trunksize = 25 }, -- Stinger
    [-2098947590] = { trunksize = 25 }, -- StingerGT
    [1504306544] = { trunksize = 25 }, -- Torero
    [464687292] = { trunksize = 35 }, -- Tornado
    [1531094468] = { trunksize = 45 }, -- Tornado2
    [1762279763] = { trunksize = 15 }, -- Tornado3
    [-2033222435] = { trunksize = 15 }, -- Tornado4
    [-1797613329] = { trunksize = 45 }, -- Tornado5
    [-1558399629] = { trunksize = 10 }, -- Tornado6
    [75889561] = { trunksize = 25 }, -- ZType
    -- Super
    [-1216765807] = { trunksize = 25 }, -- Adder
    [-1696146015] = { trunksize = 30 }, -- Bullet
    [-1311154784] = { trunksize = 20 }, --Cheetah
    [-1291952903] = { trunksize = 20 }, -- Entity XF
    [1426219628] = { trunksize = 30 }, -- FMJ
    [1234311532] = { trunksize = 25 }, -- GP1
    [418536135] = { trunksize = 25 }, -- Infernus
    [-1232836011] = { trunksize = 20 }, -- LE7B
    [1034187331] = { trunksize = 30 }, -- Nero
    [1093792632] = { trunksize = 35 }, -- Nero2
    [1987142870] = { trunksize = 30 }, -- Osiris
    [-1758137366] = { trunksize = 25 }, -- Penetrator
    [-1829802492] = { trunksize = 25 }, -- Pfister811
    [2123327359] = { trunksize = 15 }, -- Prototipo
    [234062309] = { trunksize = 25 }, -- Reaper
    [819197656] = { trunksize = 25 }, -- Sheava (etr1)
    [-295689028] = { trunksize = 25 }, -- SultranRS
    [1123216662] = { trunksize = 45 }, -- Superd
    [1663218586] = { trunksize = 25 }, -- T20
    [272929391] = { trunksize = 20 }, -- Tempesta
    [-982130927] = { trunksize = 25 }, -- Turismo2
    [408192225] = { trunksize = 20 }, -- Turismor
    [2067820283] = { trunksize = 20 }, -- Tyrus
    [338562499] = { trunksize = 20 }, -- Vacca
    [1939284556] = { trunksize = 25 }, -- Vagner
    [-1622444098] = { trunksize = 30 }, -- Voltic
    [989294410] = { trunksize = 15 }, -- Voltic2
    [-1403128555] = { trunksize = 25 }, -- Zentorno
    [-2048333973] = { trunksize = 25 }, -- Italigtb
    [-482719877] = { trunksize = 25 }, -- Italigtb2
    [917809321] = { trunksize = 30 }, -- XA21
    -- Trailer
    [-1207431159] = { trunksize = 0 }, -- ArmyTanker
    [-1476447243] = { trunksize = 0 }, -- Army Trailer
    [-1637149482] = { trunksize = 0 }, -- ArmyTrailer2
    [-399841706] = { trunksize = 0 }, -- Bale Trailer
    [524108981] = { trunksize = 0 }, -- Boat Trailer
    [-960289747] = { trunksize = 0 }, -- CableCar ?
    [-2140210194] = { trunksize = 0 }, -- Dock Trailer
    [1019737494] = { trunksize = 0 }, -- GrainTrailer
    [356391690] = { trunksize = 0 }, -- PropTrailer
    [390902130] = { trunksize = 0 }, -- Rake Trailer
    [2078290630] = { trunksize = 0 }, -- TR2
    [1784254509] = { trunksize = 0 }, -- TR3
    [2091594960] = { trunksize = 0 }, -- TR4
    [-1352468814] = { trunksize = 0 }, -- TRFlat
    [-1770643266] = { trunksize = 0 }, -- TVTrailer
    [-730904777] = { trunksize = 0 }, -- Tanker
    [1956216962] = { trunksize = 0 }, -- Tanker2
    [2016027501] = { trunksize = 0 }, -- TrailerLogs
    [712162987] = { trunksize = 0 }, -- TrailerSmall
    [-877478386] = { trunksize = 0 }, -- Trailers
    [-1579533167] = { trunksize = 0 }, -- Trailers2
    [-2058878099] = { trunksize = 0 }, -- Trailers3
    -- Choo Choo Trains
    [1030400667] = { trunksize = 0 }, -- Freught
    [184361638] = { trunksize = 0 }, -- FreightCar
    [920453016] = { trunksize = 0 }, -- CreightCont1
    [240201337] = { trunksize = 0 }, -- FreightCont2
    [642617954] = { trunksize = 0 }, -- CreightGrain
    [-777275802] = { trunksize = 0 }, -- FreightTrailer
    [586013744] = { trunksize = 0 }, -- TankerCar
    -- Utility
    [1560980623] = { trunksize = 10 }, -- Airtug
    [1147287684] = { trunksize = 10 }, -- Caddy
    [-537896628] = { trunksize = 10 }, -- Caddy2
    [-769147461] = { trunksize = 25 }, -- Caddy3
    [-884690486] = { trunksize = 35 }, -- Docktug
    [1491375716] = { trunksize = 5 }, -- Forklift
    [1783355638] = { trunksize = 2 }, -- Mower
    [-845979911] = { trunksize = 20 }, -- Ripley
    [-599568815] = { trunksize = 75 }, -- Sadler
    [-1700801569] = { trunksize = 0 }, -- Scrap
    [-1323100960] = { trunksize = 30 }, -- TowTruck
    [-442313018] = { trunksize = 15 }, -- Towtruck2
    [1641462412] = { trunksize = 2 }, -- Tractor
    [-2076478498] = { trunksize = 15 }, -- Tractor2
    [1445631933] = { trunksize = 15 }, -- Tractor3
    [1502869817] = { trunksize = 0 }, -- TrailerLarge
    [-1100548694] = { trunksize = 5 }, -- TrailerS4
    [516990260] = { trunksize = 30 }, -- UtiliTruck
    [2132890591] = { trunksize = 55 }, -- UtiliTruck3
    [887537515] = { trunksize = 60 }, -- UtiliTruck2
    -- Vans
    [-16948145] = { trunksize = 65 }, -- Bison
    [2072156101] = { trunksize = 65 }, -- Bison2
    [1739845664] = { trunksize = 70 }, -- Bison3
    [1069929536] = { trunksize = 60 }, -- BobcatXL
    [-1987130134] = { trunksize = 95 }, -- Boxville
    [-233098306] = { trunksize = 95 }, -- Boxville2
    [121658888] = { trunksize = 95 }, -- Boxville3
    [444171386] = { trunksize = 95 }, -- Boxville4
    [682434785] = { trunksize = 40 }, -- Boxville5
    [-1346687836] = { trunksize = 90 }, -- Burrito
    [-907477130] = { trunksize = 90 }, -- Burrito2
    [-1743316013] = { trunksize = 90 }, -- Burrito3
    [893081117] = { trunksize = 90 }, -- Burrito4
    [1132262048] = { trunksize = 85 }, -- Burrito5
    [1876516712] = { trunksize = 115 }, -- Camper
    [-1745203402] = { trunksize = 85 }, -- GBurrito
    [296357396] = { trunksize = 80 }, -- GBurrito2
    [-120287622] = { trunksize = 80 }, -- Journey
    [-310465116] = { trunksize = 60 }, -- Minivan
    [-1126264336] = { trunksize = 50 }, -- Minivan2
    [1488164764] = { trunksize = 80 }, -- Paradise
    [-119658072] = { trunksize = 75 }, -- Pony
    [943752001] = { trunksize = 75 }, -- Pony2
    [1162065741] = { trunksize = 70 }, -- Rumpo
    [-1776615689] = { trunksize = 70 }, -- Rumpo2
    [1475773103] = { trunksize = 60 }, -- Rumpo3
    [-810318068] = { trunksize = 65 }, -- Speedo
    [728614474] = { trunksize = 55 }, -- Speedo2
    [699456151] = { trunksize = 50 }, -- Surfer
    [-1311240698] = { trunksize = 45 }, -- Surfer2
    [1951180813] = { trunksize = 60 }, -- Taco
    [65402552] = { trunksize = 70 }, -- Youga
    [1026149675] = { trunksize = 65 }, -- Youga2
    -- Custom Cars
    [-635747987] = { trunksize = 25 }, -- Italia458
    [2005386580] = { trunksize = 25 }, -- Lykan
    [-1752116803] = { trunksize = 30 }, -- GTR
    [418807219] = { trunksize = 20 }, -- M4GTS
    [178350184] = { trunksize = 65 }, -- Merc SUV
    [162432206] = { trunksize = 25 }, -- mst mustang
    [-1724630220] = { trunksize = 60 }, -- phantom
    -- Doomsday Cars
    [3981782132] = { trunksize = 30 }, -- Autarch
    [661493923] = { trunksize = 35 }, -- Comet5
    [1483171323] = { trunksize = 30 }, -- Deluxo
    [2215179066] = { trunksize = 20 }, -- gt500
    [15219735] = { trunksize = 20 }, -- Hermes
    [600450546] = { trunksize = 15 }, -- hustler
    [-121446169] = { trunksize = 90 }, -- kamacho
    [2445973230] = { trunksize = 50 }, -- neon
    [867799010] = { trunksize = 25 }, -- pariah
    [2765724541] = { trunksize = 60 }, -- raiden
    [3884762073] = { trunksize = 50 }, -- revolter
    [-1532697517] = { trunksize = 65 }, -- riata
    [2601952180] = { trunksize = 100 }, -- riot2
    [903794909] = { trunksize = 40 }, -- savestra
    [1352136073] = { trunksize = 30 }, -- sc1
    [1104234922] = { trunksize = 30 }, -- sentinel3
    [1741861769] = { trunksize = 70 }, -- streiter
    [1489874736] = { trunksize = 10 }, -- thruster
    [-391595372] = { trunksize = 30 }, -- viseris
    [1871995513] = { trunksize = 50 }, -- yosemite
    [838982985] = { trunksize = 25 }, -- z190
    -- DLC
    [-49115651] = { trunksize = 30 }, -- Vamos
    [1456744817] = { trunksize = 30 }, -- Tulip
    [-1168952148] = { trunksize = 70 }, -- Toros
    [-507495760] = { trunksize = 10 }, -- Schlagen
    [-331467772] = { trunksize = 10 }, -- Italigto
    [-2096690334] = { trunksize = 20 }, -- Impaler
    [1009171724] = { trunksize = 10 }, -- Impaler2
    [1279262537] = { trunksize = 20 }, -- Deviant
    [1591739866] = { trunksize = 5 }, -- Deveste
    [-1566607184] = { trunksize = 25 }, -- Clique
    [-214906006] = { trunksize = 20 }, -- Jester3
    [500482303] = { trunksize = 20 }, -- Swinger
    [321186144] = { trunksize = 25 }, -- Stafford
    [219613597] = { trunksize = 85 }, -- Speedo4
    [-54332285] = { trunksize = 45 }, -- Freecrawler
    [-1259134696] = { trunksize = 15 }, -- FlashGT
    [-2120700196] = { trunksize = 5 }, -- Entity2
    [-1267543371] = { trunksize = 25 }, -- Ellie
    [-986944621] = { trunksize = 25 }, -- Dominator3
    [1617472902] = { trunksize = 55 }, -- Fagaloa
    [1115909093] = { trunksize = 10 }, -- Hotring
    [1046206681] = { trunksize = 15 }, -- Michelli
    [-1134706562] = { trunksize = 10 }, -- Taipan
    [-376434238] = { trunksize = 10 }, -- Tyrant

--LEs
[1813965170] = { trunksize = 35 }, -- Rs7
[1663453404] = { trunksize = 60 }, -- evoque
[-279141045] = { trunksize = 30 }, -- mustang
}