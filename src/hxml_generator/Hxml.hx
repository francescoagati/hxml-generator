package hxml_generator;

using StringTools;

enum Target {
  js(path:String);
  php(path:String);
  java(path:String);
  cs(path:String);
  python(path:String);
  as3(path:String);
  swf(path:String);
  cpp(path:String);
  neko(path:String);
}


enum Flag {
  value(key:String,?value:String);
}

typedef Project = {
  ?flags:Container,
  ?libs:Container,
  ?main:String,
  name:String,
  ?target:Target,
  ?cp:String,
  ?cmd:String,
  ?dce:String,
  ?no_traces:Bool
}



@:forward
abstract Container(Array<String>) from Array<String> to Array<String> {
  public inline function new(container) this = container;

  @:op(A+B) public inline function addFromArray(lst:Array<String>) {
    for (el in lst) this.push(el);
    return new Container(this);
  }

  @:op(A+B) public inline function addFromString(s:String) {
    this.push(s);
    return new Container(this);
  }

  @:op(A+B) public inline function addFromFlag(flg:Flag) {

    switch(flg) {
    case value(key,value):
      if (value == null) this.push(key);
      else this.push('$key=$value');
    case _:null;
    }

    return new Container(this);
  }

  @:to public inline function toString():String return this.join(" ");

}


@:forward
abstract HxmlRender(Hxml) from Hxml to Hxml {
  public inline function new(hxml) this = hxml;

  public inline function write_main() return if (this.main != null) '-main ${this.main}' else null;
  public inline function write_cp() return if (this.cp != null) '-cp ${this.cp}' else null;
  public inline function write_dce() return if (this.dce != null) '-dce ${this.dce}' else null;
  public inline function write_cmd() return if (this.cmd != null) '-cmd ${this.cmd}' else null;

  public inline function write_no_traces() return
    if (this.no_traces != null && this.no_traces == true) '-no-traces' else null;


  public inline function write_flags() {
    return if (this.flags != null && this.flags.length > 0) {

      [for (flag in this.flags) {
        '-D $flag';
      }].join("\n");
    } else null;
  }



  public inline function write_libs()
    return if (this.libs != null && this.libs.length > 0) '-lib ${(this.libs:String)}' else null;

  public inline function write_target() {
    return if (this.target != null) {
        switch(this.target) {
        case cpp(path):'-cpp $path';
        case swf(path):'-swf $path';
        case python(path):'-python $path';
        case php(path):'-php $path';
        case java(path):'-java $path';
        case neko(path):'-neko $path';
        case js(path):'-js $path';
        case cs(path):'-cs $path';
        case as3(path):'-as3 $path';
        case _:null;
      }
    } else return null;
  }


}

@:forward
abstract Hxml(Project) from Project to Project {
  public inline function new(project) this = project;

  public inline function clone():Hxml
    return new Hxml(untyped haxe.Json.parse(haxe.Json.stringify(this)));

  @:to public inline function toString():String  {

    inline function cleanup(s:String){
      return [for (row in s.split("\n")) if (row.indexOf('null') == -1) row ].join("\n");
    }

    var render:HxmlRender = this;
    var file = '${render.write_main()}
${render.write_target()}
${render.write_dce()}
${render.write_cp()}
${render.write_cmd()}
${render.write_flags()}
${render.write_libs()}
${render.write_no_traces()}

';

    return cleanup(file);

  }

  public inline function writeFile(path:String) {
    var file:String = new Hxml(this);
    sys.io.File.saveContent(path,file);
  }

}
