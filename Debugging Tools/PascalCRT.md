# Pascal CRT
```pascal
procedure assigncrt(var f:text);
```
 将文本文件f与显示器CRT建立联系，任何写入f的信息显示在窗口中，而不写入f 
```pascal
function keypressed:boolean;

```
 检测是否有键按下,有则函数值为true ；Shift, Alt, Ctrl不被报告

```pascal
procedure append(var f:text)
```
 在output文件中继续写入，而不抹掉原来的内容。
```pascal
Procedure assign(var f:text,s:string)
```
把input或output设定为s文件名的文件，转回屏幕则令s:=’CON’
```pascal
function readkey:char;
```
 等待从键盘输入一个字符，如果一个扩展键或功能键被按下，则返回ASCLL的0，你可以再调用一次readkey，读取该键键码值（上：072 下：080 左：075 右：077 退格：8空格：32 Esc:27回车：13）。
```pascal
procedure textmode(mode:integer);
```
 设置字符显示模式,mode值见下表,可以用常量标识符或常数值 
```pascal
procedure window(x1,y1,x2,y2:byte);
```
 定义字符窗口:(x1,y1)为左上角坐标,(x2,y2)为右下角坐标;
必须在设置模式允许范围内.窗口定义后,所有显示均在窗口进行 ；window可多次设置。
```pascal
procedure gotoxy(x,y:byte);
```
 将光标移至(x,y)处 
```pascal
function wherex:byte;
```
 返回当前窗口中光标所在的列数(相对当前窗口) 
```pascal
function wherey:byte;
```
 返回当前窗口中光标所在的行数(相对当前窗口) 
```pascal
procedure clrscr;
```
 清除当前窗口或屏幕 （用当前背景色，光标设置在当window的左上角）
```pascal
procedure clreol;
```
 从光标位置开始清除至本行末尾，光标位置不变(不超过窗口右边界)（窗口可由window过程设置，默认80*25的） 
例 
```pascal
procedure insline;
```
 在当前光标处插入一行，光标所在行以及接下去的行都下移一行，导致window底部最后一行消失，光标位置不变 
```pascal
procedure delline;
```
 删除光标所在的当前行 ，接下来的行都上移一行，新的空行插在window的底部，光标位置不变
```pascal
procedure textcolor(color:byte);
```
 设置正文前景颜色 
```pascal
procedure textbackground(color:byte);
```
 设置正文背景颜色 
```pascal
procedure lowvideo;
```
 选择低亮度显示字符 
```pascal
procedure highvideo;
```
 选择高亮度显示字符 
```pascal
procedure normvideo;
```
 选择正常亮度显示字符 

```pascal
Program Example14;
uses Crt;
{ Program to demonstrate the LowVideo, HighVideo, NormVideo functions. }begin LowVideo;
 WriteLn('This is written with LowVideo');
 HighVideo;
 WriteLn('This is written with HighVideo');
 NormVideo;
 WriteLn('This is written with NormVideo');
end.

```


```pascal
procedure delay(ms:word);
```
 等待或延迟ms个毫秒 ，但是实际延迟的时间只是一个近似值，要看电脑运行快慢
```pascal
procedure sound(hz:word);
```
 以hz指定的频率发声 
```pascal
procedure nosound;
```
 关闭内部扬场声器 
```pascal
procedure cursorOff;
```
 隐藏光标 
```pascal
procedure cursorOn;
```
显示光标
```pascal
procedure cursorBig;
```
大光标，但我不知道使用大光标后怎么变回去
0 黑1 深蓝2 绿3 天蓝4 红5 粉6 橙7 白

```pascal
Program Example9;

uses Crt;

{ Program to demonstrate the ClrEol function. }
var
I,J : integer;

begin
For I:=1 to 15 do
    For J:=1 to 80 do
      begin
      gotoxy(j,i);
      Write(j mod 10);
      end;
Window(5,5,75,12);

Write('This line will be cleared from',
        ' here till the right of the window');

GotoXY(27,WhereY);

ReadKey;

ClrEol;

WriteLn;

end.
```