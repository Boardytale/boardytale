# Temporarily hidden codebase

Until we solve a licencing issues, the code is hidden. We can join our team on Gitlab. Just request access https://gitlab.com/mlcoch.zdenek/boardytale



# boardytale
Multiplayer game inspired by Wesnoth, built on Angular2, StageX and, Aqueduct2

#initial tasks to run project
consider using chocolately for windows install https://chocolatey.org/

install dart, add to path 
 - https://www.dartlang.org/tools/sdk#install
 - (https://chocolatey.org/packages/dart-sdk)

install nodejs, add to path

install webdev on version 1.0.1 `pub global activate webdev 1.0.1` [https://pub.dartlang.org/packages/webdev]

check path variable if dart, pub, npm executables are available for command line commands

open IDE, set dart executables

run `npm install` restart of your console/IDE might be needed after this step.

run `npm run pub-get-all` to get dart dependencies for all packages, wait until finished

run `npm run set-config-dev` to create a config file

run debug on all packages you are going to develop - suggesting to run debug game_server
 - right click on `game_server/bin/game_servers_start.dart` and click on debug icon
 
run `npm run start-dev` to run all microservices

run `npm run game-client` - not in start dev, because its start takes a long time so restart of start dev would be too slow
 
game is running on port set in dev-config.ts proxy server - probably 8083

# important notes

when you are using `initial-data-to-database` full (not mocked) version of editor should run

after change of core class run `npm run generate-core`

between `generate core` and `initial-data-to-database` editor server must be restarted! (using old version of fromJson and toJson)

game is runnning on port set in 

# GLOBAL TODOs:
 - Write test on serialization and deserialization all tales
 - Take care of images, delete race specific backgrounds
 - Add author name to and image origin to every used image
 - Separate tales compilation from server process
 - consider translations
    - unitTypeName
    - unit name
 - image refactoring [https://docs.google.com/document/d/1Yks_w_cAMHexz8LEXJwvHqBRz1V8LmxCjYM9jqr5zZA/edit]

# create editor server database
 - activate aqueduct [https://aqueduct.io]
 - `cd editor_server && aqueduct db generate`
 - `aqueduct db upgrade`
