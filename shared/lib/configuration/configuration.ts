// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// TypescriptGenerator
// **************************************************************************

export interface Uri {
          host: string;
port: number;
       }

export interface DatabaseConfiguration {
          username: string;
password: string;
host: string;
port: number;
databaseName: string;
       }

export interface ServerConfiguration {
          uris: Array<Uri>;
route: string;
innerRoute: string;
pathToExecutable: string;
pathToWorkingDirectory: string;
executableType: ExecutableType;
       }

export interface FrontEndDevelopment {
          active: boolean;
port: number;
route: string;
       }

export interface BoardytaleConfiguration {
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

export type ExecutableType = 'ts-node'|'js'|'dart'
