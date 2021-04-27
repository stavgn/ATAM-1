.global _start 
.section .text
_start:
#your code here

xor %rcx, %rcx # i=0
lea source, %rsi # rsi = &source
lea destination, %rdi # rdi= &destination


movl num, %ecx
cmp $0, %ecx
jle end

loop:
dec %ecx 
movb (%rsi,%rcx,1),%dl
movb %dl, (%rdi, %rcx,1)

cmp $0,%ecx
jne loop

end:



