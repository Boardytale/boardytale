// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// TypescriptGenerator
// **************************************************************************

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

export type ImageType =
    | 'field'
    | 'unitIcon'
    | 'unitBase'
    | 'unitHighRes'
    | 'item'
    | 'taleFullScreen'
    | 'taleBottomScreen'

export interface User {
    id: string
    name: string
}

export interface FieldCreateEnvelope {
    id: string
    terrainId: number
    x: number
    y: number
}

export type Terrain = 'grass' | 'rock' | 'water' | 'forest'

export interface WorldCreateEnvelope {
    width: number
    height: number
    baseTerrainId: Terrain
    fields: { [key: string]: FieldCreateEnvelope }
    startField: string
}

export interface Player {
    id: string
    name: { [key in Lang]?: string }
    team: string
    handler: PlayerHandler
    color: string
}

export type PlayerHandler = 'firstHuman' | 'ai' | 'passive' | 'everyHuman'

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
