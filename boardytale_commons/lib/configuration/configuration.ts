// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// TodoReporterGenerator
// **************************************************************************

export interface DatabaseConfiguration {
          username: string;
password: string;
host: string;
port: number;
databaseName: string;

       }

export interface ServerConfiguration {
          uri: string;
uris: Array<any>;
route: string;
innerRoute: string;

       }

export interface FrontEndDevelopment {
          active: boolean;
route: string;
proxyPass: string;

       }

export interface BoardytaleConfiguration {
          gameServer: ServerConfiguration;
editorServer: ServerConfiguration;
editorDatabase: DatabaseConfiguration;
userService: ServerConfiguration;
userDatabase: DatabaseConfiguration;
aiService: ServerConfiguration;
gameStaticDev: FrontEndDevelopment;
editorStaticDev: FrontEndDevelopment;

       }
