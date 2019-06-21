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
    hasHero: boolean;
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
    onAfterGameStarted: Array<Trigger>;
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
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    showBanterAction?: ShowBanterAction;
}

export interface VictoryCheckAction extends Object {
    allTeamsEliminatedForWin: Array<string>;
    anyOfTeamsEliminatedForWin: Array<string>;
    anyOfTeamsEliminatedForLost: Array<string>;
    allOfTeamsEliminatedForLost: Array<string>;
    unitsEliminatedForLost: Array<string>;
}

export interface ShowBanterAction extends Object {
    title: { [key in Lang]?: string };
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    text?: { [key in Lang]?: string };
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    image?: Image;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    showTimeInMilliseconds?: number;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    speakingUnitId?: string;
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

export type ActionExplanation =
    | 'unitAttacking'
    | 'unitGotDamage'
    | 'unitHealing'
    | 'unitHealed';

export interface UnitCreateOrUpdateAction extends Object {
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    unitId?: string;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    actionId?: string;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    stepsSpent?: number;
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
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    itemDrops?: ItemDrops;
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

export interface UnitTypeEnvelope extends UnitType {
    authorEmail: string;
    created: string;
}

export type Terrain = 'grass' | 'rock' | 'water' | 'forest';

export interface FieldEnvelope extends Object {
    terrain: Terrain;
}

export interface World extends Object {
    width: number;
    height: number;
    baseTerrain: Terrain;
    fields: { [key: string]: FieldEnvelope };
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

export interface TaleEnvelope extends Object {
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
    experienceForHeroes: number;
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
    experienceForHeroes: number;
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
    | 'inLobby'
    | 'userPanel'
    | 'login'
    | 'heroPanel';

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
    | 'addUnitType';

export type OnServerAction =
    | 'goToState'
    | 'init'
    | 'createLobby'
    | 'enterLobby'
    | 'enterGame'
    | 'leaveGame'
    | 'unitTrackAction'
    | 'playerGameIntention'
    | 'controlsAction'
    | 'setHeroForNextGame';

export type ControlsActionName = 'endOfTurn' | 'unitWillNotPlay';

export type OnAiServerAction = 'getNextMoveByState' | 'getNextMoveByUpdate';

export type OnUserServerAction =
    | 'getHeroesToCreate'
    | 'createHero'
    | 'getMyHeroes'
    | 'updateUser'
    | 'getHeroDetail'
    | 'updateHero';

export type OnUserServerInnerAction =
    | 'getUserByInnerToken'
    | 'getStartingUnits'
    | 'setHeroAfterGameGain';

export type LoggerMessageType = 'initial' | 'taleUpdate' | 'trace';

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
    // annotation @TypescriptOptional() → TypescriptOptional
    heal?: HealAbilityEnvelope;
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

export interface ItemEnvelope extends Object {
    possiblePositions: Array<ItemPosition>;
    // annotation @TypescriptOptional() → TypescriptOptional
    id?: string;
    typeName: string;
    langName: { [key in Lang]?: string };
    mapImageData: string;
    inventoryImageData: string;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    heroId?: string;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    weight?: number;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    armorPoints?: number;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    speedPoints?: number;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    healthBonus?: number;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    manaBonus?: number;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    strengthBonus?: number;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    agilityBonus?: number;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    intelligenceBonus?: number;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    spiritualityBonus?: number;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    energyBonus?: number;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    precisionBonus?: number;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    recommendedPrice?: number;
    sellPrice: number;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    requiredLevel?: number;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    weapon?: WeaponEnvelope;
}

export interface WeaponEnvelope extends Object {
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    requiredStrength?: number;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    requiredAgility?: number;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    requiredIntelligence?: number;
    baseAttack: Array<number>;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    bonusAttack?: Array<number>;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    range?: number;
}

export interface ItemDrops extends Object {
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    maxItemDrops?: number;
    items: Array<ItemDrop>;
}

export interface ItemDrop extends Object {
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    probability?: number;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    byName?: string;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    byItemPriceFrom?: number;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    byItemPriceTo?: number;
}

export type ItemPosition =
    | 'head'
    | 'neck'
    | 'body'
    | 'elbows'
    | 'leftHand'
    | 'rightHand'
    | 'leftWrist'
    | 'rightWrist'
    | 'legs'
    | 'bothHands';

export interface GameHeroEnvelope extends Object {
    // annotation @TypescriptOptional() → TypescriptOptional
    id?: string;
    level: number;
    name: string;
    type: UnitTypeCompiled;
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    // annotation @TypescriptOptional() → TypescriptOptional
    unit?: UnitCreateOrUpdateAction;
}

export interface HeroEnvelope extends Object {
    gameHeroEnvelope: GameHeroEnvelope;
    inventoryItems: Array<ItemEnvelope>;
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    equippedItemNames?: { [key in ItemPosition]?: string };
    // annotation @TypescriptOptional() → TypescriptOptional
    // annotation @JsonKey({Object defaultValue, bool disallowNullValue, bool encodeEmptyCollection, Function fromJson, bool ignore, bool includeIfNull, String name, bool nullable, bool required, Function toJson}) → JsonKey
    equippedItems?: { [key in ItemPosition]?: ItemEnvelope };
    strength: number;
    agility: number;
    intelligence: number;
    precision: number;
    spirituality: number;
    energy: number;
    experience: number;
    money: number;
}

export interface HeroUpdate extends Object {
    heroId: string;
    name: string;
    strength: number;
    agility: number;
    intelligence: number;
    precision: number;
    spirituality: number;
    energy: number;
    pickGainId: number;
    itemManipulations: Array<ItemManipulation>;
    responseHero: HeroEnvelope;
}

export interface ItemManipulation extends Object {
    equipItemId: string;
    equipTo: ItemPosition;
    moveToInventoryItemId: string;
    sellItemId: string;
}

export interface HeroAfterGameGain extends Object {
    id: number;
    xp: number;
    money: number;
    itemTypeNames: Array<string>;
    heroId: string;
}

export interface HealAbilityEnvelope extends Object {
    // annotation @TypescriptOptional() → TypescriptOptional
    steps?: number;
    // annotation @TypescriptOptional() → TypescriptOptional
    effect?: string;
    range: string;
}
