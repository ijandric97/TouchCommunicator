.pragma library

// Prettified stringify
// TODO: I do not think i need this
function prettyStringify(obj) {
    const replacer = (key, val) => (val.toFixed ? Number(val.toFixed(4)) : val);
    return JSON.stringify(obj, replacer, 2);
}

function qByteArrayToString(qByteArray) {
    let response = new Uint8Array(qByteArray);
    let raw = "";
    for (let i = 0; i < response.byteLength; i++) {
        raw += String.fromCharCode(response[i]);
    }
    return raw;
}
