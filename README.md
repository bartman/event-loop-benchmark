# event-loop-benchmark
This project is based on the [bench.c](http://libev.schmorp.de/bench.c) file that was used to [benchmark libevent against libev](http://libev.schmorp.de/bench.html).
I have extended it to compare relative performance of:

* [libev](https://github.com/enki/libev)
* [libevent](https://github.com/libevent/libevent)
* [libuev](https://github.com/troglobit/libuev)
* [libuv](https://github.com/libuv/libuv)
* [picoev](https://github.com/kazuho/picoev)

I wanted to see which one was worth my while for a project that required good scaling at high number of files.

Short answer: on my system *libev* performed best, with close second being *picoev*.

# compiling

    $ git clone https://github.com/bartman/event-loop-benchmark
    $ cd event-loop-benchmark
    $ git submodule init
    $ git submodule update
    $ make
  
# running

    $ make run
    for lib in libev libevent libuev libuv picoev ; do \
    	echo $lib ; \
    	time ./bench-$lib -n 100000 -r 10 ; \
    done
    
    libev
      100183      272
       28284      285
       27710      340
       27356      264
       27469      266
       27414      273
       27890      270
       27712      298
       27474      265
       27837      267
    0.06user 0.75system 0:00.82elapsed 99%CPU (0avgtext+0avgdata 19956maxresident)k
    0inputs+0outputs (0major+4746minor)pagefaults 0swaps

    libevent
       90165      242
      117328      223
      121098      215
      129374      213
      125306      217
      122137      221
      128751      215
      125773      214
      123250      217
      117167      224
    0.09user 1.60system 0:01.69elapsed 99%CPU (0avgtext+0avgdata 19972maxresident)k
    0inputs+0outputs (0major+4691minor)pagefaults 0swaps
    
    libuev
      119420    43696
      152023    49974
      151565    49737
      157453    49072
      151938    49957
      150834    43601
      154799    51177
      152987    49378
      151413    49359
      153405    50954
    0.50user 1.50system 0:02.00elapsed 99%CPU (0avgtext+0avgdata 10100maxresident)k
    0inputs+0outputs (0major+2223minor)pagefaults 0swaps
    
    libuv
      187609    89698
      169341    84936
      164311    80284
      166312    80238
      170351    84016
      171014    84024
      170107    83397
      163320    81280
      168780    83630
      166058    80036
    0.19user 1.97system 0:02.17elapsed 100%CPU (0avgtext+0avgdata 20420maxresident)k
    0inputs+0outputs (0major+4738minor)pagefaults 0swaps
    
    picoev
       98371      185
       62066      181
       61626      200
       62360      186
       61678      186
       61246      215
       62227      201
       61242      193
       61136      201
       61264      195
    0.06user 1.11system 0:01.17elapsed 99%CPU (0avgtext+0avgdata 7128maxresident)k
    0inputs+0outputs (0major+1461minor)pagefaults 0swaps

