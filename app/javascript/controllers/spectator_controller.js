import { Controller } from "stimulus"
import consumer from "../channels/consumer"

export default class extends Controller {
  initialize() {
    var that = this;
    this.socket = consumer.subscriptions.create({ channel: "SpectatorChannel", id: this.data.get("id") }, {
      connected() {
        that.unityInstance = UnityLoader.instantiate("webgl-target", "/unityweb/Build/webgl_test_010.json", { onProgress: UnityProgress });
      },
      received(data) {
        that.sendDataToWebGL(data["parameter"]);
      }
    });
  }

  connect() {
    this.element[this.identifier] = this;
  }

  sendDataToWebGL(data) {
    // document.getElementsByClassName("webgl-content")[0].spectator.sendDataToWebGL()
    // Send the received Data from VR-Player inside all Unity-WebGL-Apps of Channel Subscriptions (Spectators)
    var jsonData = JSON.parse(data);
    console.log("Sednding to WebGL: " + JSON.stringify(jsonData));
    this.unityInstance.SendMessage("BrowserCommunicator", "Message", JSON.stringify(jsonData));
  }
}
