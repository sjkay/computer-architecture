.text 							# The variables in comments are based on the C code
.align 4

main: 	la $a0, input_data
		la $a1, output_data
		subu $a2, $a1, $a0 		# n = 128, n($a2) is the total size (in bytes) of data
		lw $t0, 0($a0)
		sw $t0, 0($a1)
		addi $s0, $zero, 4 		# i = 4, i($s0) is used as an index of input data

L1: 	bge $s0, $a2, myself 	# if (i >= n) branch
		add $t0, $a0, $s0
		lw $t2, 0($t0) 			# temp = list[i]
		addi $s1, $s0, -4 		# j = i - 4, j($s1) is used as an index of output data

L2: 	add $t1, $a1, $s1
		lw $t3, 0($t1)
		blt $s1, $zero, end 	# if (j < 0) branch
		bge $t3, $t2, end 		# if (list[j] >= temp) branch
		sw $t3, 4($t1) 			# list[j+1] = list[j]
		addi $s1, $s1, -4 		# j = j - 4
		j L2

end: 	sw $t2, 4($t1) 			# list[j+1] = temp
		addi $s0, $s0, 4 		# i = i + 4
		j L1

myself: j myself

.data
.align 4

input_data: 	.word 2, 0, -7, -1, 3, 8, -4, 10
				.word -9, -16, 15, 13, 1, 4, -3, 14
				.word -8, -10, -15, 6, -13, -5, 9, 12
				.word -11, -14, -6, 11, 5, 7, -2, -12
output_data: 	.word 0, 0, 0, 0, 0, 0, 0, 0
				.word 0, 0, 0, 0, 0, 0, 0, 0
				.word 0, 0, 0, 0, 0, 0, 0, 0
				.word 0, 0, 0, 0, 0, 0, 0, 0