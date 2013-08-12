package Data::Convert::Array::Rename;
use 5.008005;
use strict;
use warnings;
use parent qw(Exporter);

our $VERSION = "0.01";

sub new {
    my ($class, $rules, $opts) = @_;

    unless ( ref $rules eq 'HASH' ) {
        die '$_[0] required reference of Hash';
    }

    bless {
        rules => $rules,
        opts  => $opts,
    }, $class;
}

sub rename {
    my ($self, $before, $opts) = @_;
    $opts ||= $self->{opts};
    $self->rename_array($before, $self->{rules}, $opts);
}

sub rename_array {
    my ($self, $before, $rules, $opts) = @_;

    my @after = ();
    for my $element ( @$before ) {
        unless ( exists $rules->{$element} ) {
            unless ( $opts->{skip_other} ) {
                push @after, $element;
            }
            next;
        }

        my $after_rule = $rules->{$element};
        unless ( ref $after_rule ) {
            push @after, $after_rule;
        }
        elsif ( ref $after_rule eq 'ARRAY' ) {
            for my $field (@{ $after_rule }) {
                push @after, $field;
            }
        }
        else {
            die "not supported type";
        }
    }
    return \@after;
}

1;
__END__

=encoding utf-8

=head1 NAME

Data::Convert::Array::Rename - It's new $module

=head1 SYNOPSIS

    use Data::Convert::Array::Rename;

=head1 DESCRIPTION

Data::Convert::Array::Rename is ...

=head1 LICENSE

Copyright (C) Hiroyoshi Houchi.

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 AUTHOR

Hiroyoshi Houchi E<lt>hixi@cpan.orgE<gt>

=cut

