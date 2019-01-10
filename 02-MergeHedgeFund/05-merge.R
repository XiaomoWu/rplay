setwd("C:/Users/rossz/OneDrive/App/R/R-Play/02-MergeHedgeFund")
Sys.setlocale(category = "LC_ALL", locale = "Chinese (Simplified)_China.936")
# �ϲ� info���������� hf.info ----
ld(f.pp.info)
ld(f.zy.info)
ld(f.dzh.info)
ld(f.wind.info)
# ��factorת��Ϊchar�ĺ���
factor2char <- function(x) {
    if (is.factor(x)) {
        as.character(x)
    } else x
}
# Ϊÿ��������ͬ������ fund.name / fund.name.short ���ںϲ�
pp.info <- f.pp.info[, ":="(db.name = "SMPP", fund.name = pp.fund.name, fund.name.short = pp.fund.name.short)][, lapply(.SD, factor2char)]
zy.info <- f.zy.info[, ":="(db.name = "ZYYX", fund.name = zy.fund.name, fund.name.short = zy.fund.name.short)][, lapply(.SD, factor2char)]
dzh.info <- f.dzh.info[, ":="(db.name = "DZH", fund.name = dzh.fund.name, fund.name.short = dzh.fund.name.short)][, lapply(.SD, factor2char)]
wind.info <- f.wind.info[, ":="(db.name = "WIND", fund.name = wind.fund.name, fund.name.short = wind.fund.name.short)][, lapply(.SD, factor2char)]
rm(f.pp.info, f.zy.info, f.dzh.info, f.wind.info)
# �����б��ϲ��� hf.info
clean_fund_name <- function(x) {
    str_replace_all(x, '[����"����\\(��\\)��\\-&\\?\\[\\]]+', " ")
}
hf.info <- rbindlist(list(pp.info, zy.info, dzh.info, wind.info), use.names = T, fill = T)[order(fund.name, db.name)
    ][, ":="(fund.name = clean_fund_name(fund.name), fund.name.short = clean_fund_name(fund.name.short)) # �� fund.name���е���������滻�ɿո�
    ][, ":="(ndup = .N), keyby = .(fund.name)] # ndup��ʾ����ÿ��fund.name���ظ����м���
# reorder column order, put fund.name, ndup, db.name at first
new.colorder <- c(c("fund.name", "ndup", "db.name"), names(hf.info)[!(names(hf.info) %in% c("fund.name", "ndup", "db.name"))])
setcolorder(hf.info, new.colorder)
# ���һ�������ж��й۲⣬��֮�ϲ���ͬһ�У�ͬʱ�޳�NA
select_unique_non_na <- function(x) {
    x[!is.na(x)][1]
}
hf.info <- hf.info[, ":="(db.name = str_c(db.name, collapse = " ")), keyby = .(fund.name)
    ][, lapply(.SD, select_unique_non_na), keyby = .(fund.name)]
sv(hf.info)

# �ϲ� nv���������� hf.nv ----
# ����ÿ����
ld(f.pp.nv)
ld(f.zy.nv)
ld(f.dzh.nv)
ld(f.wind.nv)
ld(hf.info, T)
# ÿ������ǳ�db.name
pp.nv <- f.pp.nv[, ":="(db.name = "SMPP")][hf.info[, .(fund.name, pp.fund.id)], on = .(pp.fund.id), nomatch = 0]
setnames(pp.nv, "pp.date", "date")
zy.nv <- f.zy.nv[, ":="(db.name = "ZYYX")][hf.info[, .(fund.name, zy.fund.id)], on = .(zy.fund.id), nomatch = 0]
setnames(zy.nv, "zy.date", "date")
dzh.nv <- f.dzh.nv[, ":="(db.name = "DZH")][hf.info[, .(fund.name, dzh.fund.id)], on = .(dzh.fund.id), nomatch = 0]
setnames(dzh.nv, "dzh.date", "date")
wind.nv <- f.wind.nv[, ":="(db.name = "WIND")][hf.info[, .(fund.name, wind.fund.id)], on = .(wind.fund.id), nomatch = 0]
setnames(wind.nv, "wind.date", "date")
rm(f.pp.nv, f.zy.nv, f.dzh.nv, f.wind.nv)

# Ϊhf.nv����fund.name
hf.nv <- rbindlist(list(pp.nv, zy.nv, dzh.nv, wind.nv), use.names = T, fill = T)[order(fund.name, date)]

# reorder columns, put fund.name first
new.colorder <- c(c("fund.name", "date", "db.name"), names(hf.nv)[!(names(hf.nv) %in% c("fund.name", "date", "db.name"))])
setcolorder(hf.nv, new.colorder)
hf.nv[, ":="(date = as.Date(date))][, lapply(.SD, factor2char)]
sv(hf.nv)


# export to SAS ----
# �ѱ����������е� dot ת��Ϊ underscore
dot2underscore <- function(dt) {
    setnames(copy(dt), names(dt), str_replace_all(names(dt), "\\.", "_"))
}
# ���˵�SAS�зǷ����ַ�
remove_illegal <- function(dt) {
    remove <- function(x) {
        if (is.character(x)) {
            str_replace_all(x, "[\\s&]", " ") %>% str_replace_all("quot;", "")
        } else x
    }
    dt[, lapply(.SD, remove)]
}

hf.info.sas <- hf.info %>% dot2underscore() %>% remove_illegal()
setnames(hf.info.sas, "wind_f_info_corp_fundmanagementcomp", "wind_f_info_corp_managementcomp") # hf.info�����и�����̫������SAS�32 character������Ҫѹ��
hf.nv.sas <- hf.nv %>% dot2underscore() %>% remove_illegal()

fwrite(hf.info.sas, "hf.info.sas.csv", quote = T, qmethod = "double")
fwrite(hf.nv.sas, "hf.nv.sas.csv", quote = T, qmethod = "double")
