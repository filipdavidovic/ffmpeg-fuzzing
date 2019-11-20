# Filip Davidovic diary

## Compiling ffmpeg for AFL
I've had some trouble compiling ffmpeg in order to use it with AFL. At first, I managed to compile it but it was giving a segmentation error no matter what I ran it with.

ffmpeg has a pretty straight forward way to compile C code. First configure the compile with *configure*, then compile with *make* and then install with *make install*. Notably, *configure* accepts many different options to specify which "add-ons" to install. 

AFL injects instrumentation during the compilation. We simply have to compile the source code using a modified version of gcc (afl-gcc) which does this for us.

Eventually I created the following bash script which compiled it successfully:
```bash
./configure --prefix=/home/vagrant/bin
make CC=afl-gcc
make install
```
Along with some other settings such as logging and reporting.

## Running AFL
With the code in the initial commit (), AFL can be ran with:
```bash
afl-fuzz -m 500 \
-i /vagrant/testcases \
-o /vagrant/findings \
/home/vagrant/bin/bin/ffmpeg -i @@ /tmp/outfile
```

Although the above is fine, it is a bit slow because it is not using parallelization. Therefore, I made a bash script to run AFL in parallel mode as described in [parallel_fuzzing.txt](https://github.com/google/AFL/blob/master/docs/parallel_fuzzing.txt). Basically, just add *-M <worker_id>* or *-S <worker_id>*, for master and slave respectively.

## Finding test cases
This command lists all the formats suppoted by ffmpeg:
```bash
ffmpeg -formats
```
Any format can be further inspected using:
```bash
ffmpeg -h demuxer=<demuxer_name>
```

Google indexes most of the files it stumbles upon. Specific files can be found by searching:
```
filetype:<file_type> <keyword>
```

Since AFL recommends size of < 1KB we usually need to trim the file to make it small enough. The perfect tool to do this is ffmpeg! 😛 However, note that this only works for formats which have both decoders and encoders implemented. This can be done using the following command:
```bash
ffmpeg -i /path/to/inputfile -c copy -t 00:00:01 /path/to/outputfile # output length it 00:00:00 - 00:00:01 
```
