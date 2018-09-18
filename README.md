ARM Shellcode
=============

1. mprotect egghunter

- Searches for an EGG (4+4 byte value) in the memory of the exploited process.
- Uses mprotect() to test the presence of pages in the virtual memory space of the target process.
- mprotect() also marks pages RWX as it scans the virtual memory space.
- Upon finding the pre-defined EGG occuring at consecutive locations, the mprotect egghunter passes on the execution control to the shellcode appended to the eggs.

2. Quantum Leap code

- ARM/Thumb Polyglot code.
- Can be started in ARM mode or Thumb mode.
- Irrespective of the mode it is started in, the Quantum Leap code will switch the CPU to Thumb mode and proceed to execute any Thumb shellcode appended to it.

For more details please browse through my presentation titled "Make ARM Shellcode Great Again" at https://slideshare.net/saumilshah/

@therealsaumil

