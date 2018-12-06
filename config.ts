// export type UriString = string;

export interface DatabaseConfiguration {
    username: string;
    password: string;
    host: string;
    port: number;
    databaseName: string;
}

export interface ServerConfiguration {
    // use load balancing (uris) if uri is null
    uri: string;
    uris?: string[];
    // route is not used if there is not public api
    route?: string;
    innerRoute?: string;
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
