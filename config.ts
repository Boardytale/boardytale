export type UriString = string;

export interface DatabaseConfiguration {
    username: string;
    password: string;
    host: string;
    port: number;
}

export interface ServerConfiguration {
    // use load balancing (uris) if uri is null
    uri: UriString;
    uris?: UriString[];
    // route is not used if there is not public api
    route?: string;
    innerRoute?: string;
}

export interface FrontEndDevelopment {
    active: boolean;
    route: string;
    proxyPass: UriString;
}

export interface BoardytaleConfiguration {
    gameServer: ServerConfiguration;
    editorServer: ServerConfiguration;
    userService: ServerConfiguration;
    aiService: ServerConfiguration;
    database: DatabaseConfiguration;
    gameStaticDev: FrontEndDevelopment;
    editorStaticDev: FrontEndDevelopment;
}
