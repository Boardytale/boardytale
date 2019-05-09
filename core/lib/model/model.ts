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
    width: number;
    height: number;
    type: ImageType;
    authorEmail: string;
    imageVersion: number;
    dataModelVersion: number;
    created: string;
    tags: Array<ImageTag>;
    origin: string;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    multiply?: number;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    top?: number;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    left?: number;
}

export interface User extends Object {
    name: string;
    email: string;
    innerToken: string;
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

export interface Triggers extends Object {
    onInit: Array<Trigger>;
    onUnitDies: Array<UnitTrigger>;
}

export interface Trigger extends Object {
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    // annotation @TypescriptOptional() → TypescriptOptional
    condition?: Condition;
    action: Action;
}

export interface UnitTrigger extends Object {
    // annotation @TypescriptOptional() → TypescriptOptional
    condition?: Condition;
    action: Action;
}

export interface Condition extends Object {
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    andCondition?: AndCondition;
}

export interface AndCondition extends Object {
    condition1: Condition;
    condition2: Condition;
}

export interface EqualCondition extends Object {
    value: string;
    equalsTo: any;
}

export interface Action extends Object {
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    unitAction?: UnitCreateOrUpdateAction;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    victoryCheckAction?: VictoryCheckAction;
}

export interface VictoryCheckAction extends Object {
    allTeamsEliminatedForWin: Array<string>;
    anyOfTeamsEliminatedForWin: Array<string>;
    anyOfTeamsEliminatedForLost: Array<string>;
    allOfTeamsEliminatedForLost: Array<string>;
    unitsEliminatedForLost: Array<string>;
}

export type AiAction =
    | 'attackAllOnRoad'
    | 'attackAllNearTarget'
    | 'attack'
    | 'move';

export interface AiInstruction extends Object {
    unitAction: UnitCreateOrUpdateAction;
}

export interface AiInstructionSetUnitTarget extends Object {
    unitTaleId: string;
    actionOnTarget: AiAction;
}

export type Races = 'human' | 'undead' | 'gultam' | 'elf' | 'animal' | 'dragon';

export interface Race extends Object {
    id: Races;
    name: { [key in Lang]?: string };
}

export type AiEngine = 'passive' | 'standard' | 'panic';

export interface Player extends Object {
    // annotation @TypescriptOptional() → TypescriptOptional
    id?: string;
    taleId: string;
    team: string;
    color: string;
    // annotation @TypescriptOptional() → TypescriptOptional
    humanPlayer?: HumanPlayer;
    // annotation @TypescriptOptional() → TypescriptOptional
    aiGroup?: AiGroup;
}

export interface HumanPlayer extends Object {
    name: string;
    isGameMaster: boolean;
    portrait: Image;
}

export interface AiGroup extends Object {
    langName: { [key in Lang]?: string };
    aiEngine: AiEngine;
}

export type AnimationName = 'move';

export type ActionExplanation = 'unitAttacking' | 'unitGotDamage';

export interface UnitCreateOrUpdateAction extends Object {
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    unitId?: string;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    actionId?: string;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    far?: number;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    steps?: number;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    health?: number;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    buffs?: Array<Buff>;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    actions?: number;
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    changeToTypeName: string;
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    moveToFieldId: string;
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    transferToPlayerId: string;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    useAnimationName?: AnimationName;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    diceNumbers?: Array<number>;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    explain?: ActionExplanation;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    explainFirstValue?: string;
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

export interface UnitTypeCompiled extends UnitTypeCommons {
    abilities: AbilitiesEnvelope;
    authorEmail: string;
    image: Image;
    icon: Image;
    bigImage: Image;
}

export interface UnitType extends UnitTypeCommons {
    imageName: string;
    iconName: string;
    bigImageName: string;
    abilities: AbilitiesEnvelope;
}

export interface UnitTypeCreateEnvelope extends UnitType {
    authorEmail: string;
    created: string;
}

export type Terrain = 'grass' | 'rock' | 'water' | 'forest';

export interface FieldCreateEnvelope extends Object {
    terrain: Terrain;
}

export interface World extends Object {
    width: number;
    height: number;
    baseTerrain: Terrain;
    fields: { [key: string]: FieldCreateEnvelope };
    startingFieldIds: Array<string>;
}

export interface Assets extends Object {
    images: { [key: string]: Image };
}

export interface Event extends Object {
    name: string;
    triggers: Array<Trigger>;
}

export interface Dialog extends Object {
    name: string;
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
    world: World;
    aiPlayers: { [key: string]: Player };
    events: { [key: string]: Event };
    dialogs: { [key: string]: Dialog };
    units: Array<UnitCreateOrUpdateAction>;
    humanPlayerIds: Array<string>;
    taleAttributes: { [key: string]: any };
    triggers: Triggers;
}

export interface TaleInnerCompiled extends Object {
    name: string;
    langs: { [key in Lang]?: { [key: string]: string } };
    langName: { [key in Lang]?: string };
    taleVersion: number;
    world: World;
    aiPlayers: { [key: string]: Player };
    events: { [key: string]: Event };
    dialogs: { [key: string]: Dialog };
    units: Array<UnitCreateOrUpdateAction>;
    humanPlayerIds: Array<string>;
    images: { [key: string]: Image };
    unitTypes: { [key: string]: UnitTypeCompiled };
    triggers: Triggers;
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
    | 'unitCreateOrUpdate'
    | 'unitDelete'
    | 'cancelOnField'
    | 'intentionUpdate'
    | 'playersOnMove'
    | 'addUnitType'
    | 'showBanter';

export type OnServerAction =
    | 'goToState'
    | 'init'
    | 'createLobby'
    | 'enterLobby'
    | 'enterGame'
    | 'leaveGame'
    | 'unitTrackAction'
    | 'playerGameIntention'
    | 'controlsAction';

export type ControlsActionName = 'endOfTurn' | 'unitWillNotPlay';

export type OnHeroServerAction = 'getHeroesOfPlayer';

export type OnAiServerAction = 'getNextMoveByState' | 'getNextMoveByUpdate';

export type OnUserServerAction = 'getUseresByInnerToken';

export type LoggerMessageType = 'initial' | 'taleUpdate';

export type Targets = 'me' | 'own' | 'ally' | 'enemy' | 'corpse' | 'empty';

export type TargetModificators = 'wounded' | 'notUndead' | 'undead';

export type AbilityReach =
    | 'mineTurnStart'
    | 'reachMove'
    | 'reachHand'
    | 'reachArrow'
    | 'reachConjuration';

export type AbilityName =
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
    // annotation @TypescriptOptional() → TypescriptOptional
    shoot?: ShootAbilityEnvelope;
}

export interface MoveAbilityEnvelope extends Object {
    // annotation @TypescriptOptional() → TypescriptOptional
    steps?: string;
}

export interface AttackAbilityEnvelope extends Object {
    // annotation @TypescriptOptional() → TypescriptOptional
    steps?: string;
    // annotation @TypescriptOptional() → TypescriptOptional
    attack?: string;
}

export interface ShootAbilityEnvelope extends Object {
    // annotation @TypescriptOptional() → TypescriptOptional
    steps?: number;
    // annotation @TypescriptOptional() → TypescriptOptional
    attack?: string;
}
