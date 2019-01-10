# 删选出 2012 年 11 月的数据
d11 <- fread("tm-2012-11.csv", encoding = 'UTF-8')
d11 <- d11[, ':='(name = NULL, time = NULL, seller = NULL)]

d11.ctg = copy(d11)[, ':='(ctg1 = as.factor(ctg1)@.Data, ctg2 = as.factor(ctg2)@.Data, ctg3 = as.factor(ctg3)@.Data)]


fwrite(d11.ctg, "tm-2012-11-small-no-ctg-name.csv")



price.1211 <- fread("tm-2012-11-small-no-ctg-name.csv")

microbenchmark({
    price.1211[, .(nth(online_price, 10, order_by = online_price))]
}, times = 5)

microbenchmark({ 
    order(price.1211$online_price)[10]
}, times = 5)