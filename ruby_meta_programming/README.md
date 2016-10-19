## 第四章

### 4.1 类定义揭秘

1. 你可能在会认为类定义就是定义方法的地方。事实上，你可以在类定义中放入任何代码。
2. 跟方法和块一样，类定义也会返回最后一条语句的值。
3. 在类(或模块)定义时，类本身就充当了当前对象self的角色。类和模块也是对象。
4. 不管处在Ruby程序的哪个位置，总是存在一个当前对象: self。类似地，也总是有一个当前类(或模块)存在。当定义一个方法时，该方法成为当前类的一个实例方法。
5. `Module#class_eval()`(或者它的别名`module_eval()`)会在一个已存在类的上下文中执行一个块。
6. 当前类及其特殊情况:在定义`method_two()`方法的时候当前类不是self，因为self根本不是类。实际上，这是当前类的角色由self的类来充当 `MyClass`。
<pre>
class MyClass
  def method_one
    def method_two
      'Hello'
    end
  end
end
</pre>
7. 实际上`Module#class_eval()`方法和`Object#instance_eval()`方法截然不同。`instance_eval()`方法仅仅会修改self，二`class_eval()`方法会同时修改self和当前类。通过修改当前类，`class_eval()`实际上是重新打开了该类，就像class关键字所做的一样。
8. `Module#class_eval()`可以对任何代表类的变量使用，而关键字class只能使用常量，并且回新打开一个作用域，而`class_eval()`方法则使用扁平作用域。

### 4.2 小测验: Taboo类