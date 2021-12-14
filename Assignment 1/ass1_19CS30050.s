	.file	"ass1.c"      # source file name
	.text                 # start of the text
	.section	.rodata   # read-only data section
	.align 8              # align with 8-byte boundary
.LC0:            # label of f-string- 1st printf
	.string	"Enter how many elements you want:"   # the string in first printf()
.LC1:            # label of f-string scanf
	.string	"%d"                                  # the string in scanf()
.LC2:            # label of f-string - 2nd printf
	.string	"Enter the %d elements:\n"             # the string in second printf()
.LC3:            # label of f-string - 3rd printf
	.string	"\nEnter the item to search"           # the string in third printf()
.LC4:            # label of f-string - 4th printf
	.string	"\n%d found in position: %d\n"          # the string in fourth printf()
	.align 8
.LC5:            # label of f-string - 5th printf 
	.string	"\nItem is not present in the list."    # the string in fifth printf()
	.text        # code starts
	.globl	main    # main is a global name
	.type	main, @function    # main is a function
main:       # main: starts
.LFB0:
	.cfi_startproc     # call frame information
	endbr64            # terminate indirect branch of 64-bit
	pushq	%rbp      # save old base pointer
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp   # rbp <-- rsp set new stack base pointer
	.cfi_def_cfa_register 6
	subq	$432, %rsp   # create space for local array and variables
	movq	%fs:40, %rax   # segment addressing
	movq	%rax, -8(%rbp)  # move the value of rax to 8 bytes below rbp
	xorl	%eax, %eax # clear eax
	leaq	.LC0(%rip), %rdi  # load the effective address of .LC0(%rip), which loads the string with label .LC0 to 1st printf
	call	puts@PLT  # call the puts() function
	leaq	-432(%rbp), %rax  # load the effective address of 432 bytes below rbp to rax, that is, address of n
	movq	%rax, %rsi  # move value from rax(address of n) to rsi(second argumnet of scanf)
	leaq	.LC1(%rip), %rdi  # load the effective address of .LC1(%rip), which loads the string with label .LC1 to scanf
	movl	$0, %eax  # set the return value to 0 (register eax)
	call	__isoc99_scanf@PLT  # call the scanf() function
	movl	-432(%rbp), %eax  # set the value of register eax to 432 bytes below rbp, that is n.
	movl	%eax, %esi  # set the value of esi to eax (esi is the second argument and has value n)
	leaq	.LC2(%rip), %rdi  # load the effective address of .LC2(%rip), which loads the string with label .LC2 to 2nd printf
	movl	$0, %eax  # set the return value to 0 (register eax)
	call	printf@PLT  # call the printf() function
	movl	$0, -424(%rbp)  # set the value of 424 bytes below rbp, that is i to 0.
	jmp	.L2   # jump to .L2
.L3:
	leaq	-416(%rbp), %rax  # load effective address of memory at 416 bytes below rbp to rax, that is a[0]
	movl	-424(%rbp), %edx  # move the value stored at 424 bytes below rbp, that is i to edx
	movslq	%edx, %rdx  # move signed value of i(stored in edx) having 32 bits to 64 bits(in rdx)
	salq	$2, %rdx   # left shift the value stored at rdx, that is i by 2 bits meaning do 4*i
	addq	%rdx, %rax  # add value stored in rdx (4*i) to rax(a) to find a[i].
	movq	%rax, %rsi  # move value stored in rax to rsi(second argument of scanf)
	leaq	.LC1(%rip), %rdi  # load the effective address of .LC1(%rip), which loads the string with label .LC1 to scanf
	movl	$0, %eax  # set the return value to 0 (register eax)
	call	__isoc99_scanf@PLT  # call scanf() function
	addl	$1, -424(%rbp)  # add value of 1 to value stored at 424 bytes below rbp, that is i (essentially do i++)
.L2:
	movl	-432(%rbp), %eax  # move the value stored at 432 bytes below rbp, that is n to eax.
	cmpl	%eax, -424(%rbp)  # do a signed comparison between value stored at eax, that is n,  and 424 bytes below rbp. that is i
	jl	.L3  # if i < n jump to .L3
	movl	-432(%rbp), %edx  # move value stored at 432 bytes below rbp, that is n to edx
	leaq	-416(%rbp), %rax  # load effective value stored at 416 bytes below rbp, that is a, to rax
	movl	%edx, %esi  # move value stored at edx (n) to esi
	movq	%rax, %rdi  # move value stored at rax (a) to rdi
	call	inst_sort   # call the function inst_sort
	leaq	.LC3(%rip), %rdi  # load the effective address of .LC3(%rip), which loads the string with label .LC3 to 3rd printf
	call	puts@PLT  # call the puts() function
	leaq	-428(%rbp), %rax  # load effective address of 428 bytes below rbp, that is &item to rax
	movq	%rax, %rsi  # move value stored at rax(&item) to rsi
	leaq	.LC1(%rip), %rdi  # load the effective address of .LC1(%rip), which loads the string with label .LC1 to scanf
	movl	$0, %eax  # set the return value to 0 (register eax)
	call	__isoc99_scanf@PLT  # call scanf() function
	movl	-428(%rbp), %edx  # move value stored at 428 bytes below rbp(item) to edx
	movl	-432(%rbp), %ecx  # move value stored at 432 bytes below rbp(n) to ecx
	leaq	-416(%rbp), %rax  # load effective address of 416 bytes below rbp, that is a , to rax
	movl	%ecx, %esi  # move value stored at ecx (n) to esi
	movq	%rax, %rdi  # move value stored at rax (a) to rdi
	call	bsearch  # call the bsearch() function
	movl	%eax, -420(%rbp)  # store the return value of bsearch() function(in register eax) to 420 bytes below rbp, that is loc.
	movl	-420(%rbp), %eax  # move the value stored at 420 bytes below rbp (that is, loc) to eax
	cltq   # sign-extend the value stored in eax (that is , loc) to rax
	movl	-416(%rbp,%rax,4), %edx  # move the value stored at a[loc] to register edx
	movl	-428(%rbp), %eax  # move the value stored at 428 bytes below rbp, that is item to eax
	cmpl	%eax, %edx  # compare value stored at registers eax and edx, that is compare item with a[loc]
	jne	.L4   # if item != a[loc] then jump to .L4
	movl	-420(%rbp), %eax  # move the value stored at 420 bytes below rbp, that is loc to eax
	leal	1(%rax), %edx  # load effective address of 1 byte above rax , that is loc+1 to edx (third argument)
	movl	-428(%rbp), %eax  # move the value stored at 428 bytes below rbp, that is item to eax
	movl	%eax, %esi  # move value stored at eax to esi (second argument)
	leaq	.LC4(%rip), %rdi  # load the effective address of .LC4(%rip), which loads the string with label .LC4 to 4th printf
	movl	$0, %eax   # set the return value to 0 (register eax)
	call	printf@PLT   # call the printf() function
	jmp	.L5   # jump to .L5
.L4:
	leaq	.LC5(%rip), %rdi  # load the effective address of .LC5(%rip), which loads the string with label .LC5 to 5th printf
	call	puts@PLT   # call the puts() function
.L5:
	movl	$0, %eax  # set the return value to 0 (register eax)
	movq	-8(%rbp), %rcx  # move the value stored at 8 bytes below rbp to rcx
	xorq	%fs:40, %rcx  # xor the value of segment addressing and rcx (8 bytes below rbp)
	je	.L7  # if the above xor == 0 => segment address == rcx then move to .L7
	call	__stack_chk_fail@PLT   # this is the system check for buffer overflows
.L7:
	leave  # put rbp to rsp and restore state of rsp to original state
	.cfi_def_cfa 7, 8
	ret  # pop return address from stack and move there
	.cfi_endproc
.LFE0:
	.size	main, .-main
	.globl	inst_sort  # assembler directive defining inst_sort as a global
	.type	inst_sort, @function  # defines the type of inst_sort to be a function
inst_sort:    # inst_sort: starts
.LFB1:
	.cfi_startproc
	endbr64       # terminate indirect branch of 64-bit
	pushq	%rbp   # push the base pointer (rbp) to stack
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp  # set rbp to be equal to rsp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)  # move value stored at rdi(which is a) to 24 bytes below rbp
	movl	%esi, -28(%rbp)  # move value stored at esi(which is n) to 28 bytes below rbp
	movl	$1, -8(%rbp)   # move value 1 to 8 bytes below rbp, that is j
	jmp	.L9  # jump to .L9
.L13:
	movl	-8(%rbp), %eax  # move value stored at 8 bytes below rbp, that is j to eax
	cltq    # convert signed value at eax to rax
	leaq	0(,%rax,4), %rdx  # load effective address of 4*j and store the value at rdx
	movq	-24(%rbp), %rax  # move value stored at 24 bytes below rbp, that is a to rax
	addq	%rdx, %rax   # add the value stored at rdx, that is j, to rax that is a and get a[j]
	movl	(%rax), %eax  # move the value stored at the memory address stored in rax to eax
	movl	%eax, -4(%rbp)  # move value stored at a[j] to 4 bytes below rbp
	movl	-8(%rbp), %eax  # move value stored at 8 bytes below rbp , that is j , to eax
	subl	$1, %eax   # subtract 1 from value at eax, that is j to get j -1
	movl	%eax, -12(%rbp)  # move value stored at eax, j-1, to 12 bytes below rbp, that is i (meaning i = j-1)
	jmp	.L10   # jump to .L10
.L12:
	movl	-12(%rbp), %eax  # move value stored at 12 bytes below rbp, that is i to eax
	cltq    # convert signed eax value to rax
	leaq	0(,%rax,4), %rdx   # load effective address of 4*i to register rdx
	movq	-24(%rbp), %rax   # move the value stored at 24 bytes below rbp, that is a to rax
	addq	%rdx, %rax   # add the value stored at rdx , that is 4*i to value stored at rax, that is a to get a[i]
	movl	-12(%rbp), %edx   # move the value stored at 12 bytes below rbp, that is i to edx
	movslq	%edx, %rdx   # move and sign extend value stored in edx, that is i to rdx
	addq	$1, %rdx    # add 1 to the value stored in rdx, that is i to get i+1.
	leaq	0(,%rdx,4), %rcx  # load effective address of 4*(i+1) and store in rcx.
	movq	-24(%rbp), %rdx   # move the value stored at 24 bytes below rbp, that is a to rdx.
	addq	%rcx, %rdx   # add value stored at rdx, that is a to value stored at rdx that is 4*(i+1) to get a[i+1]
	movl	(%rax), %eax  # move the value stored at rax, that is a[i] to eax.
	movl	%eax, (%rdx)   # move the value stored at eax. that is a[i] to value stored at the address rdx, that is set a[i+1] to a[i].
	subl	$1, -12(%rbp)  # subtract 1 from the value stored at 12 bytes below rbp, that is i, to get i--.
.L10:
	cmpl	$0, -12(%rbp)  # compare value stored at 12 bytes below rbp, that is i with 0
	js	.L11   # if i < 0 go to .L11
	movl	-12(%rbp), %eax  # move the value stored at 12 bytes below rbp, that is i to eax
	cltq   # convert signed value of eax to rax
	leaq	0(,%rax,4), %rdx  # load the effective address of 4*i and store in rdx
	movq	-24(%rbp), %rax  # move the value at 24 bytes below rbp, that is a to rax
	addq	%rdx, %rax   # add the value stored at rdx to value stored at rax to get a[i]
	movl	(%rax), %eax   # move the value stored at rax to eax.
	cmpl	%eax, -4(%rbp)  # compare the value stored at eax, that is a[i] with value stored at 4 bytes below rbp, that is k.
	jl	.L12   # if k < a[i] go to .L12
.L11:
	movl	-12(%rbp), %eax  # move the value stored at 12 bytes below rbp, that is i to eax
	cltq    # convert signed value of eax to rax
	addq	$1, %rax   # add 1 to value to stored at rax, that is i and get i+1
	leaq	0(,%rax,4), %rdx   # load effective address of 4*i and store the value at rdx
	movq	-24(%rbp), %rax   # move the value stored at 24 bytes below rbp, that is a to rax
	addq	%rax, %rdx   # add the value stored at rax , that is num to the value stored at rdx , that is 4*(i+1) to get a[i+1] 
	movl	-4(%rbp), %eax  # move the value stored at 4 bytes below rbp, a[j] to eax
	movl	%eax, (%rdx)  # move the address of value stored at eax to the value at the memory address stored at rdx
	addl	$1, -8(%rbp)  # add the value of 1 to value stored at 8 bytes below rbp, that is j to get j+1
.L9:
	movl	-8(%rbp), %eax   # move the value stored at 8 bytes below rbp, that is j to eax
	cmpl	-28(%rbp), %eax  # compare value stored at 28 bytes below rbp, that is n with value stored at eax that is j
	jl	.L13  # if j < n go to .L12
	nop   # do nothing
	nop   # do nothing
	popq	%rbp   # pops rbp from stack
	.cfi_def_cfa 7, 8
	ret    # return from function
	.cfi_endproc
.LFE1:
	.size	inst_sort, .-inst_sort
	.globl	bsearch   # assembler directive defining bsearch as global
	.type	bsearch, @function   # defines the type of bsearch to be a function
bsearch:     # bsearch : starts
.LFB2:
	.cfi_startproc
	endbr64         # terminate indirect branch of 64-bit
	pushq	%rbp   # push base pointer (rbp) to top of stack
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp  # set rbp to be equal to to rsp
	.cfi_def_cfa_register 6
	movq	%rdi, -24(%rbp)  # move the value stored at rdi(first argument => a) to 24 bytes below rbp.
	movl	%esi, -28(%rbp)  # move the value stored at esi(second argument => n) to 28 bytes below rbp.
	movl	%edx, -32(%rbp)  # move the value stored at edx(third argument => item) to 32 bytes below rbp.
	movl	$1, -8(%rbp)   # move the value of 1 to 8 bytes below rbp, that is set bottom to 1.
	movl	-28(%rbp), %eax  # move the value stored at 28 bytes below rbp, that is n to eax
	movl	%eax, -12(%rbp)  # move the value stored at eax, that is n to 4 bytes below rbp , that is set top to n.
.L18:
	movl	-8(%rbp), %edx   # move the value stored at 8 bytes below rbp, that is bottom to edx
	movl	-12(%rbp), %eax  # move the value stored at 12 bytes below rbp, that is top to eax
	addl	%edx, %eax   # add the value stored in edx, that is bottom, to value stored in eax, that is top, that is do top = bottom + top.
	movl	%eax, %edx  # move the value stored in eax , that is top+bottom, to edx, which now stores top+bottom
	shrl	$31, %edx   # right shift the value stored in edx, that is top+bottom by 31 bits to get (top+bottom) >> 31
	addl	%edx, %eax   # add the value stored in edx, that is (top+bottom) >> 31 to the value stored in eax, that is top+bottom, to get top+bottom + (top+bottom)>>31
	sarl	%eax   # right shift the value stored in eax, that is top+bottom + (top+bottom)>>31 by 1, to get the floor value of (top+bottom)/2
	movl	%eax, -4(%rbp)  # move the value stored in eax to 4 bytes below rbp, that is mid, which means mid = (bottom+top)/2
	movl	-4(%rbp), %eax  # move the value stored at 4 bytes below rbp, that is mid to eax
	cltq   # convert signed eax value to rax.
	leaq	0(,%rax,4), %rdx   # load effective value of 4*mid and store in rdx.
	movq	-24(%rbp), %rax   # move the value stored at 24 bytes below rbp, that is a, to rax 
	addq	%rdx, %rax   # add the value stored in rdx, that is 4*mid, to the value stored in rax, that is a to get a[mid] and store it in rax.
	movl	(%rax), %eax  # move the value stored in rax to the value stored in eax.
	cmpl	%eax, -32(%rbp)   # compare the value stored in eax, that is a[mid] with 32 bytes below rbp, that is item. 
	jge	.L15   # if item >= a[mid] go to .L15
	movl	-4(%rbp), %eax  # move the value stored at 4 bytes below rbp, that is mid to eax.
	subl	$1, %eax   # subtract 1 from the value stored at eax, that is mid and we get mid -1.
	movl	%eax, -12(%rbp)  # move the value stored at eax, that is mid -1 to 12 bytes below rbp, that is top , so we get top = mid-1
	jmp	.L16   # jump to .L16
.L15:
	movl	-4(%rbp), %eax  # move the value stored at 4 bytes below rbp, that is mid to eax.
	cltq    # convert the signed value of eax (32 bits) to rax (64 bits)
	leaq	0(,%rax,4), %rdx   # load the effective value of 4*mid and store in rdx.
	movq	-24(%rbp), %rax  # move the value stored at 24 bytes below rbp, that is a to rax
	addq	%rdx, %rax   # add the value stored in rdx, that is 4*mid to value stored in rax that is a , to get a[mid]
	movl	(%rax), %eax   # move the value stored at a[mid] to eax
	cmpl	%eax, -32(%rbp)  # compare the value stored at eax, that is a[mid] with the value stored at 32 bytes below rbp, that is item
	jle	.L16   # if item <= a[mid] go to .L16
	movl	-4(%rbp), %eax  # move the value stored at 4 bytes below rbp, that is mid to eax
	addl	$1, %eax  # add 1 to the value stored at eax, that is mid to get mid+1
	movl	%eax, -8(%rbp)  # move the value stored in eax, that is mid+1 to 8 bytes below rbp, that is do bottom = mid+1
.L16:
	movl	-4(%rbp), %eax  # move the value stored at 4 bytes below rbp, that is mid to eax.
	cltq    # convert the signed value of eax to rax.
	leaq	0(,%rax,4), %rdx   # load effective address of 4*mid and store in rdx.
	movq	-24(%rbp), %rax  # move the value stored at 24 bytes below rbp, that is a, to rax
	addq	%rdx, %rax   # add the value stored in rdx, that is 4*mid to the value stored in rax, that is a to get a[mid]
	movl	(%rax), %eax  # move the value stored in memory address which is stored in rax, that is a[mid] to eax
	cmpl	%eax, -32(%rbp)  # compare the value stored in eax, that is a[mid] with the value stored at 32 bytes below rbp, that is item
	je	.L17   # if item == a[mid] go to .L17
	movl	-8(%rbp), %eax  # move the value stored at 8 bytes below rbp, that is bottom to eax
	cmpl	-12(%rbp), %eax  # compare the value stored at 12 bytes below rbp, that is top, with the value stored at eax, that is bottom.
	jle	.L18   # if bottom <= top go to .L17
.L17:
	movl	-4(%rbp), %eax  # move the value stored at 4 bytes below rbp, that is mid to eax.
	popq	%rbp  # pops rbp (base pointer) from stack
	.cfi_def_cfa 7, 8
	ret   # return from the function
	.cfi_endproc
.LFE2:
	.size	bsearch, .-bsearch
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"  # show system and compiler information
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
