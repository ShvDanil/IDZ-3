	.intel_syntax noprefix
	.text
calcAtan:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32

	movsd	xmm3, QWORD PTR .LC0[rip]		# Сохранили число 2
	movapd	xmm5, xmm0				# Первый формальный параметр - double x (сохранили в xmm5)
	movapd	xmm6, xmm1				# Второй формальный параметр - double accuracy (сохранили в xmm6)
	movapd	xmm7, xmm5				# Аналог записи в программе на си double value = x, сохранили в xmm7
	movsd	xmm8, QWORD PTR .LC0[rip]		# double iter = 2, сохранили в xmm11
	movsd	xmm9, QWORD PTR .LC1[rip]		# Сохранили число 1
	mov		rcx, 0				# Храним значение, которое поможет понять, нужно ли отнимать следующий член ряда или прибавлять (кладем в rcx)
	mov 	r8, 3					# Текущая степень и знаменатель (кладем в r8)
.L2:
	movapd	xmm11, xmm7				# double remember = value в начале цикла (храним в xmm11)
	movapd	xmm14, xmm8						
	mulsd	xmm14, xmm3						
	subsd	xmm14, xmm9				# Строки 18 - 20: получили число 2 * iter - 1, сохранили в xmm14
	mov		rax, 1				# Заводим счетчик в rax, он нужен для возведения в степень числа
	movapd	xmm10, xmm5				# Кладем в xmm10 значение double x
pow:
	mulsd	xmm10, xmm5				# Умножаем число само на себя
	add		rax,1				# прибавляем к счетчику 1, затем сравниваем с нужным значением
	cmp		rax, r8
	jl		pow				# Возводим в нужную степень, цикл работает, пока не дойдем до нужной степени

	mov 	rax, rcx						
	and     rax, 1
    test    rax, rax					# Проверка числа на четность 
	jne		odd				# Если нечетное, то переходим к метке odd
	divsd	xmm10, xmm14				# Делим x^(2 * iter - 1) на 2 * iter - 1, результат записываем в xmm10
	subsd	xmm7, xmm10				# Отнимаем текущий член ряда,кладем в xmm7
	addsd	xmm8, xmm9				# прибавляем 1 к iter, храним в xmm8
	inc		rcx				# Увеличиваем число на 1, чтобы следующий член ряда был прибавлен
	add		r8, 2				# прибавляем 2 к значению в r8
	movapd	xmm0, xmm7
	subsd	xmm0, xmm11
	movsd	xmm1, QWORD PTR .LC3[rip]
	andpd	xmm0, xmm1
	comisd	xmm0, xmm6				# Проверяем, не достигли ли мы результа с необходимой точностью
	ja	.L2					# Если нет, то переходим к .L2
	jmp	end					# Иначе переходим к метке end
odd:
	divsd	xmm10, xmm14				# Делим x^(2 * iter - 1) на 2 * iter - 1, результат записываем в xmm10
	addsd	xmm7, xmm10				# Прибавляем текущий член ряда,кладем в xmm7
	addsd	xmm8, xmm9				# прибавляем 1 к iter, храним в xmm8
	inc		rcx				# Увеличиваем число на 1, чтобы следующий член ряда был прибавлен
	add		r8, 2				# прибавляем 2 к значению в r8
	movapd	xmm0, xmm7
	subsd	xmm0, xmm11
	movsd	xmm1, QWORD PTR .LC3[rip]
	andpd	xmm0, xmm1
	comisd	xmm0, xmm6				# Проверяем, не достигли ли мы результа с необходимой точностью
	ja	.L2					# прибавляем 2 к значению в r8 
end:
	movapd	xmm0, xmm7				# Кладем в xmm0 найденное значение

	add rsp, 32
	mov rsp, rbp
	pop rbp
	ret
	.section	.rodata
.LC5:
	.string	"%lf"
.LC6:
	.string	"Incorrect input"
.LC8:
	.string	"%lf\n"
	.text
	.globl	main
main:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32

	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax

	lea	rsi, -24[rbp]				# Загружаем адрес переменной double x (второй фактический)
	lea	rdi, .LC5[rip]				# Будет введено числа типа double (первый фактический)
	mov	eax, 0
	call	__isoc99_scanf@PLT			# Вызов функции ввода
	movsd	xmm8, QWORD PTR -24[rbp]		# В xmm3 будем хранить введенное число (переменная double x)

	movq	xmm1, QWORD PTR .LC3[rip]
	movapd	xmm0, xmm8
	andpd	xmm0, xmm1
	movsd	xmm1, QWORD PTR .LC1[rip]
	comisd	xmm0, xmm1
	jbe	.L11
	lea	rdi, .LC6[rip]
	call	puts@PLT				# Делаем проверку на принадлежность от -1 до 1 (88 - 95 строки), если число находится вне диапазона, то выводим сообщение о неверном вводе
	mov	eax, 0
	jmp	.L8					# Завершили программу с кодом 0, переход к .L8
.L11:
	movsd	xmm9, QWORD PTR .LC7[rip]		# В xmm4 храним точность (переменная double accuracy)

	movapd	xmm1, xmm9				# Передаем вторым фактическим параметром переменную double accuracy
	movapd	xmm0, xmm8				# Передаем первым фактическим параметром переменную double x
	call	calcAtan				# Вызываем функцию

	lea	rdi, .LC8[rip]				# Передаем первым фактическим параметром информацию о типе числа double
	mov	eax, 1
	call	printf@PLT				# Вывод на экран
	mov	eax, 0					# Завершение программы с кодом 0
.L8:
	mov	rdx, QWORD PTR -8[rbp]
	sub	rdx, QWORD PTR fs:40
	je	.L9
	call	__stack_chk_fail@PLT
.L9:
	leave
	ret

	.section	.rodata
	.align 8
.LC0:
	.long	0
	.long	1073741824
	.align 8
.LC1:
	.long	0
	.long	1072693248
	.align 16
.LC3:
	.long	-1
	.long	2147483647
	.long	0
	.long	0
	.align 8
.LC7:
	.long	-755914244
	.long	1061184077
