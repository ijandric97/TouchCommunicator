.pragma library

// Prettified stringify
// TODO: I do not think i need this
function prettyStringify(obj) {
    const replacer = (key, val) => (val.toFixed ? Number(val.toFixed(4)) : val);
    return JSON.stringify(obj, replacer, 2);
}

/**
 * Convert JS ByteArray to a UTF-16 string
 * @param {Uint8Array} qByteArray JS Byte array
 * @returns {string} UTF-16 string representing the data
 */
function qByteArrayToString(qByteArray) {
    let response = new Uint8Array(qByteArray);
    let raw = "";
    for (let i = 0; i < response.byteLength; i++) {
        raw += String.fromCharCode(response[i]);
    }
    return raw;
}
