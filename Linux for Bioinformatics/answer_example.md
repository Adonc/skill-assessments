# Answers to questions from "Linux for Bioinformatics"

Q1: What is your home directory?

A: /home/ubuntu

Q2: What is the output of this command?

A: hello_world.txt

Q3. What is the output of each ls command?

A: ls on my_folder, doesnt return anything. ls on my_folder2: hello_world.txt

Q4. What is the output of each?

A: ls on my_folder: doesnt return anything. ls on my_folder2: nothing returned ls on my_folder3: hello_world.txt Q5. What editor did you use and what was the command to save your file changes?

A: editor used: nano command to save: ctrl + o command to exit: ctrl + x

Q6. What is the error?

A: Permission denied (publickey).

Q7. What was the solution?

A: created authorized_keys files in the .ssh directory of the sudouser generated a key on my machine using the code: ssh-keygen -t sudouserkey pasted the content of sudouserkey.pub into authorized_keys using nano, exited and connected to sudouser using: `ssh -i sudouserkey sudouser@ec2-54-167-113-82.compute-1.amazonaws.com`, sudouserkey being my private key

Q8. what does the sudo docker run part of the command do? and what does the salmon swim part of the command do?

A: `docker --help` run:Run a command in a new container

`sudo docker run combinelab/salmon salmon --help` swim: perform super-secret operation

Q9. What is the output of this command? A: serveruser is not in the sudoers file. This incident will be reported

Q10. What is the output of flask --version?

A: Python 3.10.6 Flask 2.2.2 Werkzeug 2.2.2

Q11. What is the output of mamba -V? A: conda 22.9.0 Q12. What is the output of which python? A: A:/home/serveruser/mambaforge/envs/py27/bin/python

Q13. What is the output of which python now? A:/home/serveruser/mambaforge/bin/python

Q14. What is the output of salmon -h?

```{bash}
salmon v1.4.0

Usage:  salmon -h|--help or
        salmon -v|--version or
        salmon -c|--cite or
        salmon [--no-version-check] <COMMAND> [-h | options]

Commands:
     index      : create a salmon index
     quant      : quantify a sample
     alevin     : single cell analysis
     swim       : perform super-secret operation
     quantmerge : merge multiple quantifications into a single file
```

Q15. What does the `-o athal.fa.gz` part of the command do? A: `--output <file> Write to file instead of stdout` instead of printingto the screen, the content of the remote file is writen to a file named athal.fa.gz

Q16. What is a .gz file? A: this is compressed file generated using gzip

Q17. What does the zcat command do? A: from `man zcat`:zcat uncompresses either a list of files on the command line or its standard input and writes the uncompressed data on standard output. zcat will uncompress files that have the correct magic number whether they have a .gz suffix or not.

Q18. what does the `head` command do? A: head outputs the first part of the file

Q19. what does the number 100 signify in the command? A: to print the first 100 lines of the file

Q20. What is \| doing? A: pass the output of the previous program to the next program, in this case, the output of zcat is passed to head, to show the first 100 lines

Q21. What is a .fa file? What is this file format used for? A: fasta file, it is used to store sequence of biological molecules, i.e DNA or proteins

Q22. What format are the downloaded sequencing reads in? A: in sra format

Q23. What is the total size of the disk? A: 7.6GB

Q24. How much space is remaining on the disk? A: 1.9GB

Q25. What went wrong? err: storage exhausted while writing file within file system module - system bad file descriptor error fd='5' the storage was usedup by the file generated

Q26: What was your solution? A: Solution was to compress the output of fastq-dump using --gzip option
