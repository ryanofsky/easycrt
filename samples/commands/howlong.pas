uses winprocs, easycrt;

var days, hours, minutes, seconds, milliseconds,t:longint;

begin
  setsize(300,100);
  writeln('How long has windows been running?');
  repeat
    delay(1);
    t:=gettickcount;
    days:=trunc(t/1000/60/60/24);
    t:=t-days*1000*60*60*24;
    hours:=trunc(t/1000/60/60);
    t:=t-hours*1000*60*60;
    minutes:=trunc(t/1000/60);
    t:=t-minutes*1000*60;
    seconds:=trunc(t/1000);
    t:=t-seconds*1000;
    milliseconds:=t;
    gotoxy(5,3);
    write(days,'  days     ',hours,':',minutes,':',seconds,'.',milliseconds);
    clreol;
  until ldown;
  donewincrt;
end.