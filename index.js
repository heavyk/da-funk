// machine-shop
var Path = require('path')
var Promise = require('bluebird')
var export$ = typeof exports !== 'undefined' ? exports : this;
var mod$ = typeof module !== 'undefined' ? module : {}


// this is a hack to trick out browserify. we want our machines built properly before going into a browser.
function lazy_module(obj, name, src_path, fallback) {
  name = name.trim();
  var prop;
  if(name[0] === '.') {
    prop = name = name.substr(1);
  }
  if(typeof obj._exports === 'undefined') {
    obj._exports = {}
  }
  Object.defineProperty(obj, name, {
    get: function() {
      var mod, m;
      try {
        var m;

        if((mod = obj._exports[name]) === void(8)) {
          try {
            if(require && require.extensions && require.extensions['.ls']) {
              m = require(Path.join(__dirname, src_path));
              // TODO: write out the file after loading it
            } else {
              m = fallback.call(null);
            }
          } catch(e) {
            console.log("weird!!", e.stack)
            m = fallback.call(null);
          }

          if(prop) {
            mod = obj._exports[name] = m[prop];
          } else {
            mod = obj._exports[name] = m;
          }
        }
      } catch (err) {
        console.error(" ~~~ a weird error getting property '"+name+"' from '"+src_path+"' ~~~\n\n", err.stack)
        console.error(err.message)
      }
      if(mod === void(8) && (mod = obj._exports[name]) === void(8)) throw new Error("error: there was a problem loading '"+src_path+"' '"+name+"' was not exported");
      return mod;
    }
  })
}

function lazy_property(obj, name, fallback) {
  if(typeof obj._exports === 'undefined') {
    obj._exports = {}
  }
  Object.defineProperty(obj, name, {
    get: function() {
      try {
        if(obj._exports[name] === void(8)) {
          obj._exports[name] = fallback.call(null);
        }
      } catch (err) {
        console.log("a weird error occured. this shouldn't happen:", err.stack)
      }
      if(!obj._exports[name]) throw new Error("wtf? - #{src_path}");
      return obj._exports[name];
    }
  })
}

lazy_module(export$, '.stringify', './src/da_funk', function() { return require('./lib/da_funk') })
lazy_module(export$, '.freedom', './src/da_funk', function() { return require('./lib/da_funk') })
lazy_module(export$, '.interjection', './src/da_funk', function() { return require('./lib/da_funk') })
lazy_module(export$, '.objection', './src/da_funk', function() { return require('./lib/da_funk') })
lazy_module(export$, '.merge', './src/da_funk', function() { return require('./lib/da_funk') })
lazy_module(export$, '.extend', './src/da_funk', function() { return require('./lib/da_funk') })
lazy_module(export$, '.improves', './src/da_funk', function() { return require('./lib/da_funk') })
lazy_module(export$, '.embody', './src/da_funk', function() { return require('./lib/da_funk') })


if(module.parent) {
  // TODO
} else {
  console.log("we are not module!")
  // TODO: stuff
}
