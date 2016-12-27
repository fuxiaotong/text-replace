package Text::Replace::BaseLib;

use Test::Base -Base;

use File::Spec ();
# use Data::Dumper;
use Cwd qw(cwd);

our @EXPORT = qw(
    run_test
);

our $doc    = File::Spec->catfile(cwd() || '.', 't/doc');
our $output = File::Spec->catfile($doc, 'output');

sub parse_cmd ($) {
    my $cmd = shift;
    my @cmd;
    while (1) {
        if ($cmd =~ /\G\s*"(.*?)"/gmsc) {
            push @cmd, $1;

        } elsif ($cmd =~ /\G\s*'(.*?)'/gmsc) {
            push @cmd, $1;

        } elsif ($cmd =~ /\G\s*(\S+)/gmsc) {
            push @cmd, $1;

        } else {
            last;
        }
    }

    return @cmd;
}

sub bail_out (@);

sub bail_out (@) {
    Test::More::BAIL_OUT(@_);
}

sub run_test(){
    
    for my $block (Test::Base::blocks()) {
        run_block($block);
    } 
}

sub run_block($) {

    my $block = shift;
    
    our $ip = $block->ip || '0.0.0.0';
    our $passwd = $block->passwd || '0000';

    my $text = $ENV{text};
    $text = File::Spec->catfile(cwd(),$text);
    
    my $line;
    my $isfind = "false";


    system ("rm -rf $output >/dev/null") == 0 or
        bail_out "can't rm $output\n";

    if (!-d $doc) {
        mkdir $doc or
            bail_out "Failed to do mkdir $doc\n";
    }

    if(!-f $output) {
        system("touch $output") == 0 or
            bail_out "can't touch $output\n";
    }

    open my $out, ">$output" or
        bail_out "Can't open $output for writing: $!\n";

    open my $in, $text or die $!;

    while (<$in>) {
        
        $line = $_;
        chomp $ip;
        chomp $passwd; 
        
        if($line =~ s/$ip [0-9a-zA-Z]*/$ip $passwd/)
        {
            $isfind = "true";
        }
        print $out $line;
    }

    if ($isfind eq "false") {
        $line = $ip.' '.$passwd;
        print $out $line;
        print $out "\n";
    }

    close $in;
    close $out;
    
    system ("cp $output $text") == 0 or
        bail_out "can't cp $text\n";

}


1;

__END__

NO CONTENT
