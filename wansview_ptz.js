#!/usr/bin/env node

const onvif = require('node-onvif');
var myArgs = process.argv.slice(2);

var user = (myArgs[0]);
var pass = (myArgs[1]);
var host = (myArgs[2]);
var port = (myArgs[3]);
var xx = parseFloat(myArgs[4]);
var yy = parseFloat(myArgs[5]);

let device = new onvif.OnvifDevice({
	xaddr: 'http://' + host + ':' + port + '/onvif/device_service',
	user : user,
	pass : pass
});

device.init().then(() => {

	let params = {
		'speed': {x: xx, y: yy, z: 0.0},
		'timeout': 60 // seconds
	};
	// Supposed to move the camera for 60 seconds
	device.ptzMove(params).then((result) => {
	  	console.log('Succeeded to move.');
	  	setTimeout(() => {
	    device.ptzStop().then((result) => {
	     	console.log('Succeeded to stop.');
	    }).catch((error) => {
	     	console.error(error);
	    });
		}, 500);
	}).catch((error) => {
		console.error(error);
	});
});
