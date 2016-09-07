# PushAndPop
界面专场 多界面内存处理
要求:A - push - B - push - D - pop - C - pop - A
```
self.navigationController.viewControllers是导航控制器的子控制器的数组,最开始没有调转的时候,数组里面只有根视图控制器A,
1 执行A - push - B 操作之后,viewControllers就会把B加进去,所使用的内存资源也会增加。
2 在B界面做过一些操作之后,返回A界面 B - POP - A,viewControllers就会把B移除出去,所使用的内存资源减少。
3 如果界面比较多,一直push下去,viewControllers里面的界面越来越多,很有可能内存不够用的,造成内存问题。
4 所以说,不是所有的进入某个界面都是要使用push的,也可以使用pop
5 怎样在viewController没有在navigationController.viewControllers的栈里,怎么直接pop进入
用可变数组 MutableVCArrays = self.navigationController.viewControllers
把你要pop的界面加入到当前VC在MutableVCArrays的所在的位置的前面,这样就可以直接pop进入
http://www.tuicool.com/articles/2iMrIbn 具体说明

