library(RODBC)

# r ��ʾδ���κ��޸ĵ�ԭʼ���ݼ�
# û��ǰ׺��ʾ�м����ݼ�
# ���� info �࣬ÿֻ����ֻռ һ�� ����

# odbcDriverConnect���ԡ��ڲ���������ODBC���������ֱ������SQLServer��Ψһ��Ҫע��Ĳ�������server����Ҫִ�С�SELECT @@SERVERNAME������������õ���ͬʱ����server name����ʱ������\������Ҫ�ټ�һ����\����escape
zy <- odbcDriverConnect('driver={SQL Server};server=ZJU-211-ADV\\SQLEXPRESS;database=ZYYX;trusted_connection=true')

# fund_infomation
r.zy.info <- sqlQuery(zy, "select * from [dbo].[t_fund_info]") %>% setDT() # ����״̬��
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