class ChannelService {
  constructor() {
    this.loadScript();
  }

  loadScript() {
    var w = window;
    function l() {
      if (w.ntbotInitialized) {
        return;
      }
      w.ntbotInitialized = true;
      var s = document.createElement("script");
      s.type = "text/javascript";
      s.async = true;
      s.src =
        "https://cdn.jsdelivr.net/gh/ImChang-gyu/sdk-deploy-test/plugin41.js";
      s.charset = "UTF-8";
      var x = document.getElementsByTagName("script")[0];
      x.parentNode.insertBefore(s, x);
    }
    if (document.readyState === "complete") {
      l();
    } else if (window.attachEvent) {
      window.attachEvent("onload", l);
    } else {
      window.addEventListener("DOMContentLoaded", l, false);
      window.addEventListener("load", l, false);
    }
  }
}
export default ChannelService;
