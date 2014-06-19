## Ruby和Rails的代码规范

[ruby-style-guide](https://github.com/bbatsov/ruby-style-guide)

[ruby-style-guide中文版](https://github.com/JuanitoFatas/ruby-style-guide/blob/master/README-zhCN.md)

[rails-style-guide](https://github.com/bbatsov/rails-style-guide)

[rails-style-guide中文版](https://github.com/JuanitoFatas/rails-style-guide/blob/master/README-zhCN.md)

## Ruby元编程附录

### 常见惯用法

#### A.1 拟态方法（Mimic Methods）

puts “Hello,world!”
这里的 puts 实际上是个方法，完整写法

~~~ruby
puts(“Hello,world!”)
~~~

去掉括号的写法使得它像个关键字，同时也更为简洁，因此称之为拟态方法。

属性的问题：

~~~ruby
class C
    def my_attr=(value)
        @p = value
    end
    def my_attr
        @p
    end
end
obj = C.new
obj.my_attr = 'some value'
obj.my_attr         # => 'some value'
~~~

代码obj.my_attr = 'some value'的功能与代码obj.my_attr=('some value')的功能是相同的，不过前者看起来更清爽。

来自 Camping 的例子，这里的 R 实际上是一个方法，'/help' 是它的参数，返回值是一个 Class的实例。

~~~ruby
class Help < R '/help'
    def get
        # rendering for HTTP GET...
    end
end
~~~


#### A.2 空指针保护（Nil Guards）

~~~ruby
a ||= []
~~~

以上代码等价于

~~~ruby
a = a || []
~~~

空指针保护常用于初始化实例变量，看看下面这个类：

~~~ruby
class C
    def initialize(value)
        @a = []
    end
    def elements
        @a
    end
end
~~~

使用空指针保护，可以更简练地重写以上这段代码：

~~~ruby
class C
    def elements
        @a ||= []
    end
end
~~~
上面的代码会在最后它要被访问的时候才进行初始化，这种惯用法被称为**惰性实例变量(Lazy Instance Variable)**。



#### A.3 关于方法参数的技巧（Tricks with Method Arguments）

#####具名参数(Named Arguments)

当在Ruby中调用方法时，你不得不按照特定的顺序输入参数。如果顺序错误，则会引入一个bug：

~~~ruby
def login(name, password, message)
    #...
end
login('james', 'just doing some administration', '123456') #bug
~~~

当有一大串参数要输入时，这种错误非常常见。
Ruby 2.0 以后，可以使用关键字参数，Ruby 2.0可以使用Hash参数来解决这个问题。

~~~ruby
login(name: 'bill', message: 'just doing some administration', password: '123456')
~~~

##### 参数数组和默认值(Argument Arrays and Default Values)

*操作符可以把多个参数收集到一个数组中；

~~~ruby
def my_method(*args)
    args
end

my_method(1, '2' , 'three' ) # =]]> [1, "2", "three"]
~~~

Ruby 也支持如下参数默认值：

~~~ruby
def my_method(x, y = "a default value" )
    "#{x} and #{y}"
end
my_method("a value" ) # => "a value and a default value"
~~~

##### 混合使用参数的惯用法(Mixing Arguments Idioms)

Ruby 2.0以前

~~~ruby
def my_method(arg, hash)
  lots = hash[:lots] || "default"
  args = hash[:args] || "another"
  hand = hash[:by_hand] || "annoying"
  ...
end
my_method "with", lots: "of", args: "in", by_hand: "form"
~~~

Ruby 2.0以后

~~~ruby
def my_method(arg, lots: "default", args: "another", by_hand: "annoying")
  lots = hash[:lots] || "default"
  args = hash[:args] || "another"
  hand = hash[:by_hand] || "annoying"
  ...
end
my_method "with", lots: "of", args: "in", by_hand: "form"
~~~

#### A.4 Self Yield
当给方法传入一个块时，你会期望这个方法通过yield对块进行回调。这种回调有一种有用的变形，就是对象可以把自身传给这个块。下面的例子来自于RubyGems包管理器。

##### 传统写法

~~~ruby
spec = Gem::Specification.new
spec.name = "My Gem name"
spec.version = "0.0.1"
# ...
~~~

##### Self Yield 写法

~~~ruby
spec = Gem::Specification.new do |s|
    s.name = "My Gem name"
    s.version = "0.0.1"
    # ...
end
~~~


##### Gem::Specification 源代码

~~~ruby
module Gem
    class Specification
        def initialize
            yield self if block_given?
            # ...
        end
        #...
    end
end
~~~

##### 来自 tap() 的例子
在Ruby中，长长的方法调用链很普遍

~~~ruby
['a', 'b', 'c'].push('d' ).shift.upcase.next # => "B"
~~~

但是某一步出错，你将不得不如下调试

~~~ruby
temp = ['a' , 'b' , 'c' ].push('d' ).shift
puts temp
x = temp.upcase.next
~~~

这非常笨拙；Ruby 1.9 中引入了 tap() 方法，我们可以这样做

~~~ruby
['a' , 'b' , 'c' ].push('d' ).shift.tap {|x| puts x }.upcase.next
~~~

老版本的 Ruby ，我们也可以很容易的实现一个

~~~ruby
class Object
    def tap
        yield self
        self
    end
end
~~~


#### A.5 Symbol#to_proc() 方法
这种有点诡异的法术在Ruby程序员中很流行，请看下面的代码

~~~ruby
names = ['bob' , 'bill' , 'heather' ]
names.map {|name| name.capitalize } # => ["Bob", "Bill", "Heather"]
~~~

更简洁的写法

~~~ruby
names = ['bob' , 'bill' , 'heather' ]
names.map(&:capitalize) # => ["Bob", "Bill", "Heather"]
~~~

当&操作符作用于一个对象时，它会调用该对象的to_proc方法，将其转化为一个proc对象。

~~~ruby
class Symbol
    def to_proc
        Proc.new {|x| x.send(self) }
    end
end
~~~







