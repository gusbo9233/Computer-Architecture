##############################################################################
#
#  KURS: 1DT093 2023.  Computer Architecture
#	
# DATUM: 2024-10-16
#
#  NAMN: Gustav Boberg
#
#  NAMN: Jaskaran Heldestad
#
##############################################################################

	j main		# Jump to the main function

	.data
	
ARRAY_SIZE:
	.word	10	# Change here to try other values (less than 10)
FIBONACCI_ARRAY:
	.word	1, 1, 2, 3, 5, 8, 13, 21, 34, 55
STR_str:
	.asciiz "Hunden, Katten, Glassen"

	.globl DBG
	.text

##############################################################################
#
# DESCRIPTION:  For an array of integers, returns the total sum of all
#		elements in the array.
#
# INPUT:        $a0 - address to first integer in array.
#		$a1 - size of array, i.e., numbers of integers in the array.
#
# OUTPUT:       $v0 - the total sum of all integers in the array.
#
##############################################################################
integer_array_sum:  



        addi    $v0, $zero, 0           # Initialize Sum to zero.
	add	$t0, $zero, $zero	# Initialize array index i to zero.
	lw $t2, ARRAY_SIZE              # Load the array size
	la $t1, FIBONACCI_ARRAY         # Load the array
for_all_in_array:

	#### Append a MIPS-instruktion before each of these comments
	beq $t0, $t2, end_for_all # Done if i == N
	sll $t4, $t0, 2           # 4*i
	add $t3, $t1, $t4         # address = ARRAY + 4*i
	lw $t5 0($t3)             # n = A[i]
       	add $v0, $t5, $v0         # Sum = Sum + n
        addi $t0, $t0, 1          # i++ 
  	j for_all_in_array        # next element
	
end_for_all:
	
	jr	$ra			# Return
	
##############################################################################
#
# DESCRIPTION: Gives the length of a string.
#
#       INPUT: $a0 - address to a NUL terminated string.
#
#      OUTPUT: $v0 - length of the string (NUL excluded).
#
#    EXAMPLE:  string_length("abcdef") == 6.
#
##############################################################################	
	##### DEBUGG BREAKPOINT ######
string_length:
	
	#### Write your solution here ####

	add    $v0, $zero, $zero          # container for string length

loop_string_length:
	lb $t0, 0($a0)                    # load byte from string
	beq $t0, $zero, end_string_length # if null, end loop
	addi $v0, $v0, 1                  # increment the string length
	addi $a0, $a0, 1                  # point to next character
	j loop_string_length		  # process next character 
	
	

end_string_length:
	jr	$ra
	
##############################################################################
#
#  DESCRIPTION: For each of the characters in a string (from left to right),
#		call a callback subroutine.
#
#		The callback suboutine will be called with the address of
#	        the character as the input parameter ($a0).
#	
#        INPUT: $a0 - address to a NUL terminated string.
#
#		$a1 - address to a callback subroutine.
#
##############################################################################	
string_for_each:

    addi $sp, $sp, -4        # Make space for return address on the stack
    sw $ra, 0($sp)	     # Store the return address on the stack
    add $s0,$a0,$zero	     # Copy the input into a temporary register

loop:
    lb $t0, 0($s0)           # Load the byte at the current address of the string into $t0
    beq $t0, $zero, end_loop # End at terminating character
    move $a0, $s0            # Pass argument to procedure
    jalr $a1                 # Call the procedure
    addi $s0 $s0,1	     # Point to the next byte of the string
    j    loop                # Next element

end_loop:

    lw $ra, 0($sp)          # Restore the return address from the stack
    addi $sp, $sp, 4        # Deallocate space on the stack
    jr $ra		    # Return

##############################################################################
#
#  DESCRIPTION: Transforms a lower case character [a-z] to upper case [A-Z].
#	
#        INPUT: $a0 - address of a character 
#
##############################################################################		
to_upper:
    lb    $t0, 0($a0)

    blt    $t0, 'a', end_if
    bgt    $t0, 'z', end_if

    subi    $t0, $t0, 32
    sb    $t0, 0($a0)
end_if:
    #### Write your solution here ####
    jr    $ra

##############################################################################
#
# DESCRIPTION: Reverses a String
# INPUT: $a0 - address to a NUL terminated string.
#
##############################################################################

DBG:
reverse_string:
    
    move $t1, $a0           # Save $a0 in $t1

    jal string_length       # Get length of string which is stored in $v0
    
    move $a0, $t1 	    #restore $a0

    
    move $t2, $a0           # Point to the first character
    add $t3, $a0, $v0       # Point to the null ending
    addi $t3, $t3, -1       # Point to the last character
    li $t4, 2               # Load immediate value 2, to be used in division
    div $v0, $t4            # Divide string length by 2
    mflo $t5                # Store the result of integer division
    li $t6, 0               # Counter for the loop

reverse_loop:
    beq  $t6, $t5, end_reverse   # End when we have gone through all pairs
    
    
   # Switch place of characters
    lb $t7, 0($t2)        
    lb $t8, 0($t3)       
    sb $t8, 0($t2)        
    sb $t7, 0($t3)

   # Increment/decrement the pointers to get the next pair of characters
    addi    $t2, $t2, 1        
    addi    $t3, $t3, -1       
    
    addi  $t6, $t6, 1       # Increment the loop counter
    j     reverse_loop      # Process next pair of characters
   

end_reverse:
    jal	print_test_string  # Print the reversed string
    jr      $ra            # Return

##############################################################################
#
# Strings used by main:
#
##############################################################################

	.data

NLNL:	.asciiz "\n\n"
	
STR_sum_of_fibonacci_a:	
	.asciiz "The sum of the " 
STR_sum_of_fibonacci_b:
	.asciiz " first Fibonacci numbers is " 

STR_string_length:
	.asciiz	"\n\nstring_length(str) = "

STR_for_each_ascii:	
	.asciiz "\n\nstring_for_each(str, ascii)\n"

STR_for_each_to_upper:
	.asciiz "\n\nstring_for_each(str, to_upper)\n\n"	

	.text
	.globl main

##############################################################################
#
# MAIN: Main calls various subroutines and print out results.
#
##############################################################################	
main:
	addi	$sp, $sp, -4	# PUSH return address
	sw	$ra, 0($sp)

	##
	### integer_array_sum
	##
	
	li	$v0, 4
	la	$a0, STR_sum_of_fibonacci_a
	syscall

	lw 	$a0, ARRAY_SIZE
	li	$v0, 1
	syscall

	li	$v0, 4
	la	$a0, STR_sum_of_fibonacci_b
	syscall
	
	la	$a0, FIBONACCI_ARRAY
	lw	$a1, ARRAY_SIZE
	jal 	integer_array_sum

	# Print sum
	add	$a0, $v0, $zero
	li	$v0, 1
	syscall

	li	$v0, 4
	la	$a0, NLNL
	syscall
	
	la	$a0, STR_str
	jal	print_test_string

	##
	### string_length 
	##
	
	li	$v0, 4
	la	$a0, STR_string_length
	syscall

	la	$a0, STR_str
	jal 	string_length

	add	$a0, $v0, $zero
	li	$v0, 1
	syscall

	##
	### string_for_each(string, ascii)
	##
	
	li	$v0, 4
	la	$a0, STR_for_each_ascii
	syscall
	
	la	$a0, STR_str
	la	$a1, ascii
	jal	string_for_each

	##
	### string_for_each(string, to_upper)
	##
	
	li	$v0, 4
	la	$a0, STR_for_each_to_upper
	syscall
	
	la	$a0, STR_str
	la	$a1, to_upper
	jal	string_for_each
	
	la	$a0, STR_str
	jal	print_test_string
	
	la	$a0, STR_str             # Load the address of the string to reverse
	jal 	reverse_string         # Call the reverse_string subroutine

		
	
	lw	$ra, 0($sp)	# POP return address
	addi	$sp, $sp, 4

	li	$v0, 10		# Exit syscall, check MARS documentation for details
	syscall			# End execution, we do not return here since there is nothing to return to
	
	  # Execute syscall to print the string

	
	#jr	$ra

##############################################################################
#
#  DESCRIPTION : Prints out 'str = ' followed by the input string surronded
#		 by double quotes to the console. 
#
#        INPUT: $a0 - address to a NUL terminated string.
#
##############################################################################
print_test_string:	

	.data
STR_str_is:
	.asciiz "str = \""
STR_quote:
	.asciiz "\""	

	.text

	add	$t0, $a0, $zero
	
	li	$v0, 4
	la	$a0, STR_str_is
	syscall

	add	$a0, $t0, $zero
	syscall

	li	$v0, 4	
	la	$a0, STR_quote
	syscall
	
	jr	$ra
	

##############################################################################
#
#  DESCRIPTION: Prints out the Ascii value of a character.
#	
#        INPUT: $a0 - address of a character 
#
##############################################################################
ascii:	
	.data
STR_the_ascii_value_is:
	.asciiz "\nAscii('X') = "

	.text

	la	$t0, STR_the_ascii_value_is

	# Replace X with the input character
	
	add	$t1, $t0, 8	# Position of X
	lb	$t2, 0($a0)	# Get the Ascii value
	sb	$t2, 0($t1)

	# Print "The Ascii value of..."
	
	add	$a0, $t0, $zero 
	li	$v0, 4
	syscall

	# Append the Ascii value
	
	add	$a0, $t2, $zero
	li	$v0, 1
	syscall


	jr	$ra
	
