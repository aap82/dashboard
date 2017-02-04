
exports.sendCommand = (platform, device, command) =>   fetch('/commands/' + platform +  '/' + device +  '/' + command).then(-> return)