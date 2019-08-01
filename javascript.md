# 原型链与继承
## 原型链
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
```
缺点：
- 无法实现多继承
- 无法向父类构造函数传递参数
- 引用类型成员 keywords 会被所有c的实例共享，修改一个会使另一个也同时被修改
### 构造函数
```js
function c(n){
  p.call(this);
  this.role = 'child';
}
```
缺点：
- 子类（c）的实例不是父类（p）的实例：instance of p 是 false
- 原型方法（process）无法被继承，而实例方法（get）会被复制到每个实例中
