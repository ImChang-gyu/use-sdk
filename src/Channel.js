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
      var s = document.createElement('script');
      s.type = 'text/javascript';
      s.async = true;
      s.src =
<<<<<<< HEAD
        "https://cdn.jsdelivr.net/gh/ImChang-gyu/sdk-deploy-test/plugin62.js";
      s.charset = "UTF-8";
      var x = document.getElementsByTagName("script")[0];
=======
        'https://cdn.jsdelivr.net/gh/ImChang-gyu/sdk-deploy-test/plugin61.js';
      s.charset = 'UTF-8';
      var x = document.getElementsByTagName('script')[0];
>>>>>>> 49fd51fde5284c00edfb14635eea6491e3ddf1fe
      x.parentNode.insertBefore(s, x);
    }
    if (document.readyState === 'complete') {
      l();
    } else if (window.attachEvent) {
      window.attachEvent('onload', l);
    } else {
      window.addEventListener('DOMContentLoaded', l, false);
      window.addEventListener('load', l, false);
    }
  }
}
export default ChannelService;
