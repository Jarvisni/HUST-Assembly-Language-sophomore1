stack segment stack
stack ends
data segment
N    equ 1000
BUF  db 'ZhangSan',0,0  ;ѧ������������10���ֽڵĲ�����0���
	 db   100, 85, 80,?    ;ƽ���ɼ���δ����
	 db 'LiSi',6 dup(0) 
	 db   80, 100, 70,?
	 db N-3 dup('TempValue',0,80,90,95,?); �����Ѿ������˵�ѧ����Ϣ���ɼ����⣬����ѧ������ʱ�ɼ��ٶ���һ����
	 db 'YangAo', 4 dup(0)   ;���һ�������޸�Ϊ�Լ����ֵ�ƴ��
	 db   100,100,100,?  
	 MES1  db 0ah,0dh,'Please type in a name',0ah,0dh,'$'
	 MES2  db 0ah,0dh,'404 not found',0ah,0dh,'$'
	 MES3  db 0ah,0dh,'Goodbye!',0ah,0dh,'$'
	 MES4  db 0ah,0dh,'Wrong!',0ah,0dh,'$'
	 in_name db 10,?,10 dup(?)
	 POIN  dw 0
data ends
code segment 'code'
       assume cs:code,ds:data,ss:stack
start: mov ax,data
	   mov ds,ax
	   mov si,offset BUF
	   mov di,1000
ave:   mov al,byte ptr[si+10]
	   mov ah,0
	   mov bl,byte ptr[si+11]
	   mov bh,0
	   mov cl,byte ptr[si+12]
       mov ch,0
	   sal ax,1
	   sal ax,1
	   sal bx,1
	   add ax,bx
	   add ax,cx
	   mov bh,7                  ;ƽ���ɼ����㹫ʽ����A*2+B+C/2��/ 3.5,��С��3.5ת����7/2�������Ա���ʹ�ø���ָ�
       div bh	   
	   mov byte ptr[si+13],al    ;ʹ�������������ָ����㲢����ÿһ��ѧ����ƽ���ɼ���
	   add si,14
	   dec di
	   jne ave	   

begin: mov si,offset BUF
       mov di,offset in_name
	   mov dx,offset MES1
	   mov ah,9
	   int 21h   ;ʹ��9��DOSϵͳ���ܵ��ã���ʾ�û�����ѧ��������
	   lea dx,in_name
	   mov ah,10
	   int 21h   ;ʹ��10��DOSϵͳ���ܵ��ã�����ѧ��������
	   mov bl,in_name+1
	   cmp bl,0
	   je begin  ;��ֻ�������˻س�����ص�����1������������ʾ������
	   cmp bl,1
	   je pan    ;����pan�����ж��������һ���ַ��Ƿ�Ϊq�������������ַ�q��������˳�
       mov cx,1000
BiJiao:mov dl,in_name+1
	   mov dh,0
lop:   mov bl,in_name+1
	   mov bh,0
	   sub bx,dx
	   mov al,byte ptr[si+bx]     ;���ݶ��е�����
	   mov ah,byte ptr[di+bx+2]   ;���������
	   cmp ah,'A'
	   jb wrong     ;�������ĸ�����
	   cmp ah,'z'
	   ja wrong     ;�������ĸ�����
	   cmp ah,'a'
	   jae equal1
	   cmp ah,'Z'
	   jbe equal1
equal1: cmp ah,al
       jne gonext     ;���������һ������
	   dec dx    
	   jne lop        ;�������һ����ĸ        
	   mov ah,byte ptr[si+bx+1]
       cmp ah,0      ;�жϳɼ��������ִ�����һ���ַ��Ƿ��ǽ�����0
	   jne gonext
	   mov POIN,si   ;���ҵ����򽫸�ѧ���γ̳ɼ������ʼƫ�Ƶ�ַ���浽POIN�ֱ����С�           
	   jmp judge
gonext:add si,14    ;����һ������
       mov dl,in_name+1
	   mov dh,0
	   dec cx       ;cx��������ʣ�࣬δ�Ƚ������ȥ�Ƚ���һ��
	   jnz lop
	   mov dx,offset MES2
	   mov ah,9
	   int 21h       
	   jmp begin      ;��δ�ҵ�����ʾ�û���ѧ�������ڣ����ص�������һ��1������λ��
judge: mov bx,POIN
       mov al,[bx+13]
	   cmp al,90      
	   jae lvA        ;��ƽ���ɼ����ڵ���90�֣���ʾ��A��
	   cmp al,80      
	   jae lvB		  ;���ڵ���80�֣���ʾ��B��
	   cmp al,70      
	   jae lvC		  ;���ڵ���70�֣���ʾ��C��
	   cmp al,60      
	   jae lvD		  ;���ڵ���60�֣���ʾ��D��
	   mov dl,0ah
	   mov ah,2
	   int 21h
	   mov dl,0dh
	   mov ah,2
	   int 21h
	   mov dl,'F'	  ;С��60�֣���ʾ��F����
	   mov ah,2
	   int 21h
	   jmp begin      ;ʹ��ת��ָ��ص�������һ��1������
lvA:   mov dl,0ah
	   mov ah,2
	   int 21h
	   mov dl,0dh
	   mov ah,2
	   int 21h
	   mov dl,'A'	
	   mov ah,2
	   int 21h
	   jmp begin      ;ʹ��ת��ָ��ص�������һ��1������     
lvB:	mov dl,0ah
	   mov ah,2
	   int 21h
	   mov dl,0dh
	   mov ah,2
	   int 21h
	   mov dl,'B'	
	   mov ah,2
	   int 21h
	   jmp begin      ;ʹ��ת��ָ��ص�������һ��1������
lvC:	mov dl,0ah
	   mov ah,2
	   int 21h
	   mov dl,0dh
	   mov ah,2
	   int 21h
	   mov dl,'C'	
	   mov ah,2
	   int 21h
	   jmp begin      ;ʹ��ת��ָ��ص�������һ��1������
LvD:	mov dl,0ah
	   mov ah,2
	   int 21h
	   mov dl,0dh
	   mov ah,2
	   int 21h
	   mov dl,'D'	
	   mov ah,2
	   int 21h
	   jmp begin      ;ʹ��ת��ָ��ص�������һ��1������

pan:   mov al,in_name+2  ;�������ֻ��һ����ĸʱ�ж��ǲ���q������q��Ƚ�
	   cmp al,'q'
	   je done
	   jmp BiJiao
wrong: mov dx,offset MES4  ;����9���ж���ʾ������Ϣ
       mov ah,9
	   int 21h
	   jmp begin
done:  mov dx,offset MES3  ;����9���ж���ʾ�ټ���Ϣ
       mov ah,9
	   int 21h
       mov ax,4c00h
	   int 21h
code ends
	 end start




