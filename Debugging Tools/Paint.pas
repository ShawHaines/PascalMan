program Paint;
uses crt;
var
  i,j:byte;
  a:char;
  x,y:byte;
procedure menu;
var
  a:boolean;
  b:char;
begin
  a:=false;
  textbackground(white);
  clrscr;
  textbackground(black);
  textcolor(white);
  gotoxy(2,2);
  for i:=3 to 6 do
  begin
    for j:=1 to 9 do
    write('  ');
    gotoxy(2,i);
  end;
  for i:=7 to 10 do
  begin
    gotoxy(2,i);
    for j:=1 to 9 do
    write('  ');
  end;
  for i:=2 to 10 do
  begin
    gotoxy(21,i);
    for j:=1 to 9 do
    write('  ');
  end;
  lowvideo;
  gotoxy(6,3);
  write('Press Enter');
  gotoxy(7,4);
  write('to select');
  gotoxy(8,8);
  write('Options');
  highvideo;
  gotoxy(25,6);
  write('Start Game');
end;
procedure options;
begin
  window(21,2,38,12);
  textbackground(black);
  textcolor(white);
  clrscr;
  window(1,1,80,25);
  highvideo;
  gotoxy(27,3);
  write('Ghosts');
  gotoxy(28,4);
  write('< 3 >');
  lowvideo;
  gotoxy(25,6);
  write('Seconds per');
  gotoxy(28,7);
  write('step');
  gotoxy(27,8);
  write('< 1.0 >');
  gotoxy(6,3);
  write(' Press Esc ');
  gotoxy(7,4);
  write(' to Menu ');
  gotoxy(8,8);
  write('Options');
end;
procedure pause;
var
  a:byte;
begin
  window(7,1,25,11);
  textbackground(black);
  clrscr;
  textcolor(white);
  lowvideo;
  gotoxy(1,1);
  for i:=7 to 25 do write('-');
  gotoxy(7,1);
  write('Paused');
  gotoxy(7,5);
  write('Options');
  gotoxy(7,7);
  write('Restart');
  gotoxy(8,9);
  write('Quit');
  highvideo;
  gotoxy(5,3);
  write('> Return');
end;

begin
  {menu;
  options;}
  pause;
  x:=1;y:=1;
  gotoxy(x,y);
  while 1=1 do
  begin
    while not keypressed do;
    a:=readkey;
    case ord(a) of
    0:case ord(readkey) of
      80:inc(y);
      72:if y>1 then y:=y-1;
      75:if x>1 then x:=x-1;
      77:inc(x);
      end;
    8:begin
      textbackground(black);
      write(' ');
      if x>1 then x:=x-1;
      end;
    32:begin
      textbackground(black);
      write(' ');
      inc(x);
      end;
    else begin
      textbackground(black);
      write(a);
      inc(x);
      end;
    end;
    textbackground(black);
    textcolor(white);
    gotoxy(1,11);
    write(x:3,',',y,'  ');
    gotoxy(x,y);
  end;
end.
