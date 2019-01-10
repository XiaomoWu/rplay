# 读入数据
dt <- fread("data.csv")


# 把所有变量名改成小写，方便后面代码
setnames(dt, colnames(dt), tolower(colnames(dt)))

# Method 1: 每个股票每个交易日都计算滚动收益，然后再从中选择需要的股票和日期 ----
n_window <- 1 # 滚动窗口宽度。1代表计算后面一日的收益
n_select <- 30 # 选择top/bottom 30个股票

# ret 数据集包含了每个股票的每天的滚动收益
ret <- dt[order(stkcd, trdwnt), { #先按照股票和日期排序
    l <- list()
    for (t in 1:.N) {
        l[[t]] = list(trdwnt = trdwnt[t], ret_roll = sum(wretwd[(t+1):(t+1+n_window)])) # ret_roll 就是窗口期的收益和
    }
    rbindlist(l)
    },
    keyby = .(stkcd)
    ] %>% na.omit() # 删掉所有NA观测，也就是每个股票最后n_window个交易日

# rank数据集标记了我们需要的观测
rank <- dt[order(trdwnt, wretwd), # 根据日期、收益排序
    .SD[c(1:n_select, (.N-n_select+1):.N), .(stkcd)], # 选择top/bottom 的股票
    keyby = .(trdwnt)]

# 用rank去选择ret
re <- ret[rank, on = .(trdwnt, stkcd), nomatch = 0
    ][order(trdwnt, ret_roll)] # 最终数据集按照时间和收益排序



# Stage 2-----------------------------------------------------------------------
# 读入数据
dt <- fread("data.csv")

# 把所有变量名改成小写，方便后面代码
setnames(dt, colnames(dt), tolower(colnames(dt)))

# Method 1: 每个股票每个交易日都计算滚动收益，然后再从中选择需要的股票和日期 ----
n_window <- 5 # 滚动窗口宽度。5代表计算后面5个时间单位的收益


# ret 数据集包含了每个股票的每天的滚动收益
ret <- dt[order(stkcd, trdwnt), { #先按照股票和日期排序
    l <- list()
    for (t in seq(1, .N, n_window)) {
        l[[t]] = list(trdwnt = trdwnt[t], ret_roll = sum(wretwd[t:(t+n_window-1)])) # ret_roll 就是窗口期的收益和
    }
    rbindlist(l)
    },
    keyby = .(stkcd)
    ] %>% na.omit() # 删掉所有NA观测，也就是每个股票最后n_window个交易日
