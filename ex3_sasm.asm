.global _start
.section .data
arr: .int 1,2,3,4,5,6,7,8,9,0
.section .text
_start:
#your code here
movq $0,%rax # rax == sum = 0
movq $0,%rcx # rcx == count = 0
movq $arr, %rsi

xor %rdx, %rdx

cmp $0,(%rsi)
je end

loop:
movsxd (%rsi),%rdx
add %rdx,%rax
inc %rcx
add $4,%rsi
cmp $0,(%rsi)
jne loop

end:
xor %rdx,%rdx
divq %rcx
inc %rcx # for debugging



