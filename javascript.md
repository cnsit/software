# 原型链与继承
## 原型链
- Object.prototype 是所有对象和函数的原型对象
- Function.prototype 是所有函数的原型对象，其原型就是 Object.prototype
- Object 也是个函数
- 所有的实例都有 __proto__ 指向其所派生自的原型 prototype
- **`typeof Object`** `==>` _`function`_
- **`typeof Object.prototype`** `==>` _`object`_
- prototype 用于**定义**，便于后续派生的共享
---
**`var a = {value: 1};`**
- **`typeof a`** `==>` _`object`_
- **`a.__proto__ === Object.prototype`** `==>` _`true`_ instanceof 顺着 __proto__ 往上找构造函数的 prototype
- **`typeof a.prototype`** `==>` _`undefined`_ 只有函数有 prototype
---
- **`function f(){}`**
- **`typeof f.prototype`** `==>` _`object`_
- **`typeof f.prototype.constructor`** `==>` _`function`_ 即函数定义本身，new 的时候调用
- **`f.__proto__ === Function.prototype`** `==>` _`true`_
- **`Function.prototype.__proto__ === Object.prototype`** `==>` _`true`_ 函数的原型派生自 Object 的原型
## 继承
```js
function p(n){
  this.role = 'parent';
  this.name = n || '';
  this.keywords = [];
  this.get = function() { console.log('getting...');}
}
p.prototype.process = function(){
  console.log('processing...');
}
```
### 原型链
```js
function c(){
  this.role = 'child';
}
c.prototype = new p();
c.prototype.constructor = c;
```
缺点：
- 无法实现多继承
- 无法向父类构造函数传递参数
- 引用类型成员 keywords 会被所有c的实例共享，修改一个会使另一个也同时被修改
### 构造函数
```js
function c(n){
  p.call(this, n);
  this.role = 'child';
}
```
缺点：
- 子类（c）的实例不是父类（p）的实例：instance of p 是 false
- 原型方法（process）无法被继承，而实例方法（get）会被复制到每个实例中
### 组合继承
```js
function c(n){
  p.call(this, n);
  this.role = 'child';
}
c.prototype = new p();
c.prototype.constructor = c;
```
缺点：
- 调用了两次父类（p）的构造函数
### 完美继承
```js
function c(n){
  p.call(this, n);
  this.role = 'child';
}
(function(){
  var temp = function(){}
  temp.prototype = p.prototype;
  c.prototype = new temp();
})();
c.prototype.constructor = c;
```
缺点：
- 实现上略复杂
- 还是调用两次构造函数（但是原型对象上的调用没有重复初始化父类的成员）


# 异步与回调
```js
//j1.js
var j1;
setTimeout(function() {
  j1 = function() {
    console.log('j1');
  }
  var v1 = new j1();
}, 300);
```
```js
//j2.js
function j2(){
  console.log('j2');
}
var v2 = new j2();
var v3 = new j1();
```
## Promise
```js
function promise_js(path, cb){
  return new Promise((resolve, reject)=> {
    var node = document.createElement('script');
    node.type = 'text/javascript';
    node.async = true;
    node.src = path;
    node.onload = function(){
      if(cb){
        cb(path);
      }
      resolve(path);
    }
    node.onerror = function(){
      reject(path);
    }
    var head = document.getElementsByTagName('head')[0];
    head.appendChild(node);
  });
}
promise_js('j1.js').then(
  function(path){return promise_js('j2.js');},
  function(err){console.log(err);}
);
```
缺点：
- 只能确保文件/资源加载顺序，而无法保证文件内容执行完成
- 写法怪异，且相比于回掉函数嵌套而言并没有变得简洁多少
## 回调
```js
function has_module(module){
    var head = document.getElementsByTagName('head')[0];
    for(var i=0;i<head.childElementCount;i++){
      var s = head.children[i];
      if(s.tagName === 'SCRIPT' && s.src.indexOf('/'+module.path)>=0){
        return s.src;
      }
    }
    return false;
}
function load_requires(module, global, cb, times){
    if(Array.isArray(module.requires) && typeof global!=='undefined'){
      for(var i = 0;i<module.requires.length; i++){
        if(typeof global[module.requires[i].name] === 'undefined'){ //not loaded or not executed
          if(!has_module(module.requires[i])){
            load_module(module.requires[i], global, function(){
              load_module(module, global, cb, times);
            });
            return false;
          }else{
            if(typeof times !== 'number') times = 0;
            if(times>=100){
              throw 'Timeout loading module:'+module.name;
            }
            setTimeout(function(){
              load_module(module, global, cb, times+1);
            }, 10);
            return false;
          }
        }
      }
    }
    return true;
}
function load_module(module, global, cb, times) {
    if(!load_requires(module, global, cb, times)){
      return;
    }
    var node = document.createElement('script');
    node.type = 'text/javascript';
    node.async = true;
    node.src = module.path;
    node.onload = function() {
      if (cb) {
        cb(module);
      }
    }
    var head = document.getElementsByTagName('head')[0];
    head.appendChild(node);
}
load_module({path:'j2.js', name:'j2', requires:[{name:'j1', path:'j1.js'}]}, window, function(){
  console.log('all done!');
});
```
缺点：
- 需要加载模块时，预先指定所依赖的其它模块，如果能在模块内部指定，由模块自行加载会更好

# 模块与引用
## 模块定义
```js

```
