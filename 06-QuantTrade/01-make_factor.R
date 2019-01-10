system.time({
require(data.table)
require(TTR)

# utilities ----
# momentum
do_momemtum <- function(x, n) {
    len <- length(x)
    (x[len] / x[len - n]) - 1
}

# 导入 newdataall & hisdata ----
# 导入 newdata。把输入数据放到你的getwd()目录下
newdata <- fread("help coding/newdataall.txt")
# 所有变量名小写，删除第一列row
setnames(newdata, names(newdata), tolower(names(newdata)))
newdata[, ':='(v1 = NULL, date = as.Date(datetime))][, ':='(datetime = NULL)]

# 导入 hisdata 
hisdata <- fread("help coding/hisdata322.csv")
# 所有变量名小写，删除第一列row
setnames(hisdata, names(hisdata), tolower(names(hisdata)))
hisdata[, ':='(v1 = NULL, date = as.Date(datetime))][, ':='(datetime = NULL)]


# 选股----
# 把当日数据合并至原有数据
day <- rbindlist(list(newdata, hisdata), use.names = T, fill = T)[!is.na(amt) & close != 0 & amt != 0 # 剔除当天停牌
    ][order(code, date)
    ][, ':='(len = .N, has.new = is.na(m5[.N])), keyby = code
    ][len >= 100 & has.new # 长度大于100天，且当天有新数据
    ][, {
        len <- .N;
        date = date[len]

        # calc_kdj
        hhv <- max(high[(len - 8):len]);
        llv <- min(low[(len - 8) : len]);
        rsv <- (close[len] - llv) / (hhv - llv) * 100;
        k = 2/3 * k[len - 1] + 1/3 * rsv;
        d = 2/3 * d[len - 1] + 1/3 * k;

        # rsi6
        dclose <- close[len] - close[len -1];
        up1 <- max(dclose, 0);
        dn1 <- ifelse(dclose < 0, abs(dclose), 0);
        mavgup = 1/6 * up1 + 5/6 * mavgup[len - 1];
        mavgdn = 1/6 * dn1 + 5/6 * mavgdn[len - 1]
        rsi6 = 100 * mavgup / (mavgup + mavgdn);

        # ma5, ma10, ma20
        ma5 <- (ma5[len - 1] * 5 - close[len - 5] + close[len]) / 5;
        ma10 <- (ma10[len - 1] * 10 - close[len - 10] + close[len]) / 10;
        ma60 <- (ma60[len - 1] * 60 - close[len - 60] + close[len]) / 60;
        ma5r <- ma5 / close[len];
        ma10r <- ma10 / close[len];
        ma60r <- ma60 / close[len];
        
        # k线
        kup <- (high[len] - max(open[len], close[len])) / open[len];
        klow <- (min(open[len], close[len]) - low[len]) / open[len];
        kbody <- (open[len] - close[len]) / open[len];

        # momentum
        m1 <- do_momemtum(close, 1);
        m5 <- do_momemtum(close, 5);
        m10 <- do_momemtum(close, 10);
        m20 <- do_momemtum(close, 20);

        # bullin
        band <- tail(BBands(matrix(c(high, low, close), ncol = 3)[50 : len, ]), 1) / close[len];
        bbdn <- band[1];
        bbmavg <- band[2];
        bbup <- band[3];

        # output
        list(date = date, k = k, d = d, mavgup = mavgup, mavgdn = mavgdn, rsi6 = rsi6, ma5r = ma5r, ma10r = ma10r, ma60r = ma60r, m1 = m1, m5 = m5, m10 = m10, m20 = m20, kup = kup, klow = klow, kbody = kbody, bbdn = bbdn, bbmavg = bbmavg, bbup = bbup);
        },
        keyby = .(code)]

# 标准化操作
day <- day[abs(m1) < 0.099, 
    c(.(date = date, code = code), lapply(.SD, function(v) frank(v)/.N)), .SDcols = k:bbup
    ][order(code)]

})