// da-funk
var $this = typeof this !== 'undefined' ? this : {};
var $module = typeof module !== 'undefined' ? module : {}
var $publish = typeof exports !== 'undefined' ? exports : this;

var impromtu = $publish.impromtu = function(arrangement, aspect, improvisation, opts) {
  "||+<========================================================================================================>||";
  "|||IDEA({                                                                                                   |||";
  "|||  summary: |+| this template code may be visually more appealing if it were to have its own syntax. |+|  |||";
  "|||           |+| parts of this should be parsed with PEGjs or something similar.                      |+|  |||";
  "||+<========================================================================================================>||";

  "||+<======================================================================================================================================>||";
  "|||^((((((((((((((((((((((((((((((((((((((((%%                                                                                            |||";
  "|||                                                (({ name:     |+| impromtu |+|  }))                                                    |||";
  "|||                                                (({ version:  |+| 0.1.0    |+|  }))                                                    |||";
  "|||                                                (({ strict:   |+| true     |+|  }))                                                    |||";
  "|||                                                                                        %%)))))))))))))))))))))))))))))))))))))))))    |||";
  "|||                                                                                                                                       |||";
  "|||@(   BEHOLD('it allows impromtu access to an `aspect` of `arrangement`. if the aspect is't ready ret, `improvisation` is called.')   )@|||";
  "|||                                                                                                                                       |||";
  "||| da.funk.needs.additional(arrangement)                                                                                                 |||";
  "|||         .which.isAn.object().behold('it accepts a generic object to which you'd like to define this aspect.')                         |||";
  "|||          .orPerhapsAn.object(Arrangement)                                                                                             |||";
  "|||           .behold('`Arrangement` is for all those awesome compositons you're puttin together.'                                        |||";
  "|||         .orPerhapsAn.object(Composition)                                                                                              |||";
  "|||          .behold('yeah, that's team work! - heh, ok - a collaboration. :) ')                                                          |||";
  "|||                                                                                                                                       |||";
  "||| da.funk.needs.additional(aspect)                                                                                                      |||";
  "|||         .which.isA.string()                                                                                                           |||";
  "|||          .behold('it is the object's property that you define lazily')                                                                |||";
  "|||                                                                                                                                       |||";
  "||| da.funk.needs.additional(improvisation)                                                                                               |||";
  "|||         .which.isA.function()                                                                                                         |||";
  "|||          .orPerhapsSome.funk({origin: 'xxx'})                                                                                         |||";
  "|||           .behold('it Arrangement is for all those awesome compositons you're puttin together.')                                      |||";
  "|||                                                                                                                                       |||";
  "|<======================================================================================================================================='>||";
  "+--------------------------------+";
  "| # arrangement                  |";
  "| # aspect                       |";
  "| # improvisation                |";
  "+--------------------------------+";

  if(typeof arrangement[aspect] !== 'undefined') {
    arrangement['$'+aspect] = arrangement.published
  } else if(typeof arrangement.$published === 'undefined') {
    arrangement.$published = {}
  }
  // CHECK THIS: if we assume that we
  "|||%realize ";
  console.log(arrangement, aspect)
  Object.defineProperty(arrangement, aspect, {
    configurable: false,
    writable: true,
    get: function() {
      try {
        if(arrangement.$published[aspect] === void(8)) {
          arrangement.$published[aspect] = fallback.call(null);
        // } else {
        //   console.log(aspect+": already have...", typeof arrangement.$published[aspect])
        }
      } catch (err) {
        console.log("a weird error occured. this shouldn't happen:", err.stack)
      }
      if(!arrangement.$published[aspect]) throw new Error("wtf? - #{src_path}");
      return arrangement.$published[aspect];
    }
  })
}




var Path = require('path')
var Promise = require('bluebird')
var Fs = Promise.promisifyAll(require('fs'))

impromtu($module, 'package', function() {
  console.log("getting $module.package")
  return require(__dirname+'/package.json')
});

impromtu($module, 'funk', function() {
  console.log("getting $module.funk")
  if($module.$funk === void(8)) {
    if(!($module.$funk = $module.package['da-funk'])) {
      try {
        $module.$funk = require(__dirname+'/da-funk.json')
      } catch(e) {
        console.error('add a section into the package.json for "da-funk" if you want to define your published with regexes')
        // TODO: later utilize a JSON stream to process the package.json and make sure everything stays in order.
        // if ~process.env.NODE_ENV.indexOf \alive => then I should be asking these things interactively..
        // additionally, I can use alive-script's Alive.Config as a scope on $publish, and automatically export things it
        $module.$funk = {compilation: {}}
        require('fs').writeFileAsync(__dirname+'/da-funk.json', JSON.stringify($module.$funk, null, '\t'))
      }
    }
  }
  return $module.$funk
});

Object.defineProperty($module, 'compilation', {get: function() {
  console.log("getting $module.compilation")

  var doT_funk, da_funk_compilation, tune, matches, all_matches = [], da_funk = $module.package['da-funk']
  if(da_funk) {
    // if(doT_funk = da_funk['doT-funk']) { /* ... */ }
    if(($module.$compilation = da_funk.compilation)) {
      // for(var record in da_funk_compilation) {
      //   console.log("record", record, "record_label", da_funk_compilation[record])
      //   for(var idx = 0, record_label = da_funk_compilation[record]; idx < record_label.length; idx++) {
      //     // TODO: combine this with aLIVEsCRIPT for automatic recompilation
      //     tune = record_label[idx]

      //     if(typeof name === 'string') {
      //       name = name.trim();
      //       if(name[0] === '.') {
      //         tune = name = name.substr(1);
      //         if(~tune.indexOf('*')) {
      //           // throw new Error("globs in da-funk.compilation not supported yet.")
      //           console.error("globs in da-funk.compilation not supported yet. skipping '"+tune+"' ..")
      //           tune = null
      //         }
      //       } else if(name[0] === '/') {
      //         console.error("not sure how to support regex yet. skipping '"+tune+"' ..")
      //         tune = null
      //       } else if(name === '*') {
      //         matches = matches.concat(Object.keys(record_label))
      //       }
      //       if(tune instanceof RegExp) {
      //         console.log("regex label", label, name.test(label))
      //       }
      //     }
      //   }
      // }
    } else {
      console.error('add a section into your package.json["da-funk"]["compilation"] and list the published for that file. (you can use regex - however not globs, yet)')
      // TODO: later if process.env.NODE_ENV is \creative => put a scope on $publish, and automatically trap it
      // TODO: later utilize alive-script to process things automatically
    }
  }
  return $module.$compilation;
}});


var compilation_matches = function(name) {
  console.log("compilation_matches:", name)
  var doT_funk, tune, matches, all_matches = []
  var da_funk_compilation = $module.compilation

  if(da_funk_compilation) for(var record in da_funk_compilation) {
    console.log("record", record, "record_label", da_funk_compilation[record])
    for(var idx = 0, record_label = da_funk_compilation[record]; idx < record_label.length; idx++) {
      // TODO: combine this with aLIVEsCRIPT for automatic recompilation
      tune = record_label[idx]

      if(typeof name === 'string') {
        name = name.trim();
        if(name[0] === '.') {
          tune = name = name.substr(1);
          if(~tune.indexOf('*')) {
            // throw new Error("globs in da-funk.compilation not supported yet.")
            console.error("globs in da-funk.compilation not supported yet. skipping '"+tune+"' ..")
            tune = null
          }
        } else if(name[0] === '/') {
          console.error("not sure how to support regex yet. skipping '"+tune+"' ..")
          tune = null
        } else if(name === '*') {
          matches = matches.concat(Object.keys(record_label))
        }
        if(tune instanceof RegExp) {
          console.log("regex label", label, name.test(label))
        }
      }
    }
  }

  return all_matches
}

// this is a hack to trick out browserify. we want our machines built properly before going into a browser.
var lazy_module = function(obj, name, src_path, fallback) {
  var prop;
  var lazy_module_compiler = function(obj, name) {
    Object.defineProperty(obj, name, {
      get: function() {
        var mod, m;
        try {
          var m;
          if((mod = obj.$published[name]) === void(8)) {
            try {
              if(require && require.extensions && require.extensions[Path.extname(src_path)]) {
                // compile/save the file perhaps too? / perhaps into a zip file?
                m = require(Path.join(__dirname, src_path));
              } else {
                m = fallback.call(null);
              }
            } catch(e) {
              console.log("weird!!", e.stack)
              m = fallback.call(null);
            }

            if(prop) {
              mod = obj.$published[name] = m[prop];
            } else {
              mod = obj.$published[name] = m;
            }
          }
        } catch (err) {
          console.error(" ~~~ a weird error getting property '"+name+"' from '"+src_path+"' ~~~\n\n", err.stack)
          console.error(err.message)
        }
        if(mod === void(8) && (mod = obj.$published[name]) === void(8)) throw new Error("error: there was a problem loading '"+src_path+"' '"+name+"' was not exported");
        return mod;
      }
    })
  }

  if(typeof obj.$published === 'undefined') {
    obj.$published = {}
  }

  for(prop in compilation_matches(name)) {
    lazy_module_compiler(obj, prop)
  }
}

// lazy_module($this.$publish, '.Fsm', './src/fsm', function() {return require('./lib/fsm')})
lazy_module($publish, /.*/g, './src/da_funk', function() { return require('./lib/da_funk') })
lazy_module($publish, '*', './src/da_funk', function() { return require('./lib/da_funk') })

// export stringify
// export freedom
// export interject
// export objectify
// export merge
// export extend
// export improve
// export embody

// lazy_module($this.$publish, '.Flexibility', './src/fsm', function() {return require('./lib/fsm')})
// lazy_module($this.$publish, '.Adaptability', './src/fsm', function() {return require('./lib/fsm')})
if($module.parent) {

  // TODO
} else {
  console.log("we are not module!")
  // TODO: stuff
}
