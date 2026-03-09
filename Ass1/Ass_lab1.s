#3 номер - (A**2+B**2+2AB)/C**2
.global _start
.data
a: .quad 0
b: .quad 0
c: .quad 0
input_str: .asciz "%lu%lu%lu"
output_str: .asciz "Output value: %lu\n"
.text
_start: 
    movq %rsp, %rbp                #сохраняем на стек значения состояние регистра rsp
    subq $32, %rsp                 #выделяем 32 байта на стеке
    andq $-16, %rsp                #обнуляем первые 16 байт
    leaq input_str(%rip), %rdi     #загружаем  адрес строки input_str в rdi
    movq $a, %rsi                  #ввод A
    movq $b, %rdx                  #ввод B
    movq $c, %rcx                  #ввод C
    call scanf

    #посчитать (А+Б) в квадрате
    #a = rxi, b = rdx, c = rcs (содержат адреса? а не значения)
    #+=add, -= sub, /= div, *=mul
    movq (a), %rdi #a = rdi
    movq (b), %rbx #b = rbx
    movq (c), %rax #c = rax

    addq %rdi, %rbx #А + БЕ, сохранено в рбх, рди cвободен
    mul %rax #С в квадрате
    movq %rax, %rdi #выкидываем с в квадрате из рах, чтоб можно было умножить А+БЕЕЕ
    movq %rbx, %rax #закдиываем А+БЕЕЕв рах
    mul %rax #по идее тут А+БЕЕ в квадрате
    div %rdi #по еще одной идее тут А+БЕЕ**2/С**2 и вроде все конец, результат в %рах

    leaq  output_str(%rip), %rdi   #загружаем адрес строки output_str в rdi
    movq %rax, %rsi                #заносим Y в RSI
    xor %eax, %eax                 #обнуляем через xor eax
    call printf                    #вызов печати
    movq %rbp, %rsp                #восстанавливаем значение rsp
    movq $0, %rdi                  #код возврата
    movq $60, %rax                 #вызов функции с номером 60 (exit)
    syscall

