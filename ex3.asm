.global _start

.section .text
_start:
#your code here
mov $0,%rax # rax == sum = 0
mov $0,%rcx # rcx == count = 0
mov $arr, %rsi

cmp $0,(%rsi)
je avg_is_zero

loop:
movsxd (%rsi),%rdx
add %rdx,%rax
inc %rcx
add $4,%rsi
cmp $0,(%rsi)
jne loop

xor %rdx,%rdx
div %rcx
mov %eax, avg
jmp end

avg_is_zero:
movl $0,avg

end:




