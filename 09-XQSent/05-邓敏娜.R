data <- load("C:/Users/rossz/OneDrive/App/R/R-Play/00-test/minna/total.Rdata", verbose = T)

tt[, lapply(.SD, as.vector), ]

tt[, table(source)]