# Load Testing Adhearsion: Steps Taken Thus Far

## Hardware/Software Configuration

### Test Target

Hardware Spec (Basic):

* 2x Intel Xeon w/ Hyperthreading (2.4 GHz)
* 3GB RAM

Software:

* Debian 6.0.7 "Squeeze" (i386)
* RVM head (newest)
* Ruby 1.9.3-p392
* Ruby 2.0.0-p0
* JRuby 1.7.3
* Latest Adhearsion from "develop" branch
* Punchblock from "feature/fs_perf_tweak"
* Nokogiri 1.5.9 for Ruby 1.9.3 and 2.0
* Nokogiri 1.5.6 for JRuby

### Test Driver

* Running from a VM on my laptop
* SIPp trunk from March 1st (Latest build to not break with the patch)
* dyn_pcap_audio patch for DTMF
* Built with `make pcapplay`

## The Adhearsion Application

The Adhearsion application used in the test is a series of calls to #menu. There are six menus in total. Each menu has two DTMF options and an audio file that plays at their beginning. The menus have a *right* answer, meaning that only one of the choices will allow the call to continue. On the sixth menu, one of the answer choices will cause the call to end immediately. In most cases, a call through this system will take approximately 53 seconds.

## The SIPp Scenario

The SIPp scenario used can be described as follows:

* SIPp sends an INVITE to Adhearsion
* Adhearsion sends SIPp an optional 100 and/or 180 and a mandatory 200 OK
* SIPp waits 10 seconds (The length of the first audio file) and then plays a DTMF 4
* SIPp waits 3 seconds (The length of the second audio file) and then plays a DTMF 8
* SIPp waits 2.5 seconds and then plays a DTMF 9
* SIPp waits 10 seconds and then plays a DTMF 1
* SIPp waits 3 seconds and then plays a DTMF 3
* SIPp waits 2.5 seconds and then plays a DTMF 7
* SIPp gets a BYE from Adhearsion
* SIPp sends a 200 OK to Adhearsion

After each DTMF, Adhearsion is expected to move on to the next menu. If Adhearsion does not continue, it will, in most cases, hang up the call and the call will be marked as failed.

## The Test

Each Ruby interpreter (outlined at the beginning of this document) was run through the same test. 500 calls total were run through the Adhearsion app, with 100 concurrent calls being active at any one time. The ramp-up rate of the calls was ten calls every second. The completion time, number of failed calls, and CPU usage of each interpreter's test were logged.

## The Results (So Far)

### Ruby 1.9.3:

Time to Completion: 14 minutes, 24 seconds
Failed Calls:              24

### Ruby 2.0.0:

Time to Completion: 16 minutes, 12 seconds
Failed Calls:              0

### JRuby:

Tests so far have been proven inconclusive with JRuby. The tests have been unable to complete as memory usage climbs to over 20 percent by the end of the first 250 calls. After that, it starts failing because it is "Unable to create a new thread" and Java throws an OutOfMemoryError.  
