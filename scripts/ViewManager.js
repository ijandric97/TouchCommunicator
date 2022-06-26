.pragma library

// Predefined paths to respective qml view files
const SELECTOR_FILE = "views/selector.qml";
const COMMUNICATOR_FILE = "views/communicator.qml";
const SETTINGS_FILE = "views/settings.qml";

// We will set the selector as initial view
const DEFAULT_FILE = SELECTOR_FILE;

// The bound loader var, has to be set in loaders onLoaded method
let loader = null;
const setLoader = (self) => {
    loader = self;
}

// Methods to switch the views (math.random is to prevent caching, since qml is really a web browser)
const switchToSelector = () => loader.source = SELECTOR_FILE + "?" + Math.random();
const switchToCommunicator = () => loader.source = COMMUNICATOR_FILE + "?" + Math.random();
const switchToSettings = () => loader.source = SETTINGS_FILE + "?" + Math.random();
