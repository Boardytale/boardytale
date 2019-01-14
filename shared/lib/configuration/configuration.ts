// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// TypescriptGenerator
// **************************************************************************

export type ExecutableType = 'ts-node' | 'js' | 'dart';

export interface Uri extends Object {
    host: string;
    port: number;
}

export interface DatabaseConfiguration extends Object {
    username: string;
    password: string;
    host: string;
    port: number;
    databaseName: string;
}

export interface ServerConfiguration extends Object {
    uris: Array<Uri>;
    route: string;
    innerRoute: string;
    pathToExecutable: string;
    pathToWorkingDirectory: string;
    executableType: ExecutableType;
}

export interface FrontEndDevelopment extends Object {
    active: boolean;
    port: number;
    route: string;
}

export interface BoardytaleConfiguration extends Object {
    gameServer: ServerConfiguration;
    editorServer: ServerConfiguration;
    userDatabase: DatabaseConfiguration;
    editorDatabase: DatabaseConfiguration;
    userServer: ServerConfiguration;
    heroesServer: ServerConfiguration;
    aiServer: ServerConfiguration;
    proxyServer: ServerConfiguration;
    gameStaticDev: FrontEndDevelopment;
    editorStaticDev: FrontEndDevelopment;
}
