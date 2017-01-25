.data
	HelloWorld:
		.asciz "Hello World\n"
		len = . - HelloWorld
.text
	.globl _start
	.type PrintFunction,@function

	PrintFunction:
		pushl %ebp  #Store current value of EIP on the stack
		movl %esp,%ebp  #Make EBP point to top of the stack

		#The write Function
		
		movl $4,%eax
		movl $1,%ebx
		movl 8(%ebp),%ecx
		movl 12(%ebp),%edx
		int $0x80

		movl %ebp,%esp  #Restore the old value of ESP
		pop %ebp  #Restore the old value of EBP
		ret #change EIP to start the next instruction

	_start:
		nop
		
		#push the strlen on the stack
		pushl $len
		pushl $HelloWorld  #push the string pointer on the stack

		call PrintFunction  #Call the function

		add $8,%esp #adjust the stack pointer
		
		#Exit Routine
		ExitCall:
			movl $1,%eax
			int $0x80

