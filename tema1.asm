%include "io.inc"

section .data
    %include "input.inc"
    

section .text
global CMAIN
CMAIN:
    mov ebp, esp
    xor ecx, ecx
    
    while:
        ; numarul ce trebuie convertit
        mov eax, [nums_array + ecx * 4]
        ; baza in care trebuie convertit numarul
        mov ebx, [base_array + ecx * 4]
        
        xor edx, edx 
        
        ; Verific daca baza este valida
        cmp ebx, 1
        je baza_incorecta
        cmp ebx, 16
        jg baza_incorecta
        
        ; Fac impartiri succesive la baza a numarului, apoi la caturi
        ; Salvez fiecare rest pe stiva
        imparte:
            div ebx
            push edx
            xor edx, edx
            cmp eax, 0
        jg imparte
        
        PRINT:
            ; Scot fiecare element de pe stiva
            pop eax
            cmp eax, 9
            jg PRINT2
            ; Daca este cifra o afisez
            add eax, 48
            PRINT_CHAR ax
            jmp skip
            ; Daca este un numar mai mare decat 9 voi afisa litera corespunzatoare
            PRINT2:
                ; Adun 87 pentru a obtine codul ASCII a literei
                add eax, 87
                PRINT_CHAR ax
            skip:
            cmp esp, ebp
            ; Repet operatia pana cand stiva va fi goala
        jl  PRINT
        jmp end
        
        ; Mesajul ce trebuie afisat in cazul in care baza 
        ; este incorecta
        baza_incorecta:
            PRINT_STRING "Baza incorecta"
            
        end:
        
        ; Trec la urmatorul numar din vector
        inc ecx
        cmp ecx, dword [nums]
        jl next
        
        next:
            ; Afisez newline doar daca mai exista numere in vector
            NEWLINE
            jl while
    
    
    mov esp, ebp
    xor eax, eax
    ret