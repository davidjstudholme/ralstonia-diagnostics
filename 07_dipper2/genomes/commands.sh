### Download NCBI's datasets utility:
curl -o datasets 'https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/v2/linux-amd64/datasets'
chmod u+x datasets

### Use NCBI's datasets utility to download the genome sequences, unzip them and move to current directory:
./datasets download genome accession --inputfile assembly_accessions.txt --include genome --filename genome_assemblies.zip
unzip genome_assemblies.zip
mv ncbi_dataset/data/GC*_*/GC*_*.fna .

