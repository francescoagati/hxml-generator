import haxe.macro.Expr;
import Hxml;
using HxmlTools;

class HxmlTools {


  public inline static function set_name(hxml:Hxml,name:String) {
    hxml.name = name;
    return hxml;
  }


  public inline static function set_main(hxml:Hxml,main:String) {
    hxml.main = main;
    return hxml;
  }

  public inline static function set_dce(hxml:Hxml,dce:String) {
    hxml.dce = dce;
    return hxml;
  }

  public inline static function set_cp(hxml:Hxml,cp:String) {
    hxml.cp = cp;
    return hxml;
  }

  public inline static function set_target(hxml:Hxml,target:Target) {
    hxml.target = target;
    return hxml;
  }

  public inline static function add_flag(hxml:Hxml,flag:Flag) {
    hxml.flags + flag;
    return hxml;
  }

  public inline static function add_lib(hxml:Hxml,lib:String) {
    hxml.libs.push(lib);
    return hxml;
  }

  public inline static function add_libs(hxml:Hxml,libs:Array<String>) {
    for (lib in libs) hxml.add_lib(lib);
    return hxml;
  }

  public inline static function to_hxml(name:String):Hxml {
    return {name:name,libs:[],flags:[]};
  }

}
