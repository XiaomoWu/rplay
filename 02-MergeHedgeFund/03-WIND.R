library(RODBC)

# r ��ʾδ���κ��޸ĵ�ԭʼ���ݼ�
# û��ǰ׺��ʾ�м����ݼ�
# ���� info �࣬ÿֻ����ֻռ һ�� ����

# odbcDriverConnect���ԡ��ڲ���������ODBC���������ֱ������SQLServer��Ψһ��Ҫע��Ĳ�������server����Ҫִ�С�SELECT @@SERVERNAME������������õ���ͬʱ����server name����ʱ������\������Ҫ�ټ�һ����\����escape
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