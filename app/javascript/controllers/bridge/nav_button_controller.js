import { BridgeComponent } from "@hotwired/strada"

export default class extends BridgeComponent {
  static component = "nav-button";

  connect() {
    super.connect();
    this.notifyBridgeOfConnect();
  }

  notifyBridgeOfConnect() {
    const title = this.bridgeElement.title;
    const position = this.bridgeElement.bridgeAttribute("position");
    const systemIcon = this.bridgeElement.bridgeAttribute("systemIcon");
    const systemName = this.bridgeElement.bridgeAttribute("systemName");

    this.send("connect", { title, position, systemIcon, systemName }, () => {
      this.element.click();
    });
  }
}