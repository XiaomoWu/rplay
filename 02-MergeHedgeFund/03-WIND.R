library(RODBC)

# r 表示未作任何修改的原始数据集
# 没有前缀表示中间数据集
# 所有 info 类，每只基金只占 一行 ！！

# odbcDriverConnect可以“在不事先设置ODBC”的情况下直接连接SQLServer。唯一需要注意的参数就是server，需要执行“SELECT @@SERVERNAME”这个命令来得到，同时由于server name中有时包含“\”，需要再加一个“\”来escape
wind <- odbcDriverConnect('driver={SQL Server};server=ZJU-211-ADV\\SQLEXPRESS;database=WIND;trusted_connection=true')

# fund_infomation ----
r.wind.info <- sqlQuery(wind, "select * from [dbo].[CHINAHEDGEFUNDDESCRIPTION]") %>% setDT()
wind.info <- r.wind.info
setnames(wind.info, names(wind.info), str_c("wind.", tolower(names(wind.info))))
setnames(wind.info, names(wind.info), str_replace_all(names(wind.info), "_", "."))
setnames(wind.info, c("wind.f.info.windcode", "wind.f.info.fullname", "wind.f.info.name"), c("wind.fund.id", "wind.fund.name", "wind.fund.name.short"))

f.wind.info <- wind.info[, ':='(wind.object.id = NULL)]
sv(f.wind.info)

# fund_nv ----
r.wind.nv <- sqlQuery(wind, "select * from [dbo].[CHINAHEDGEFUNDNAV]") %>% setDT()
wind.nv <- r.wind.nv
setnames(wind.nv, names(wind.nv), str_c("wind.", tolower(names(wind.nv))))
setnames(wind.nv, names(wind.nv), str_replace_all(names(wind.nv), "_", "."))

f.wind.nv <- wind.nv[, .(wind.fund.id = wind.f.info.windcode, wind.date = ymd(as.character(wind.price.date)), wind.nv = wind.f.nav.unit, wind.cnv = wind.f.nav.accumulated, wind.currency = wind.crncy.code)]
sv(f.wind.nv)
