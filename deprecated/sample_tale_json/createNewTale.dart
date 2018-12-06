import 'dart:io';
import 'packSDK.dart';

const String PART1 = """import {ITale} from './sdk_packed';

export let tale: ITale = {

    taleId: '""";

const String PART2 = """',
    taleName: 'tale_name_""";


const String PART3 = """',
    taleVersion: 0,
    defaultDifficulty: 10,
    compilerVersion: "0.0.0",
    map: {
        width: 20,
        height: 20,
        baseTerrain: "edit default terrain",
        fields: {}
    },
    units: {},
    unitGroups: {},
    unitTypes: {},
    abilities: {},
    actions: {},
    images: {},
    animations: {},
    ais: {},
    aiPlayers: {},
    dialogs: {},
    variables: {},
    members: {},
    langs: [],
    triggers: [],
    heroes: [],
    other: {},
};""";

const String COMPILE_CONT = """
  import {tale} from './tale';
  console.log(JSON.stringify(tale));
  const fs = require('fs');
  fs.writeFileSync('compiled.json', JSON.stringify(tale));
""";

void main(List<String> args){
  String taleName = args.first;

  Directory dir = new Directory(taleName);
  if(dir.existsSync()){
    print("Directory with given name already exists");
  }
  else{
    dir.createSync();
    File file = new File("$taleName/tale.ts");
    String fileCont = PART1 + taleName + PART2 + taleName + PART3;
    file.writeAsStringSync(fileCont);
    packSDK(taleName);
    //  todo: mockDb
    (new File(taleName+"/storage_identifiers.ts")).writeAsStringSync((new File("template/storage_identifiers.ts")).readAsStringSync());
    (new File(taleName+"/compile.ts")).writeAsStringSync(COMPILE_CONT);
    }
  }

