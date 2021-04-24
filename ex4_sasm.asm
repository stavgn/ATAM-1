.global main

.section .data
arr: .int 6,4,1,9,10,6,3
n: .int 7
begin: .int 0
len: .int 0

.section .text
main:
#your code here


mov $1,%rcx # counter=1
mov $1, %rax # max_length=1
xor %rbx, %rbx # max_begin=0

mov $1, %r8 # temp_length=1
xor %r9, %r9 # temp_begin=0

xor %edx, %edx # prev_value=0
mov arr,%edx # prev_value=arr[0]

loop:
cmp %rcx, n
je end_loop

# if (arr[i]<arr[i-1]){...}
cmp arr(,%rcx,4),%edx
jg keep_counting 

reset_count:

mov $1,%r8
mov %rcx,%r9
jmp cont


keep_counting:
add $1,%r8
cmp %rax,%r8
jle cont 
mov %r8 ,%rax
mov %r9 ,%rbx


cont:
mov arr(,%rcx,4) ,%edx 
add $1, %rcx
jmp loop


end_loop:
mov %rbx,begin
mov %rax,len


/*
c code:
i=0;
void longest_mono_subseries(int* arr, int n,int *spot,int *length){
    int max_spot=0;
    int max_length=1;
    int temp_spot=0;
    int temp_length=1;

    for (int i=1; i<n;i++ ){
        if (arr[i-1]<=arr[i]){
            temp_length=1;
            temp_spot=i;
        }
        else{
            temp_length++;
            if (temp_length>max_length){
                max_spot=temp_spot;
                max_length=temp_length;
            }
        }
    }
    *spot=max_spot;
    *length=max_length;

}
*/



