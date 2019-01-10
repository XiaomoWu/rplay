options msglevel=i;

libname in "E:\OnlinePrice";
libname out "E:\OnlinePrice\MST-UTF8" 
    outencoding = "UTF-8";

proc copy noclone in = in out = out;
    select mst_tm;
run;                                               

data out.mst_tm_1y (encoding = "utf8");
    set in.mst_tm (obs = 100000000);
run;

data out.mst_tm_2y (encoding = "utf8");
    set in.mst_tm (firstobs = 100000001 obs = 145828086);
run;

data in.mst_tm_2y (encoding = "euc-cn");
    set in.mst_tm (firstobs = 100000001 obs = 200000000);
run;

proc copy noclone in = in out = out;
    select mst_tm_2y;
run;    
