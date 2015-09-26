import Hxml;

class Main {

  static var js_path = 'builds/js';
  static var hxml_path = 'tmp/projects-hxml';


  static function main() {

    var hxml:Hxml = {name:'base',libs:[],flags:[]};

    hxml.libs + 'thx.core' + 'tink_macro';
    hxml.dce = 'full';
    hxml.flags + 'analyzer';
    hxml.main = 'Main';


    var mobile = hxml.clone();
    var desktop = hxml.clone();

    mobile.flags + value('target','mobile');

    var devices = ['ios','ipad','android_chrome','android_webkit','wp','other'];

    var hxml_mobiles = [for (device in devices) {
      var hxml = mobile.clone();
      hxml.name = device;
      hxml.flags + value('device',device);
      hxml.target = js('$js_path/$device.js');
      hxml;
    }];

    for (hxml in hxml_mobiles) hxml.writeFile('tmp/projects-hxml/${hxml.name}.hxml');

    desktop.flags + value('target','desktop');
    desktop.target = js('$js_path/desktop.js');
    desktop.writeFile('tmp/projects-hxml/desktop.hxml');

  }
}
