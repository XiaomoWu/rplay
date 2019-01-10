library(RODBC)

# r 表示未作任何修改的原始数据集
# 没有前缀表示中间数据集
# 所有 info 类，每只基金只占 一行 ！！

# odbcDriverConnect可以“在不事先设置ODBC”的情况下直接连接SQLServer。唯一需要注意的参数就是server，需要执行“SELECT @@SERVERNAME”这个命令来得到，同时由于server name中有时包含“\”，需要再加一个“\”来escape
zy <- odbcDriverConnect('driver={SQL Server};server=ZJU-211-ADV\\SQLEXPRESS;database=ZYYX;trusted_connection=true')

# fund_infomation
r.zy.info <- sqlQuery(zy, "select * from [dbo].[t_fund_info]") %>% setDT() # 基金状态表
zy.info <- r.zy.info
setnames(zy.info, names(zy.info), str_c("zy.", names(zy.info)))
setnames(zy.info, names(zy.info), str_replace_all(names(zy.info), "_", "."))
setnames(zy.info, c("zy.fund.name", "zy.fund.full.name"), c("zy.fund.name.short", "zy.fund.name"))
f.zy.info <- zy.info
sv(f.zy.info)

# fund_nv
r.zy.nv <- sqlQuery(zy, "select * from [dbo].[t_fund_daily_nv_statistic]") %>% setDT() 
zy.nv <- r.zy.nv
setnames(zy.nv, names(zy.nv), str_c("zy.", names(zy.nv)))
setnames(zy.nv, names(zy.nv), str_replace_all(names(zy.nv), "_", "."))
f.zy.nv <- zy.nv[, .(zy.fund.id, zy.date = zy.statistic.date, zy.nv = zy.nav, zy.cnv = zy.swanav, zy.source = str_sub(zy.source, 1, 1))]
sv(f.zy.nv)
