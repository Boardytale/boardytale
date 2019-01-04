import * as fs from 'fs';
import * as path from 'path';

const walkSync = (dir) => {
    const files = fs.readdirSync(dir);
    for (const file of files) {
        const dirFile = path.join(dir, file);
        const dirent = fs.statSync(dirFile);
        if (dirent.isDirectory()) {
            console.log('directory', path.join(dir, file));
            walkSync(dirFile);
        } else {
            if(file !== 'generate-jsons.ts'){
                console.log('file', dirFile);
                if( file.substr(file.length - 3)=== '.ts'){
                    import('./' + dirFile).then((imageFile: any) => {
                        fs.writeFileSync(path.join(dir,file.substr(0,file.length - 3) + '.json'), JSON.stringify(imageFile.image));
                    });
                }
            }
        }
    }
};

walkSync('./');
