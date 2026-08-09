### Download NCBI's datasets utility:
curl -o datasets 'https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/v2/linux-amd64/datasets'
chmod u+x datasets

### Use NCBI's datasets utility to download the genome sequences, unzip them and make symlinks in curren directory:
./datasets download genome accession --inputfile assembly_accessions.txt --include genome --filename genome_assemblies.zip
unzip genome_assemblies.zip
ln -s ncbi_dataset/data/GC*_*/GC*_*.fna .


### Make symlinks to the genome sequence files such that symlinks have informative names and appropriate extensions for input to PhaME:
perl rename_files.pl genomes.txt
