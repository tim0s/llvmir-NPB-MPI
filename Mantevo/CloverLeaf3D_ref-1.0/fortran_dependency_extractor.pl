use Graph;
use strict;
use autodie;
use warnings;
use File::Slurp;
use Data::Dumper;


# Iterate over fortran files and find out which files provide / use modules

opendir(DH, ".");
my @files = readdir(DH);
closedir(DH);

my %deps;
foreach my $file (@files) {
    next if ($file =~ /^\.+$/);    # skip . and ..
	next if ($file !~ /\.f90/);    # skip non-fortran files
	open my $handle, '<', $file;
	chomp(my @lines = <$handle>);
	close $handle;
    my $uses = parse_modules(\@lines, "use");
    my $provides = parse_modules(\@lines, "module");
    $deps{$file} = {uses => $uses, provides => $provides};
}

# deps now contains info for each file, which module does it provide and which
# does it use. What we actually need is info about which file depends on which
# other files. So first generate a helper datastructure that tells us for each
# module in which file it is used/provided.

my %modules;
for my $f1 (keys %{deps}) {
	my @used = @{$deps{$f1}{uses}};
	foreach my $x (@used) { push @{$modules{$x}{used_in}}, $f1; }
	my @provides = @{$deps{$f1}{provides}};
	foreach my $x (@provides) { push @{$modules{$x}{provided_by}}, $f1; }
}


# Generate a graph where the nodes are filenames. If file F1 uses module m,
# which is provided by file F2, add F1->F2 to the graph.

my $graph = Graph->new();
foreach my $m (keys %modules) {
	my $p = $modules{$m}{provided_by};
	my $u = $modules{$m}{used_in};
	if ((ref($u) eq "") or (ref($p) eq "")) { next;	}
	if (scalar @{$p} > 1) { die "More than one provider for $m\n"; }

	foreach my $F2 (@{$p}) {
		foreach my $F1 (@{$u}) {
			$graph->add_edge ($F1, $F2);
		}		
	}
}

# For every vertex v1 with outdeg(v1) > 0 and out-neighbours vn1 .. nvk print a
# makefile rule v1 : vn1 .. nvk

foreach my $v ($graph->vertices) {
	next if ($graph->out_degree($v) == 0);
	my @s = $graph->successors($v);
	print "$v : " . join(' ', @s) . "\n";
}

sub parse_modules {
	my ($lines, $keyword) = @_;
	my %res;
	foreach my $l (@{$lines}) {
		$l =~ s/^(.*?)!(.*)$/$1/; # delete comments
		next if ($l !~ m/\s*$keyword(\s+)(\S+)/i);
		$res{$2}++;
	}
	my @res = keys %res;
	return \@res;
}

