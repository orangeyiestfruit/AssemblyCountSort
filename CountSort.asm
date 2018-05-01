
; Win32 Console Application

format PE Console 4.0
entry Start

include '%finc%\win32\win32a.inc'
include 'Console.inc'

uglobal
  hInstance dd ?
  hHeap     dd ?
endg
.DATA:

Start:
        invoke  GetModuleHandleA,0
        mov     [hInstance],eax
        invoke  GetProcessHeap
        mov     [hHeap], eax
        InitializeAll

        ; TODO: Insert code here

        ; Start of example
        iglobal
        listo dd 2,2,3,5,6,1,2,4,5,1,2,4,1,4,1,4
        zers dd 225 dup (0)
        length1 dd 64     ;how many numbers*4
        length2 dd 28     ;range of numbers from 0 to largest *4
        count dd -1
        eeax dd 0
        endg
        mov eax,0
        mov ebx,[length1]
        mov ecx,0
        redoit:
        mov ecx,[listo+eax]
        add ecx,ecx
        add ecx,ecx
        inc [zers+ecx]
        add eax,4
        cmp ebx,eax
        jne redoit
        ;int3
        ;;;
        ;Bottom part is correct. Top part makes zers 2,0,2,1...
        mov eax,0
        mov ebx,0
        mov ecx,0
        mov edx,0
        redoit2:
        cmp ebx,[length2]
        je done2
        mov eax,[zers+ebx]
        add eax,eax
        add eax,eax
        add edx,eax
        add ebx,4
        inc [count]
        looop:
        cmp edx,ecx
        je redoit2
        mov eax,[count]
        mov [listo+ecx],eax
        add ecx,4
        jmp looop
        done2:
        mov eax,[listo+20]
        int3
        stdcall Console.Input
        ; End of example

Exit:
        push    eax
        FinalizeAll
        invoke  ExitProcess ; exit code from the stack.

data import
  include "%finc%\win32\allimports.asm"
end data

IncludeAllGlobals   
