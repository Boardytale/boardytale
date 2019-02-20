// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// TypescriptGenerator
// **************************************************************************

export type ImageType =
    | 'field'
    | 'unitIcon'
    | 'unitBase'
    | 'unitHighRes'
    | 'item'
    | 'taleFullScreen'
    | 'taleBottomScreen';

export type ImageTag = 'grass' | 'forest' | 'water' | 'rock';

export interface Image extends Object {
    name: string;
    data: string;
    multiply: number;
    width: number;
    height: number;
    top: number;
    left: number;
    type: ImageType;
    authorEmail: string;
    imageVersion: number;
    dataModelVersion: number;
    origin: string;
    created: string;
    tags: Array<ImageTag>;
}

export interface User extends Object {
    name: string;
    email: string;
    innerToken: string;
}

export interface Unit extends Object {
    _name: string;
    armor: number;
    speed: number;
    range: number;
    attack: Array<number>;
    _health: number;
    _far: number;
    id: string;
    _actions: number;
    _steps: number;
    type: UnitType;
    _field: Field;
    player: Player;
    abilities: Array<Ability>;
    _buffs: Array<Buff>;
    tags: any;
    _onHealthChanged: any;
    _onFieldChanged: any;
    _onTypeChanged: any;
    _onStepsChanged: any;
}

export type UnitTypeTag = 'undead' | 'ethernal' | 'mechanic';

export interface UnitTypeCommons extends Object {
    name: string;
    race: Races;
    tags: Array<UnitTypeTag>;
    health: number;
    armor: number;
    speed: number;
    range: number;
    actions: number;
    attack: string;
    cost: number;
    langName: { [key in Lang]?: string };
    unitTypeDataVersion: number;
    unitTypeVersion: number;
}

export interface UnitTypeCreateEnvelope extends UnitTypeCommons {
    abilities: AbilitiesEnvelope;
    authorEmail: string;
    created: string;
    imageName: string;
    iconName: string;
    bigImageName: string;
}

export interface UnitTypeCompiled extends UnitTypeCommons {
    abilities: AbilitiesEnvelope;
    authorEmail: string;
    image: Image;
    icon: Image;
    bigImage: Image;
}

export type Races = 'human' | 'undead' | 'gultam' | 'elf' | 'animal';

export interface Race extends Object {
    id: Races;
    name: { [key in Lang]?: string };
}

export type Terrain = 'grass' | 'rock' | 'water' | 'forest';

export interface FieldCreateEnvelope extends Object {
    terrain: Terrain;
}

export interface Field extends Object {
    units: Array<Unit>;
    id: string;
    world: World;
    terrain: Terrain;
    x: number;
    y: number;
}

export interface WorldCreateEnvelope extends Object {
    width: number;
    height: number;
    baseTerrain: Terrain;
    fields: { [key: string]: FieldCreateEnvelope };
    startFieldId: string;
}

export interface World extends Object {
    width: number;
    height: number;
    baseTerrain: Terrain;
    fields: { [key: string]: Field };
    startField: Field;
    clientTaleService: Tale;
}

export interface Player extends Object {
    portrait: Image;
    id: string;
    name: string;
    team: string;
    color: number;
    gameMaster: boolean;
}

export interface Tale extends Object {
    name: string;
    langs: { [key in Lang]?: { [key: string]: string } };
    langName: { [key in Lang]?: string };
    humanPlayersTeam: number;
    world: World;
    players: { [key: string]: Player };
    events: { [key: string]: Event };
    dialogs: { [key: string]: Dialog };
    units: { [key: string]: Unit };
}

export interface Event extends Object {
    name: string;
    triggers: Array<Trigger>;
}

export interface Trigger extends Object {
    event: Call;
    action: Call;
}

export interface Dialog extends Object {
    name: string;
    image: Call;
}

export interface Call extends Object {
    name: string;
    arguments: Array<any>;
}

export interface TaleCreateEnvelope extends Object {
    authorEmail: string;
    tale: TaleInnerEnvelope;
    lobby: LobbyTale;
}

export interface TaleCompiled extends Object {
    authorEmail: string;
    tale: TaleInnerCompiled;
    lobby: LobbyTale;
}

export interface TaleInnerEnvelope extends Object {
    name: string;
    langName: { [key in Lang]?: string };
    langs: { [key in Lang]?: { [key: string]: string } };
    taleVersion: number;
    world: WorldCreateEnvelope;
    aiGroups: { [key: string]: AiGroup };
    events: { [key: string]: Event };
    dialogs: { [key: string]: Dialog };
    units: { [key: string]: string };
}

export interface TaleInnerCompiled extends Object {
    name: string;
    langs: { [key in Lang]?: { [key: string]: string } };
    langName: { [key in Lang]?: string };
    taleVersion: number;
    world: WorldCreateEnvelope;
    aiGroups: { [key: string]: AiGroup };
    events: { [key: string]: Event };
    dialogs: { [key: string]: Dialog };
    units: { [key: string]: string };
    assets: TaleCompiledAssets;
}

export interface TaleCompiledAssets extends Object {
    images: { [key: string]: Image };
    unitTypes: { [key: string]: UnitTypeCompiled };
}

export interface AiGroup extends Object {
    id: string;
    name: { [key in Lang]?: string };
    team: string;
    color: string;
}

export interface LobbyTale extends Object {
    id: string;
    name: { [key in Lang]?: string };
    description: { [key in Lang]?: string };
    image: Image;
}

export interface OpenedLobby extends LobbyTale {
    lobbyName: string;
    players: Array<Player>;
}

export type Lang = 'en' | 'cz';

export interface Buff extends Object {
    speedDelta: number;
    armorDelta: number;
    rangeDelta: number;
    healthDelta: number;
    attackDelta: Array<number>;
    extraTags: any;
    bannedTags: any;
    expiration: number;
    buffType: string;
    stackStrength: number;
    doesNotStackWith: Array<string>;
}

export type GameNavigationState =
    | 'findLobby'
    | 'createGame'
    | 'inGame'
    | 'loading'
    | 'inLobby';

export type OnClientAction =
    | 'setNavigationState'
    | 'refreshLobbyList'
    | 'getGamesToCreate'
    | 'setCurrentUser'
    | 'openedLobbyData'
    | 'taleData'
    | 'taleStateUpdate'
    | 'intentionUpdate';

export type OnServerAction =
    | 'goToState'
    | 'init'
    | 'createLobby'
    | 'enterLobby'
    | 'enterGame'
    | 'playerGameAction'
    | 'playerGameIntention';

export type Targets = 'me' | 'own' | 'ally' | 'enemy' | 'corpse' | 'empty';

export type TargetModificators = 'wounded' | 'notUndead' | 'undead';

export type AbilityNames =
    | 'move'
    | 'attack'
    | 'shoot'
    | 'heal'
    | 'revive'
    | 'hand_heal'
    | 'boost'
    | 'linked_move'
    | 'step_shoot'
    | 'light'
    | 'summon'
    | 'dismiss'
    | 'change_type'
    | 'regeneration'
    | 'dark_shoot'
    | 'teleport'
    | 'raise';

export interface AbilitiesEnvelope extends Object {
    // annotation @TypescriptOptional() → TypescriptOptional
    move?: MoveAbilityEnvelope;
    // annotation @TypescriptOptional() → TypescriptOptional
    attack?: AttackAbilityEnvelope;
}

export interface Ability extends Object {
    name: string;
    image: string;
    targets: { [key in Targets]?: Array<TargetModificators> };
    invoker: Unit;
}

export interface MoveAbilityEnvelope extends Object {
    // annotation @TypescriptOptional() → TypescriptOptional
    steps?: string;
}

export interface AttackAbilityEnvelope extends Object {
    // annotation @TypescriptOptional() → TypescriptOptional
    range?: string;
    // annotation @TypescriptOptional() → TypescriptOptional
    attack?: string;
}
