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
    | 'taleBottomScreen'

export interface Image {
    id: string
    data: string
    multiply: number
    width: number
    height: number
    top: number
    left: number
    name: string
    type: ImageType
    authorEmail: string
    dataModelVersion: number
    origin: string
    created: string
    tags: Array<string>
}

export interface User {
    id: string
    name: string
}

export type UnitTypeTag = 'undead' | 'ethernal' | 'mechanic'

export interface UnitTypeEnvelope {
    id: string
    authorEmail: string
    created: string
    race: Races
    tags: Array<UnitTypeTag>
    health: number
    armor: number
    speed: number
    range: number
    actions: number
    attack: string
    cost: number
    abilities: Array<AbilityEnvelope>
    imageId: string
    unitTypeName: { [key in Lang]?: string }
}

export type Races = 'human' | 'undead' | 'gultam' | 'elf' | 'animal'

export interface Race {
    id: Races
    name: { [key in Lang]?: string }
}

export type Terrain = 'grass' | 'rock' | 'water' | 'forest'

export interface FieldCreateEnvelope {
    id: string
    terrainId: number
    x: number
    y: number
}

export interface WorldCreateEnvelope {
    width: number
    height: number
    baseTerrainId: Terrain
    fields: { [key: string]: FieldCreateEnvelope }
    startField: string
}

export type PlayerHandler = 'firstHuman' | 'ai' | 'passive' | 'everyHuman'

export interface Player {
    id: string
    name: { [key in Lang]?: string }
    team: string
    handler: PlayerHandler
    color: string
}

export interface Event {
    name: string
    triggers: Array<Trigger>
}

export interface Trigger {
    event: Call
    action: Call
}

export interface Dialog {
    name: string
    image: Call
}

export interface Call {
    name: string
    arguments: Array<any>
}

export interface TaleCreateEnvelope {
    authorEmail: string
    tale: TaleInnerEnvelope
    lobby: LobbyTale
    taleDataVersion: number
}

export interface TaleInnerEnvelope {
    id: string
    langs: { [key in Lang]?: { [key: string]: string } }
    taleVersion: number
    world: WorldCreateEnvelope
    players: { [key: string]: Player }
    events: { [key: string]: Event }
    dialogs: { [key: string]: Dialog }
    units: { [key: string]: string }
}

export interface LobbyTale {
    id: string
    name: { [key in Lang]?: string }
    description: { [key in Lang]?: string }
    image: string
}

export type Lang = 'en' | 'cz'

export type Abilities =
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
    | 'raise'

export interface AbilityEnvelope {
    id: Abilities
    modifications: { [key: string]: any }
}
