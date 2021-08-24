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
  i,j:byte;
  ghost:array[1..3]of location;
  me:location;
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
end;
begin
  createmap;
  textbackground(white);
  clrscr;
  for i:=1 to 10 do
  begin
    for j:=1 to 16 do
    begin
      if not map[i,j] then
      textbackground(black) else
        textbackground(white);
      write('  ');
      end;
    writeln;
  end;
  textbackground(white);
  textcolor(black);
  me.x:=8;me.y:=9;
  gotoxy(me.x*2-1,me.y);
  ghost[1].x:=2;
  ghost[1].y:=2;
  j:=0;
  repeat
    delay(10);
    inc(j);
    if keypressed then
    case ord(readkey)of
    0:case ord(readkey) of
      80:if map[me.y+1,me.x] then inc(me.y);
      72:if (me.y>1)and (map[me.y-1,me.x]) then me.y:=me.y-1;
      75:if (me.x>1) and (map[me.y,me.x-1]) then me.x:=me.x-1
         else if(me.x=1)and((me.y=2)or(me.y=6))then
         me.x:=16;
      77:if map[me.y,me.x+1] then inc(me.x)
        else if(me.x=16)and((me.y=2)or(me.y=6)) then
        me.x:=1;
      end;
    else continue;
    end;
    gotoxy(me.x*2-1,me.y);
    if j=100 then
    begin
      j:=0;
      gotoxy(ghost[1].x*2-1,ghost[1].y);
      write('  ');
      i:=ai(ghost[1],me);
      inc(ghost[1].x,dx[i]);
      inc(ghost[1].y,dy[i]);
      gotoxy(ghost[1].x*2-1,ghost[1].y);
      write('*');
      gotoxy(me.x*2-1,me.y);
    end;
  until (me.x=ghost[1].x)and(me.y=ghost[1].y);
  clrscr;
  gotoxy(12,5);
  write('You died!SB!');
  readln;
end.
