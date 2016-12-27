use lib 'lib';
use Text::Replace::BaseLib 'no_plan';

$ENV{text} = "hello.txt";

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
