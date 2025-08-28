= Debugueo

Encontrar el error en este programa (1 solo)

Se hace el calculo $(n_1/7 + n_2 * 2^8 + n_1)$ y deja el valor en memoria

El programa no funciona

- lea (Load Effective Address)

Resuelve la direccion

- sal (Shift Aritmetic Left)

Es un desplazamiento a la izquierda para operadores con signo

```asm

section .text
global _start
extern div_y_suma

_start:
  lea esi, [n_1]
  mov eax, [esi]
  sal dword [esi + 4], 8

  push eax
  push dword [esi + 4]
  call div_y_suma
  add esp, 8
  add [esi + 8], eax
  pop ebx
  add [esi + 8], ebx

  mov eax, 1
  int 0x80

section .data
  n_1: dd 49
  n_2: dd 6
  resultado: dd 0

```

Luego en otro archivo
```asm

section .text
global div_y_suma

;; deja en eax el resultado

div_y_suma:
  push ebp
  mov ebp, esp

  mov eax, [ebp + 12]
  mov edx, 0
  mov ecx, 7
  div ecx

  add eax, [ebp + 8]
  mov esp, ebp
  pop ebp
  ret

```

