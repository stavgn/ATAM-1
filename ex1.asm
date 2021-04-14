.global _start

.section .text
_start:
    xor %eax, %eax
    xor %dl, %dl
    mov num, %eax
    mov $64, %ecx


_loop:
    dec %ecx
    test %ecx, %ecx
    je _end
    
    sal $1, %eax
    adc $0, %dl
    jmp _loop
    
_end:
    mov %dl, countBits
 
            