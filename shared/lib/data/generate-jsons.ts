import * as fs from 'fs';
import * as path from 'path';

const walkSync = dir => {
    const files = fs.readdirSync(dir);
    for (const file of files) {
        const dirFile = path.join(dir, file);
        const dirent = fs.statSync(dirFile);
        if (dirent.isDirectory()) {
            console.log('directory', path.join(dir, file));
            walkSync(dirFile);
        } else {
            if (file !== 'generate-jsons.ts') {
                console.log('file', dirFile);
                if (file.substr(file.length - 3) === '.ts') {
                    import('./' + dirFile).then((imageFile: any) => {
                        fs.writeFileSync(
                            path.join(
                                dir,
                                file.substr(0, file.length - 3) + '.json'
                            ),
                            JSON.stringify(imageFile.data)
                        );
                    });
                }
                ['png', 'jpg', 'jpeg'].forEach(imageExt => {
                    if (
                        file.substr(file.length - imageExt.length - 1) ===
                        '.' + imageExt
                    ) {
                        const imageAsBase64 = fs.readFileSync(
                            './' + dirFile,
                            'base64'
                        );
                        fs.writeFileSync(
                            path.join(
                                dir,
                                file.substr(
                                    0,
                                    file.length - imageExt.length - 1
                                ) + '.base64'
                            ),
                            'data:image/' +
                                imageExt +
                                ';base64,' +
                                imageAsBase64
                        );
                    }
                });
            }
        }
    }
};

walkSync('./');
