	.386
	.model small,C
	.data
	.code
	public search
search proc,var1:dword,var2:dword
	mov ecx,1000
	mov edi,var1
nextstu:lea esi,var2
	mov edx,10
nextsb:mov al,byte ptr[esi]
	mov bl,byte ptr[edi]
	cmp al,bl
	jnz next
	cmp al,0
	jz ave
	dec edx
	inc edi
	inc esi
	jmp nextsb
next:dec ecx
	jz again2      
	mov edx, 14;; add edx, 8 mov edx, 28
	add edi,edx
	jmp nextstu
ave: 
	add edi, edx
	mov al,byte ptr[edi]
	mov ah,0
	shl ax,1
	shl ax,1
	mov bl,byte ptr[edi+1]
	mov bh,0
	shl bx,1
	add ax,bx
	mov bl,byte ptr[edi+2]
	mov bh,0
	add ax,bx
	mov bl,7
	div bl
	mov ah,0
	mov dword ptr[edi+3],eax
again2:
	ret
search endp
	end