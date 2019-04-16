# boardytale
Multiplayer game inspired by Wesnoth, built on Angular2, StageX and, Aqueduct2

#initial tasks to run project
consider using chocolately for windows install https://chocolatey.org/

install dart, add to path 
 - https://www.dartlang.org/tools/sdk#install
 - (https://chocolatey.org/packages/dart-sdk)

install nodejs, add to path

install webdev [https://pub.dartlang.org/packages/webdev]

check path variable if dart, pub, npm executables are available for command line commands

open IDE, set dart executables

run `pub get` in ./libs/io_utils

 

# change common class
run `npm run generate-core`

# run game


run
dart runner/pub_get_all.dart

wait until finished

run 
dart runner/run.dart

between `generate core` and `initial-data-to-database` editor server must be restarted! (using old version of fromJson and toJson)



GLOBAL TODOs:
 - Write test on serialization and deserialization all tales
 - Take care of images, delete race specific backgrounds
 - Add author name to and image origin to every used image
 - Separate tales compilation from server process
 - consider translations
    - unitTypeName
    - unit name
 - image refactoring [https://docs.google.com/document/d/1Yks_w_cAMHexz8LEXJwvHqBRz1V8LmxCjYM9jqr5zZA/edit]
