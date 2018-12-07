import {Uri} from '../shared/lib/configuration/configuration';

export function makeAddress(uri: Uri, secured: boolean = false) {
    return (secured?'https':'http')+ '://' + uri.host + ':' + uri.port + '/';
}