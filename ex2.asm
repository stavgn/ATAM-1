.global _start 
.section .text
_start:
#your code here

xor %ecx, %ecx # i=0
lea source, %rsi # rsi = &source
lea destination, %rdi # rdi= &destination

movl num,%edx # edx=num

# if (num<=0) return;
cmp $0,%edx
jle end

loop:


# what i want to do is:
# "movb source+i, destination+i"
movb (%rsi),%bl
movb %bl,(%rdi)

inc %rsi
inc %rdi
inc %ecx
# loop condition : while( i!=num )
cmp %edx,%ecx
jne loop

end:



