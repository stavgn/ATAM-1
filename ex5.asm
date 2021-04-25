.global _start

.section .text


_found_src:
    movq -64(%rbp), %rsi
    movq %rsi, -48(%rbp)
    movq -56(%rbp), %rsi
    movq %rsi, -40(%rbp)
    movq %rax, -32(%rbp)  
    movq %rbx, %rsi # store index
    jmp _before_scan_
    
_found_dst:
    movq -64(%rbp), %rdx
    movq %rdx, -24(%rbp)
    movq -56(%rbp), %rdx
    movq %rdx, -16(%rbp) 
    movq %rax, -8(%rbp) 
    movq %rbx, %rdx # store index
    jmp _should_swap
                
_start:
    pushq %rbp
    movq %rsp, %rbp
    
_before_scan:            
    xor %rbx, %rbx # set counter=0
    mov head, %rax # save head
    subq $64, %rsp # 6 64bit local param: (perv addr, nxt addr, curr addr)X3
    movq $0,  -64(%rbp)
    movq $0, -56(%rbp)
    
_scan_src:
    inc %rbx # count++    
    add $8, %rax
    mov (%rax), %rdi # set node value to next addr    
    movq %rdi, -56(%rbp) # store next addr
    add $-8, %rax # rollback to value
    mov (%rax), %rdi # set node value to temp
    cmp src, %rdi # temp == src
    je _found_src # found src
    movq %rax, -64(%rbp) #store prev addr   
    movq 8(%rax), %rax # next addr
    jmp _scan_src
 
_before_scan_:            
    xor %rbx, %rbx # set counter=0
    movq head, %rax # save head
    movq $0,  -0x200(%rbp) 
    movq $0,  -0x160(%rbp)
  
      
_scan_dst:
    inc %rbx # count++    
    add $8, %rax
    mov (%rax), %rdi # set node value to next addr    
    movq %rdi, -56(%rbp) # store next addr
    add $-8, %rax # rollback to value
    mov (%rax), %rdi # set node value to temp
    cmp dst, %rdi # temp == src
    je _found_dst # found src
    movq %rax, -64(%rbp) #store prev addr   
    movq 8(%rax), %rax # next addr
    jmp _scan_dst   
    
_should_swap:
    cmp %rsi, %rdx
    jl _end

_pick_strategy:
    subq $1, %rdx
    cmp %rsi, %rdx
    jle _swap_strategy_3_pick
    movq head, %rax
    cmp %rax, -32(%rbp)
    jne _swap_strategy_0
    je _swap_strategy_1   

_swap_strategy_3_pick:
    movq head, %rax
    cmp %rax, -32(%rbp)
    jne _swap_strategy_0_   
    je _swap_strategy_1_
    
_swap_strategy_0_:
    movq -48(%rbp), %rdx #load src prev addr
    movq -8(%rbp), %rsi # load dst addr
    movq %rsi, 8(%rdx)
    jmp _swap_strategy_3

_swap_strategy_1_:
    movq -8(%rbp), %rsi
    movq %rsi, head         
        
_swap_strategy_3:
    movq -32(%rbp), %rdx # load src addr
    movq -8(%rbp), %rsi #load dst addr
    movq %rdx, 8(%rsi)
    movq -16(%rbp), %rsi
    movq %rsi ,8(%rdx)
    jmp _end 
        
_swap_strategy_0:
    movq -48(%rbp), %rdx #load src prev addr
    movq -8(%rbp), %rsi # load dst addr
    movq %rsi, 8(%rdx)

_swap_strategy_2:
    movq -32(%rbp), %rdx # load src addr
    movq -16(%rbp), %rsi #load dst next
    movq %rsi, 8(%rdx)
    movq -24(%rbp), %rsi
    movq %rdx, 8(%rsi)
    movq -8(%rbp), %rsi #load dst addr
    movq -40(%rbp), %rdx # load src next
    movq %rdx, 8(%rsi)
    jmp _end 
    
_swap_strategy_1:
    movq -8(%rbp), %rsi
    movq %rsi, head
    jmp _swap_strategy_2  
            
_end:
    leave # pop stack