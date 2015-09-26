import Hxml;
using HxmlTools;
class Main {

  static var js_path = 'builds/js';
  static var hxml_path = 'tmp/projects-hxml';


  static function main() {

    var hxml = 'base'.to_hxml();

    hxml
      .set_dce('full')
      .set_main('Main')
      .add_flag(value('analyzer'))
      .add_libs(['thx.core', 'tink_macro']);

    var mobile = hxml.clone();
    var desktop = hxml.clone();

    mobile.flags + value('target','mobile');

    var devices = ['ios','ipad','android_chrome','android_webkit','wp','other'];

    var hxml_mobiles = [for (device in devices) {
      var hxml = mobile.clone();
      hxml
        .set_name('device')
        .set_target(js('$js_path/$device.js'))
        .add_flag(value('device',device));

      hxml;
    }];

    for (hxml in hxml_mobiles) hxml.writeFile('tmp/projects-hxml/${hxml.name}.hxml');

    desktop
      .add_flag(value('target','desktop'))
      .set_target(js('$js_path/desktop.js'))
      .writeFile('tmp/projects-hxml/desktop.hxml');

  }
}
