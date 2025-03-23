# an example of iteration where the sum of every word
# in an array is computed

	.data
start: .word 1,0,1,0,1,0,1, 0
	.word 1,0,1,0,1,0,1, 0
	.word 1,0,1,0,1,0,1, 0
	.word 1,0,1,0,1,0,1, 0
	.word 1,0,1,0,1,0,1, 0
	.word 1,0,1,0,1,0,1, 0
	.word 1,0,1,0,1,0,1, 0
	.word 1,0,1,0,1,0,1, 0
	
	.word 1,0,1,0,1,0,1, 0
	.word 1,0,1,0,1,0,1, 0
	.word 1,0,1,0,1,0,1, 0
	.word 1,0,1,0,1,0,1, 0
	.word 1,0,1,0,1,0,1, 0
	.word 1,0,1,0,1,0,1, 0
	.word 1,0,1,0,1,0,1, 0
	.word 1,0,1,0,1,0,1, 0
	
	.word 1,0,1,0,1,0,1, 0
	.word 1,0,1,0,1,0,1, 0
	.word 1,0,1,0,1,0,1, 0
	.word 1,0,1,0,1,0,1, 0
	.word 1,0,1,0,1,0,1, 0
	.word 1,0,1,0,1,0,1, 0
	.word 1,0,1,0,1,0,1, 0
	.word 1,0,1,0,1,0,1, 0
	
	.word 1,0,1,0,1,0,1, 0
	.word 1,0,1,0,1,0,1, 0
	.word 1,0,1,0,1,0,1, 0
	.word 1,0,1,0,1,0,1, 0
	.word 1,0,1,0,1,0,1, 0
	.word 1,0,1,0,1,0,1, 0
	.word 1,0,1,0,1,0,1, 0
	.word 1,0,1,0,1,0,1, 0
	
#Total dataset size (from label "start" to end) is 1024 Bytes 

.text
.globl main

main: 
	add $t2, $zero, $zero	# initialize sum
	add $t4, $zero, $zero   # initialize iteration counter
	addi $t5, $zero, 10		# repeat entire process 10 times
	
outer_loop:
	la $t0, start			# load start address of array
	add $t1, $t0, 1024		# address of end of array
	
inner_loop:
	lw $t3, 0($t0)			# fetch array element
	add $t2, $t2, $t3		# update sum
	addi $t0, $t0, 4		# point to next element 
	bne $t0, $t1, inner_loop # if not at end, continue inner loop
	
	addi $t4, $t4, 1		# increment iteration counter
	bne $t4, $t5, outer_loop # if not done with all iterations, continue outer loop

finish:
	li $v0, 10
	syscall
