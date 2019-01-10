# import MA csv file
Sys.setlocale(category = 'LC_ALL', locale = 'Chinese (Simplified)_China.936')
root.dir <- "C:/Users/Yu Zhu/OneDrive/App/R/R-Play/07-HuangCAR"
setwd(root.dir)
china.outbound.ma <- fread(file.path(root.dir, "China_outbound_MA.csv"), encoding = 'UTF-8')
match.20171230 <- fread(file.path(root.dir, "20171230-match-results-all.csv"), encoding = 'UTF-8')

# import daily stock return
ld(`trd.dalyr.2017-09-30`)
f.dstk <- trd.dalyr[, .(stkcd, trddt, adjprice = adjprcnd, r = dretnd * 100)
    ][order(stkcd, trddt)] %>% unique()
# °ÑË«ÐÝÈÕÊ²Ã´µÄ¶¼²åÖµÌî³ä
CJ <- f.dstk[, .(trddt = seq(min(trddt), max(trddt), by = 'day')), keyby = .(stkcd)]
f.dstk <- f.dstk[CJ, on = .(stkcd, trddt), nomatch = NA
    ][order(stkcd, trddt)]
rm(CJ)


# import rm, rf
ld(`sdi.thrfacday.2017-09-30`)
d3f <- sdi.thrfacday[markettypeid == 'P9709', .(rm_rf = riskpremium1 * 100, trddt)]

# stk.ann: stkcd + ann.date
# ÔÚstk.annÖÐ£¬Í¬Ò»¸östkcd£¬ÔÚÍ¬Ò»Ìì£¬ÓÐ¿ÉÄÜÓÐÁ½¸ödeal.no£¡ËµÃ÷Ô­Êý¾Ý¼¯¾ÍÓÐÎÊÌâ
stk.ann <- match.20171230[, .(stkcd = Stkcd, deal.no = as.character(Deal_Number))
    ][!is.na(stkcd)
    ][china.outbound.ma[, .(ann.date = mdy(Date_Announced), deal.no = as.character(Deal_Number))], on = .(deal.no), nomatch = 0
    ][!is.na(stkcd) # ÓÐÐ©deal.no¶ÔÓ¦µÄstkcdÊÇNA
    ][, ':='(stkcd = formatC(stkcd, flag = '0', width = 6))
    ][order(stkcd, ann.date)]
sv(stk.ann)

# stk.ann.ret: stkcd + ann.date + daily.return + rm_rf
stk.ann.ret <- stk.ann[f.dstk, on = .(stkcd, ann.date = trddt)
    ][order(stkcd, ann.date)
    ][, ':='(event = ifelse(is.na(deal.no), 0L, 1L))
    ][!is.na(r) | event == 1
    ][, c('event') := {
        event[which(is.na(r)) + 1] <- 1L
        list(event)
        }, 
        keyby = .(stkcd)
    ][!is.na(r)
    ][d3f, on = .(ann.date = trddt), nomatch = 0
    ][order(stkcd, ann.date)]
setnames(stk.ann.ret, 'ann.date', 'trddt')

sv(stk.ann.ret)