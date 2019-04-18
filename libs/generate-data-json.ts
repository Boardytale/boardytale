console.log("start:");
import(process.argv[2]).then((file: any) => {
    if (!file.data) {
        return;
    }
    console.log(JSON.stringify(file.data));
    process.exit(1);
});
