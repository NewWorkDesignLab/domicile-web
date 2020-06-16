import { Controller } from "stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  initialize() {
    this.socket = consumer.subscriptions.create({ channel: "SpectatorChannel", id: this.data.get("id") }, {
      connected() {
        this.unityInstance = UnityLoader.instantiate("webgl-target", "/unityweb/Build/webgl_test_002.json", { onProgress: UnityProgress });
      },
      received(data) {
        this.sendDataToWebGL(data);
      }
    });
  }

  connect() {
    this.element[this.identifier] = this;
  }

  sendDataToWebGL(data) {
    // document.getElementsByClassName("webgl-content")[0].spectator.sendDataToWebGL()
    // Send the received Data from VR-Player inside all Unity-WebGL-Apps of Channel Subscriptions (Spectators)
    this.unityInstance.SendMessage("BrowserCommunicator", "Message", data);
  }
}
