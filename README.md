# react-native-airplay-btn
AirPlay library for iOS

## Installation with Automatic Linking
```js
npm i react-native-reaction-airplay --save
react-native link
```

### How to create listeners

```js
import { AirPlayListener } from 'react-native-reaction-airplay';

this.airPlayAvailable = AirPlayListener.addListener('airplayAvailable', devices => this.setState({
      airPlayAvailable: devices.available,
})); --> returns a boolean

this.airPlayConnected = AirPlayListener.addListener('airplayConnected', devices => this.setState({
      airPlayConnected: devices.connected,
})); --> returns a boolean


// Remove Listeners in componentWillUnmount
this.airPlayConnected.remove();
this.airPlayAvailable.remove()

```

## Methods

```js
  AirPlay.startScan();
  
  AirPlay.disconnect();

  // show window for select cast-receiver without button, programmatically
  AirPlay.showVolume()
```

### Create AirPlay Button

```js
import { AirPlayButton } from 'react-native-reaction-airplay';

<Button style={{ height: 30, width: 30, justifyContent: 'center', alignItems:'center' }} />
```

Note: The AirPlay Button does not show in the simulator


## Author

Reaction Club 
