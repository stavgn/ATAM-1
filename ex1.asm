.global _start

.section .text
_start:
    xor %rax, %rax
    xor %dl, %dl
    mov num, %rax
    mov $64, %ecx


_loop:
    test %ecx, %ecx
    je _end
    
    sal $1, %rax
    adc $0, %dl
    dec %ecx
    jmp _loop
    
_end:
    mov %dl, countBits
 
            