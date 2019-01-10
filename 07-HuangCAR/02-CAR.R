ld(stk.ann.ret)

# market model ----
c1 <- 1
c2 <- 1
m1 <- 200
m2 <- 60

do_car <- function(n, r, rm, adjprice, date) {
    stopifnot(m1 > m2)
    if (n - m1 < 0) {
        cat("n =", n, "is too small \n")
    } else if (n + c2 > length(r)) {
        cat("n =", n, "is too large \n")
    } else {
        i1 <- max(1, n - m1)
        i2 <- n - m2
        i3 <- n - c1
        i4 <- n + c2
        r.model <- r[i1:i2]
        rm.model <- rm[i1:i2]
        r.car <- r[i3:i4]
        rm.car <- rm[i3:i4]
        model <- lm(r.model ~ rm.model)
        coef <- coef(model)
        ars <- r.car - predict(model, list(r.model = r.car, rm.model = rm.car))
        ars.adj <- r.car - rm.car
        if (n <= 250) {
            buy.hold.start <- 1
        } else buy.hold.start <- n - 250
        buy.hold.return <- (adjprice[n - 1] / adjprice[buy.hold.start] - 1) * 100
        list(date = date[n], coef = list(coef), ars = list(ars), ars.adj = list(ars.adj), buy.hold.return = buy.hold.return)
    }
}

ar <- unique(stk.ann.ret, by = c('stkcd', 'trddt'))[, {
    ns <- which(event == 1);
    lapply(ns, partial(do_car, adjprice = adjprice, r = r, rm = rm_rf, date = trddt)) %>% rbindlist()
    },
    by = stkcd]

car <- ar[, .(ar = unlist(ars), ar.adj = unlist(ars.adj), buy.hold.return), keyby = .(stkcd, date)
    ][, ':='(car = cumsum(ar), car.adj = cumsum(ar.adj)), keyby = .(stkcd, date)
    ][stk.ann[, .(deal.no = unique(list(deal.no))), keyby = .(stkcd, ann.date)], on = .(stkcd, date = ann.date), nomatch = 0]

sv(car)
fwrite(car, "car-revised-20181125.csv")
