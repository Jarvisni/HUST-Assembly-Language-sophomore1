stack segment stack
stack ends
data segment
N    equ 1000
BUF  db 'ZhangSan',0,0  ;学生姓名，不足10个字节的部分用0填充
	 db   100, 85, 80,?    ;平均成绩还未计算
	 db 'LiSi',6 dup(0) 
	 db   80, 100, 70,?
	 db N-3 dup('TempValue',0,80,90,95,?); 除了已经定义了的学生信息及成绩表外，其他学生的暂时成绩假定是一样的
	 db 'YangAo', 4 dup(0)   ;最后一个必须修改为自己名字的拼音
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
	   mov bh,7                  ;平均成绩计算公式：（A*2+B+C/2）/ 3.5,把小数3.5转换成7/2再运算以避免使用浮点指令。
       div bh	   
	   mov byte ptr[si+13],al    ;使用算术运算相关指令计算并保存每一个学生的平均成绩。
	   add si,14
	   dec di
	   jne ave	   

begin: mov si,offset BUF
       mov di,offset in_name
	   mov dx,offset MES1
	   mov ah,9
	   int 21h   ;使用9号DOS系统功能调用，提示用户输入学生姓名。
	   lea dx,in_name
	   mov ah,10
	   int 21h   ;使用10号DOS系统功能调用，输入学生姓名。
	   mov bl,in_name+1
	   cmp bl,0
	   je begin  ;若只是输入了回车，则回到“（1）”处重新提示并输入
	   cmp bl,1
	   je pan    ;进入pan进行判定仅输入的一个字符是否为q，若仅仅输入字符q，则程序退出
       mov cx,1000
BiJiao:mov dl,in_name+1
	   mov dh,0
lop:   mov bl,in_name+1
	   mov bh,0
	   sub bx,dx
	   mov al,byte ptr[si+bx]     ;数据段中的名字
	   mov ah,byte ptr[di+bx+2]   ;输入的名字
	   cmp ah,'A'
	   jb wrong     ;输入非字母则出错
	   cmp ah,'z'
	   ja wrong     ;输入非字母则出错
	   cmp ah,'a'
	   jae equal1
	   cmp ah,'Z'
	   jbe equal1
equal1: cmp ah,al
       jne gonext     ;不相等则到下一个名字
	   dec dx    
	   jne lop        ;相等则下一个字母        
	   mov ah,byte ptr[si+bx+1]
       cmp ah,0      ;判断成绩表中名字串的下一个字符是否是结束符0
	   jne gonext
	   mov POIN,si   ;若找到，则将该学生课程成绩表的起始偏移地址保存到POIN字变量中。           
	   jmp judge
gonext:add si,14    ;到下一个名字
       mov dl,in_name+1
	   mov dh,0
	   dec cx       ;cx计数名字剩余，未比较完则回去比较下一个
	   jnz lop
	   mov dx,offset MES2
	   mov ah,9
	   int 21h       
	   jmp begin      ;若未找到，提示用户该学生不存在，并回到“功能一（1）”的位置
judge: mov bx,POIN
       mov al,[bx+13]
	   cmp al,90      
	   jae lvA        ;若平均成绩大于等于90分，显示“A”
	   cmp al,80      
	   jae lvB		  ;大于等于80分，显示“B”
	   cmp al,70      
	   jae lvC		  ;大于等于70分，显示“C”
	   cmp al,60      
	   jae lvD		  ;大于等于60分，显示“D”
	   mov dl,0ah
	   mov ah,2
	   int 21h
	   mov dl,0dh
	   mov ah,2
	   int 21h
	   mov dl,'F'	  ;小于60分，显示“F”。
	   mov ah,2
	   int 21h
	   jmp begin      ;使用转移指令回到“功能一（1）”处
lvA:   mov dl,0ah
	   mov ah,2
	   int 21h
	   mov dl,0dh
	   mov ah,2
	   int 21h
	   mov dl,'A'	
	   mov ah,2
	   int 21h
	   jmp begin      ;使用转移指令回到“功能一（1）”处     
lvB:	mov dl,0ah
	   mov ah,2
	   int 21h
	   mov dl,0dh
	   mov ah,2
	   int 21h
	   mov dl,'B'	
	   mov ah,2
	   int 21h
	   jmp begin      ;使用转移指令回到“功能一（1）”处
lvC:	mov dl,0ah
	   mov ah,2
	   int 21h
	   mov dl,0dh
	   mov ah,2
	   int 21h
	   mov dl,'C'	
	   mov ah,2
	   int 21h
	   jmp begin      ;使用转移指令回到“功能一（1）”处
LvD:	mov dl,0ah
	   mov ah,2
	   int 21h
	   mov dl,0dh
	   mov ah,2
	   int 21h
	   mov dl,'D'	
	   mov ah,2
	   int 21h
	   jmp begin      ;使用转移指令回到“功能一（1）”处

pan:   mov al,in_name+2  ;当输入的只有一个字母时判断是不是q，不是q则比较
	   cmp al,'q'
	   je done
	   jmp BiJiao
wrong: mov dx,offset MES4  ;采用9号中断显示错误信息
       mov ah,9
	   int 21h
	   jmp begin
done:  mov dx,offset MES3  ;采用9号中断显示再见信息
       mov ah,9
	   int 21h
       mov ax,4c00h
	   int 21h
code ends
	 end start




