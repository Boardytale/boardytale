export type UriString = string;

export interface DatabaseConfiguration {
    username: string;
    password: string;
    host: string;
    port: number;
}

export interface BoardytaleConfiguration {
    gameServers: UriString[];
    editorServers: UriString[];
    userService: UriString;
    heroService: UriString;
    aiService: UriString[];
    database: DatabaseConfiguration;
}
