# boardytale
Multiplayer game inspired by Wesnoth, built on Angular2, StageX and, Aqueduct2

# change common class
anotate
run `pub run build_runner build`

# run game
install dart https://www.dartlang.org/tools/sdk#install

run
dart runner/pub_get_all.dart

wait until finished

run 
dart runner/run.dart


GLOBAL TODOs:
 - Write test on serialization and deserialization all tales
 - Take care of images, delete race specific backgrounds
 - Add author name to and image origin to every used image
 - Separate tales compilation from server process
 - consider translations
    - unitTypeName
    - unit name
 - image refactoring [https://docs.google.com/document/d/1Yks_w_cAMHexz8LEXJwvHqBRz1V8LmxCjYM9jqr5zZA/edit]