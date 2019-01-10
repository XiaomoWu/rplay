library(readxl)
# DZH��������Ŀ¼
dir <- "C:/Users/rossz/OneDrive/App/R/R-Play/02-MergeHedgeFund/SQLServer raw data-Hongxin/DZH"
# Before 2015 ----
dir.before.2015 <- file.path(dir, "DZH-start-2015.xlsx")
jhlc.info.before.2015 <- read_excel(dir.before.2015, sheet = "��������-info-start-2015")
jhlc.nv.2015 <- read_excel(dir.before.2015, sheet = "��������-nv-2015")
jhlc.nv.before.2014 <- read_excel(dir.before.2015, sheet = "��������-nv-start-2014")

ygsm.info.before.2015 <- read_excel(dir.before.2015, sheet = "����˽ļ-info-start-2015")
ygsm.nv.before.2015 <- read_excel(dir.before.2015, sheet = "����˽ļ-nv-start-2015")

# After 2015 ----
dir.after.2015 <- file.path(dir, "DZH-2016-2017.xlsx")
jhlc.info.after.2015 <- read_excel(dir.after.2015, sheet = "��������-info-2016-2017")
jhlc.nv.2016 <- read_excel(dir.after.2015, sheet = "��������-nv-2016")
jhlc.nv.2017 <- read_excel(dir.after.2015, sheet = "��������-nv-2017")

ygsm.info.after.2015 <- read_excel(dir.after.2015, sheet = "����˽ļ-info-2016-2017")
ygsm.nv.after.2015 <- read_excel(dir.after.2015, sheet = "����˽ļ-nv-2016-2017")


# �ϲ������ļ�����������������ݼ���dzh.info, dzh.nv ----
# �ϲ�info
f.dzh.info <- rbindlist(list(jhlc.info.after.2015, jhlc.info.before.2015, ygsm.info.after.2015, ygsm.info.before.2015), use.names = T, fill = T) %>% unique(by = c("fund.id"))
setnames(f.dzh.info, names(f.dzh.info), str_c("dzh.", names(f.dzh.info)))
setnames(f.dzh.info, names(f.dzh.info), str_replace_all(names(f.dzh.info), "_", "."))
sv(f.dzh.info)

# �ϲ�nv
f.dzh.nv <- rbindlist(list(jhlc.nv.2015, jhlc.nv.2016, jhlc.nv.2017, jhlc.nv.before.2014, ygsm.nv.before.2015, ygsm.nv.after.2015), use.names = T, fill = T) %>% unique(by = c("fund.id", "date"))
setnames(f.dzh.nv, names(f.dzh.nv), str_c("dzh.", names(f.dzh.nv)))
setnames(f.dzh.nv, names(f.dzh.nv), str_replace_all(names(f.dzh.nv), "_", "."))
sv(f.dzh.nv)
