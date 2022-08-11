.pragma library

// Prettified stringify
// TODO: I do not think i need this
function prettyStringify(obj) {
    const replacer = (key, val) => (val.toFixed ? Number(val.toFixed(4)) : val);
    return JSON.stringify(obj, replacer, 2);
}
