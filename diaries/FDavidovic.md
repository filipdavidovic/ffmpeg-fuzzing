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
afl-fuzz -m 1000 \
-i /vagrant/testcases \
-o /vagrant/findings \
/home/vagrant/bin/bin/ffmpeg -i @@ /tmp/outfile
```