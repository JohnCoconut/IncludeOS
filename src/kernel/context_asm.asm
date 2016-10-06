; This file is a part of the IncludeOS unikernel - www.includeos.org
;
; Copyright 2015 Oslo and Akershus University College of Applied Sciences
; and Alfred Bratterud
;
; Licensed under the Apache License, Version 2.0 (the "License");
; you may not use this file except in compliance with the License.
; You may obtain a copy of the License at
;
;     http://www.apache.org/licenses/LICENSE-2.0
;
; Unless required by applicable law or agreed to in writing, software
; distributed under the License is distributed on an "AS IS" BASIS,
; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
; See the License for the specific language governing permissions and
; limitations under the License.
USE32
global __context_switch
extern __context_switch_delegate

section .text

__context_switch:
    push ebp
    mov  ebp, esp
    ; save special purpose stuff
    push esi
    push edi

    ; new stack location in EBX
    mov ebx, [ebp+8]

    ; save current ESP for later
    mov  eax, esp
    ; change to new stack
    mov  esp, ebx
    ; store old ESP on new stack
    push eax
    ; call function that sees the delegate
    call __context_switch_delegate
    ; restore old stack
    pop  esp

    ; restore special stuff
    pop  edi
    pop  esi

    ; return to origin
    pop  ebp
    ret
