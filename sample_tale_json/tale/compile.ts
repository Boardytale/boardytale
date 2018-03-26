import * as fs from 'fs';
import {tale} from './tale';

fs.writeFileSync('compiled.json', JSON.stringify(tale));
