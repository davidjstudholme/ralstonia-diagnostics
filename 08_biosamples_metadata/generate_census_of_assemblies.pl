#!/usr/bin/env perl

use strict;
use warnings;

my $assemblies_from_ncbi  = 'biosample_assemblies.tsv';
my $assemblies_from_phytobacexplorer = 'phytobacexplorer-13-aug-2026.tsv';

warn "Getting NCBI genome assemblies from file '$assemblies_from_ncbi'\n";
warn "Getting PhytoBacExplorer assemblies from file '$assemblies_from_phytobacexplorer'\n";

my %biosample_has_assembly;
my %biosample2ncbi;

### Open the NCBI assemblies file for reading
open my $in_ncbi, '<:encoding(UTF-8)', $assemblies_from_ncbi
    or die "Cannot open $assemblies_from_ncbi: $!";

### Get the header line
my $header_line = <$in_ncbi>;
chomp $header_line;
my @ncbi_headings = split /\t/, $header_line;

### List the NCBI metadata headings
warn "Headings from NCBI assemblies file:\n";
foreach my $heading (@ncbi_headings) {
    warn "\t$heading\n";
}

### Read the NCBI assemblies
while (my $readline = <$in_ncbi>) {
    my %heading2datum;
    chomp $readline;
    my @data = split /\t/, $readline;
    foreach my $heading (@ncbi_headings) {
	my $datum = shift @data;
	$heading2datum{$heading} = $datum;
    }
    my $biosample = $heading2datum{'biosample'};
    my $has_assembly = $heading2datum{'has_assembly'};
    my $assembly_accessions = $heading2datum{'assembly_accessions'};
    if ($has_assembly =~m/yes/i) {
	if (defined $biosample) {
	    $biosample2ncbi{$biosample}{'assembly_accessions'} .= $assembly_accessions; 
	    $biosample_has_assembly{$biosample} ++;
	}   
    }
}
### Close the NCBI assemblies file for reading 
close $in_ncbi;

### How many BioSamples have at least one assembly?
my $count = keys %biosample_has_assembly;
warn "$count BioSamples have at least one assembly\n";

### Print a summary of the assemblies
foreach my $biosample( sort keys %biosample_has_assembly) {
    #warn "Checking BioSample $biosample\n";
    my $ncbi_accessions = $biosample2ncbi{$biosample}{'assembly_accessions'};
    if (defined $ncbi_accessions) {
	warn "$biosample\t$ncbi_accessions\n";
    }
}

