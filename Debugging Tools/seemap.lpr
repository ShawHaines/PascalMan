program seemap;
uses crt;
var
  map:array[1..10,1..16]of boolean;
  bean:array[1..16,1..10]of boolean;
  i,j,k,l,bn,x,y:byte;
  a:char;
procedure createmap;
begin
  fillchar(map,sizeof(map),true);
  for i:=1 to 16 do
  begin
    map[1,i]:=false;
    map[10,i]:=false;
  end;
  for i:=2 to 9 do
  begin
    map[i,1]:=false;
    map[i,16]:=false;
  end;
  map[2,1]:=true;  map[6,1]:=true;  map[2,16]:=true;
  map[6,16]:=true;  map[2,3]:=false;  map[2,7]:=false;
  map[2,10]:=false;  map[2,14]:=false;  map[3,3]:=false;
  map[3,5]:=false;  map[3,7]:=false;  map[3,8]:=false;
  map[3,10]:=false;  map[3,12]:=false;  map[3,14]:=false;
  map[5,3]:=false;   map[5,4]:=false;   map[5,6]:=false;
  map[5,8]:=false;  map[5,9]:=false;  map[5,11]:=false;
  map[5,12]:=false;  map[5,14]:=false;  map[6,8]:=false;
  map[6,9]:=false;   map[7,3]:=false;   map[7,4]:=false;
  map[7,6]:=false;   map[7,11]:=false;   map[7,13]:=false;
  map[7,14]:=false;   map[8,3]:=false;   map[8,4]:=false;
  map[8,8]:=false;    map[8,9]:=false;   map[8,13]:=false;
  map[8,14]:=false;   map[9,6]:=false;   map[9,11]:=false;
  textbackground(white);
  textcolor(yellow);
  clrscr;
  fillchar(bean,sizeof(bean),true);
  bn:=0;
  for i:=1 to 10 do
  begin
    for j:=1 to 16 do
      if not map[i,j] then
      begin
        textbackground(black);
        write('  ')
      end else
      begin
        inc(bn);
        textbackground(white);
        write('. ');
      end;
    writeln;
  end;
end;
begin
  createmap;
  x:=1;
  y:=1;
  while 1=1 do
  begin
    textcolor(white);
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
      textbackground(white);
      write('  ');
      if x>1 then x:=x-1;
      end;
    32:begin
      textbackground(black);
      write('  ');
      inc(x);
      end;
    else begin
      textbackground(black);
      write(a);
      inc(x);
      end;
    end;
    textbackground(white);
    textcolor(black);
    gotoxy(28,11);
    write(x:3,',',y,'  ');
    gotoxy(x*2-1,y);
  end;
end.
