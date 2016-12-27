# USAGE

we can see `text-replace.t`:
```perl
use lib 'lib';
use Text::Replace::BaseLib 'no_plan';

$ENV{text} = "hello.txt";   # 输入要修改的文件名，将其放到 text-replace 目录下。

run_test();

__DATA__

=== Replace 1: 1

--- ip
192.168.6.100
--- passwd
123456

=== Replace 2: 2

--- ip
200.200.200.200
--- passwd
88888
```

下面是一个块，在这个块中设定你的ip和密码，如果文件中不存在，则在文件后面追加。
```
=== Replace 1: 1

--- ip
192.168.6.100
--- passwd
123456
```
如果有很多和ip的密码修要修改，那么重复添加多几个块，只需要维护这几个块即可。


```shell
$apt-get install cpanminus
$cpanm Test::Base
$cpanm Test::More
$cpanm File::Spec
$cd text-replace/
$perl t/text-replace.t
```

输出的结果会覆盖原来的文件，后续可以做调整。

LICENSE
-------
test-validator is released under the [MIT License](https://opensource.org/licenses/MIT).


