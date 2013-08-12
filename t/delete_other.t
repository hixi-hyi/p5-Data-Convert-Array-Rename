use strict;
use warnings;
use lib 't/lib';

use Test::More;
use Data::Convert::Array::Rename;

my $rules = {
    foo  => 'bar',
    baz  => [qw/qux quux/],
};
my $converter = Data::Convert::Array::Rename->new($rules, { skip_other => 1 });

sub rename_test {
    my (%specs) = @_;
    my ($input, $expects, $desc) = @specs{qw/input expects desc/};

    subtest $desc => sub {
        my $result = $converter->rename($input);
        is_deeply $result, $expects;
        note explain $result;
    };
}

rename_test(
    input   => [qw/nil/],
    expects => [qw//],
    desc    => 'skiped',
);

rename_test(
    input   => [qw/foo/],
    expects => [qw/bar/],
    desc    => 'convert single',
);

rename_test(
    input   => [qw/baz/],
    expects => [qw/qux quux/],
    desc    => 'convert array',
);

rename_test(
    input   => [qw/foo baz/],
    expects => [qw/bar qux quux/],
    desc    => 'multi input',
);

rename_test(
    input   => [qw/baz baz/],
    expects => [qw/qux quux qux quux/],
    desc    => 'same value',
);

done_testing;
