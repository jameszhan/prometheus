## Ruby和Rails相关资料

[ruby-style-guide](https://github.com/bbatsov/ruby-style-guide)

[ruby-style-guide中文版](https://github.com/JuanitoFatas/ruby-style-guide/blob/master/README-zhCN.md)

[rails-style-guide](https://github.com/bbatsov/rails-style-guide)

[rails-style-guide中文版](https://github.com/JuanitoFatas/rails-style-guide/blob/master/README-zhCN.md)

[Ruby Doc](http://ruby-doc.org/)

[Rails Guide](http://guides.rubyonrails.org/)

[Ruby Gem Ranking](https://www.ruby-toolbox.com/)

[Ruby元编程附录](./ruby-metaprogramming-appendixes.md)


编程语言对象模型
* [Inside the Ruby Object Model](http://pan.baidu.com/s/1COmIE) 8jji
* [C++ Object Model](http://pan.baidu.com/s/1o6AxTl4) wad5
* [Java Object Model](http://pan.baidu.com/s/1gdGbOrT) nmmq
* [Introduction of Python's Object Model](http://pan.baidu.com/s/1i3oTzCx) c492
* [The Common LISP ObjectModel](http://pan.baidu.com/s/1o6K7qfo) 4ve0
* [JavaScript Object Model](./javascript-object-model.md)


##### 字符串构建

* %{String}  用于创建一个使用双引号括起来的字符串
* %Q{String} 用于创建一个使用双引号括起来的字符串
* %q{String} 用于创建一个使用单引号括起来的字符串
* %r{String} 用于创建一个正则表达式字面值
* %w{String} 用于将一个字符串以空白字符切分成一个字符串数组，进行较少替换
* %W{String} 用于将一个字符串以空白字符切分成一个字符串数组，进行较多替换
* %s{String} 用于生成一个符号对象
* %x{String} 用于执行String所代表的命令