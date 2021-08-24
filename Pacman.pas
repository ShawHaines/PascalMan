program Pacman;
uses crt;
const
  dx:array[1..4]of shortint=(0,0,-1,1);//方向：上下左右
  dy:array[1..4]of shortint=(1,-1,0,0);
type
  location=record
    x,y:byte;
  end;
var
  map:array[1..10,1..16]of boolean;
  bean:array[1..16,1..10]of boolean;
  i,k,l,bn,time,gn:byte;
  j:word;
  ghost:array[1..5]of location;
  me:location;
  bool:boolean;
  path:array[1..16,1..10]of byte;
procedure fill(a:location; b:byte);//把周围四个方向上标数
var
  i:byte;
begin
  for i:=1 to 4 do
  begin
    if (map[a.y+dy[i],a.x+dx[i]]) and (path[a.x+dx[i],a.y+dy[i]]=0) then
    path[a.x+dx[i],a.y+dy[i]]:=b;
  end;
end;
function ai(now,want:location):byte;
var
  a:location;
  x,y:byte;
  k,di:byte;
procedure find(now:location);
var
  i:byte;
begin
  if path[now.x,now.y]>2 then
  for i:=1 to 4 do begin
  if path[now.x+dx[i],now.y+dy[i]]=path[now.x,now.y]-1
  then begin
    now.x:=now.x+dx[i];
    now.y:=now.y+dy[i];
    find(now);
    break;
  end;
  end else for i:=1 to 4 do
  if path[now.x+dx[i],now.y+dy[i]]=1 then begin
    di:=i;
    break;
  end;
end;

begin
  fillchar(path,sizeof(path),0);
  path[now.x,now.y]:=1;
  fill(now,2);
  k:=1;
  repeat
    inc(k);
    for x:=1 to 16 do
    for y:=1 to 10 do
    if path[want.x,want.y]>0 then break else
    if path[x,y]=k then begin
      a.x:=x;
      a.y:=y;
      fill(a,k+1);
    end;
  until path[want.x,want.y]>0;
  find(want);
  case di of
  1:ai:=2;
  2:ai:=1;
  3:ai:=4;
  4:ai:=3;
  end;
end;
procedure originalizedata;
begin
  fillchar(bean,sizeof(bean),true);
  bn:=80;
  ghost[1].x:=2;ghost[1].y:=2;
  ghost[2].x:=9;ghost[2].y:=2;
  ghost[3].x:=15;ghost[3].y:=2;
  ghost[4].x:=15;ghost[4].y:=6;
  ghost[5].x:=2;ghost[5].y:=6;
  me.x:=8;me.y:=9;
  bean[me.x,me.y]:=false;
end;
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
  for i:=1 to 10 do
  begin
    for j:=1 to 16 do
      if not map[i,j] then
      begin
        textbackground(black);
        write('  ')
      end else begin
      textbackground(white);
      if bean[j,i] then write('. ')
      else write('  ');
      end;
    writeln;
  end;
  textbackground(white);
  textcolor(red);
  for k:=1 to gn do
  begin
    gotoxy(ghost[k].x*2-1,ghost[k].y);
    write('*');
  end;
  gotoxy(me.x*2-1,me.y);
  textcolor(green);
  write('*');
  gotoxy(me.x*2-1,me.y);
end;
procedure menu;
var
  a1:boolean;
  b:char;
procedure options(var gn,time:byte);
var
  a:boolean;
begin
  a:=true;//初始在Ghost
  window(21,2,38,10);
  textbackground(black);
  textcolor(white);
  clrscr;
  window(1,1,80,25);
  highvideo;
  gotoxy(27,3);
  write('Ghosts');
  gotoxy(28,4);
  write('< ',gn,' >');
  lowvideo;
  gotoxy(25,6);
  write('Seconds per');
  gotoxy(28,7);
  write('step');
  gotoxy(27,8);
  write('<',time/100:4:2,' >');
  gotoxy(6,3);
  write(' Press Esc ');
  gotoxy(7,4);
  write(' to Menu ');
  gotoxy(8,8);
  write('Options');
  while true do begin
    while not keypressed do;
    case ord(readkey) of
    27:exit;
    0:case ord(readkey) of
      72,80:begin
        a:=not a;
        if a then begin
          highvideo;
          gotoxy(27,3);
          write('Ghosts');
          gotoxy(28,4);
          write('< ',gn,' >');
          lowvideo;
          gotoxy(25,6);
          write('Seconds per');
          gotoxy(28,7);
          write('step');
          gotoxy(27,8);
          write('<',time/100:4:2,' >');
        end else begin
          lowvideo;
          gotoxy(27,3);
          write('Ghosts');
          gotoxy(28,4);
          write('< ',gn,' >');
          highvideo;
          gotoxy(25,6);
          write('Seconds per');
          gotoxy(28,7);
          write('step');
          gotoxy(27,8);
          write('<',time/100:4:2,' >');
        end;
      end;
      75:if a then
      begin
        if gn>1 then begin
          dec(gn);
          gotoxy(32,4);
          highvideo;
          write('>');
        end
        else
        begin
          gotoxy(28,4);
          lowvideo;
          write('<');
        end;
        highvideo;
        gotoxy(30,4);
        write(gn);
        end else begin
          if time>20 then begin
            dec(time,5);
            highvideo;
            gotoxy(33,8);
            write('>');
          end else
          begin
            gotoxy(27,8);
            lowvideo;
            write('<');
          end;
          gotoxy(28,8);
          highvideo;
          write(time/100:4:2);
        end;
      77:if a then
      begin
        if gn<5 then begin
          inc(gn);
          gotoxy(28,4);
          highvideo;
          write('<');
        end else
        begin
          gotoxy(32,4);
          lowvideo;
          write('>');
        end;
        highvideo;
        gotoxy(30,4);
        write(gn);
      end else begin
        if time<150 then begin
          inc(time,5);
          highvideo;
          gotoxy(27,8);
          write('<');
        end else
        begin
          gotoxy(33,8);
          lowvideo;
          write('>');
        end;
        gotoxy(28,8);
        highvideo;
        write(time/100:4:2);
      end;
      else continue;
    end;
    else continue;
    end;
  end;
end;
begin
  a1:=false;
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
  while true do begin
  while not keypressed do;
  case ord(readkey) of
  27:halt;
  0:begin
    b:=readkey;
    if (ord(b)=77)or(ord(b)=75)
    then a1:=(not a1);
    end;
  13:if (not a1) then exit else begin
    options(gn,time);
    window(21,2,38,10);
    textbackground(black);
    clrscr;
    window(1,1,80,25);
    highvideo;
    gotoxy(25,6);
    write('Start Game');
  end
  else continue;
  end;
  if a1 then begin
    gotoxy(8,8);
    highvideo;
    write('Options');
    gotoxy(25,6);
    lowvideo;
    write('Start Game');
  end else
  begin
    gotoxy(8,8);
    lowvideo;
    write('Options');
    gotoxy(25,6);
    highvideo;
    write('Start Game');
  end;
  end;
end;
procedure pause;
var
  a:byte;
procedure options;
begin
  textbackground(white);
  clrscr;
  window(21,2,38,10);
  textbackground(black);
  textcolor(white);
  clrscr;
  window(2,2,19,5);
  clrscr;
  window(2,7,19,10);
  clrscr;
  window(1,1,80,25);
  lowvideo;
  gotoxy(27,3);
  write('Ghosts');
  gotoxy(28,4);
  write('< ',gn,' >');
  gotoxy(6,3);
  write(' Press Esc ');
  gotoxy(7,4);
  write(' to Menu ');
  gotoxy(8,8);
  write('Options');
  highvideo;
  gotoxy(25,6);
  write('Seconds per');
  gotoxy(28,7);
  write('step');
  gotoxy(27,8);
  write('<',time/100:4:2,' >');
  while true do begin
    while not keypressed do;
    case ord(readkey) of
    27:exit;
    0:case ord(readkey) of
      75:begin
          if time>20 then begin
            dec(time,5);
            highvideo;
            gotoxy(33,8);
            write('>');
          end else
          begin
            gotoxy(27,8);
            lowvideo;
            write('<');
          end;
          gotoxy(28,8);
          highvideo;
          write(time/100:4:2);
        end;
      77:begin
        if time<150 then begin
          inc(time,5);
          highvideo;
          gotoxy(27,8);
          write('<');
        end else
        begin
          gotoxy(33,8);
          lowvideo;
          write('>');
        end;
        gotoxy(28,8);
        highvideo;
        write(time/100:4:2);
      end;
      else continue;
    end;
    else continue;
    end;
  end;
end;

begin
  bool:=true;
  window(7,1,25,10);
  textbackground(black);
  clrscr;
  textcolor(white);
  gotoxy(1,1);
  for i:=7 to 25 do write('-');
  gotoxy(7,1);
  write('Paused');
  gotoxy(7,5);
  write('Options');
  gotoxy(8,7);
  write('Menu');
  gotoxy(8,9);
  write('Quit');
  gotoxy(8,3);
  write('Back');
  gotoxy(5,3);
  write('>');
  a:=1;
  while true do begin
    while not keypressed do;
    case ord(readkey) of
    27:begin window(1,1,80,25);createmap;exit;end;
    13:case a of
       1:begin window(1,1,80,25);createmap;exit;end;
       2:begin
         window(1,1,80,25);
         options;
         createmap;
         window(7,1,25,10);
         textbackground(black);
         clrscr;
         textcolor(white);
         gotoxy(1,1);
         for i:=7 to 25 do write('-');
         gotoxy(7,1);
         write('Paused');
         gotoxy(7,5);
         write('Options');
         gotoxy(8,7);
         write('Menu');
         gotoxy(8,9);
         write('Quit');
         gotoxy(8,3);
         write('Back');
         gotoxy(5,3);
         write('>');
         a:=1;
       end;
       3:begin window(1,1,80,25);bool:=false;exit;end;
       4:halt;
      end;
    0:begin
      gotoxy(5,a*2+1);
      write(' ');
      case ord(readkey) of
      80:if a<4 then inc(a) else a:=1;
      72:if a>1 then dec(a) else a:=4;
      else continue;
      end;
      end;
    else continue;
    end;
    gotoxy(5,2*a+1);
    write('>');
  end;
end;
procedure gamecontrol;
begin
  repeat
    delay(10);
    inc(j);
    if keypressed then
    case ord(readkey)of
    0:begin
      write(' ');
      case ord(readkey) of
      80:if map[me.y+1,me.x] then inc(me.y);
      72:if (me.y>1)and (map[me.y-1,me.x]) then me.y:=me.y-1;
      75:if (me.x>1) and (map[me.y,me.x-1]) then me.x:=me.x-1
         else if(me.x=1)and((me.y=2)or(me.y=6))then
         me.x:=16;
      77:if map[me.y,me.x+1] then inc(me.x)
        else if(me.x=16)and((me.y=2)or(me.y=6)) then
        me.x:=1;
      end;
      if bean[me.x,me.y] then begin
        dec(bn);
        bean[me.x,me.y]:=false;
      end;
      gotoxy(me.x*2-1,me.y);
      textcolor(green);
      write('*');
      gotoxy(me.x*2-1,me.y);
    end;
    27:begin
      pause;
      if not bool then exit;
    end
    else continue;
    end;
    if j=time then
    begin
      j:=0;
      for k:=1 to gn do
      begin
        gotoxy(ghost[k].x*2-1,ghost[k].y);
        if not bean[ghost[k].x,ghost[k].y] then
        write(' ') else begin
          textcolor(yellow);
          write('.');
          end;
        i:=ai(ghost[k],me);
        inc(ghost[k].x,dx[i]);
        inc(ghost[k].y,dy[i]);
        for l:=1 to gn do
        if l=k then continue else
        if (ghost[l].x=ghost[k].x)and(ghost[l].y=ghost[k].y)
        then begin
          dec(ghost[k].x,dx[i]);
          dec(ghost[k].y,dy[i]);
          break;
        end;
        gotoxy(ghost[k].x*2-1,ghost[k].y);
        textcolor(red);
        write('*');
      end;
      gotoxy(me.x*2-1,me.y);
    end;
    for k:=1 to gn do
      if (me.x=ghost[k].x)and(me.y=ghost[k].y) then
      begin
        clrscr;
        gotoxy(12,5);
        textcolor(black);
        write('GAME OVER');
        gotoxy(6,6);
        write('Press Enter to continue...');
        readln;
        exit;
      end;
  until bn=0;
  clrscr;
  gotoxy(12,5);
  textcolor(black);
  write('YOU WIN!');
  gotoxy(6,6);
  write('Press Enter to continue...');
  readln;
end;
begin
  cursoroff;
  time:=100;gn:=3;
  menu;
  while true do
  begin
    originalizedata;
    createmap;
    gamecontrol;
    menu;
  end;
end.
