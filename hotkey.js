const robot = require("robotjs");
const iohook = require("iohook");
const express = require('express');

const bodyParser = require('body-parser');
const app = express();
app.use(bodyParser.json());


let isMoving = false;

app.listen(() => {

    // Register hotkeys
    iohook.registerShortcut([62], startMoving); // F6 to start
    iohook.registerShortcut([63], stopMoving);  // F7 to stop

    console.log("Press F6 to start moving, F7 to stop.");
    iohook.start();

});

function startMoving() {
    if (!isMoving) {
        isMoving = true;
        console.log("Movement started");
        robot.keyToggle("w", "down"); // Hold W to move forward
    }
}

function stopMoving() {
    if (isMoving) {
        isMoving = false;
        console.log("Movement stopped");
        robot.keyToggle("w", "up"); // Release W to stop moving
    }
}

