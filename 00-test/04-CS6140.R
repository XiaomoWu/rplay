library(devtools)
?install_github
Sys.setenv(BINPREF = "C:/Software/R/Rtools-3.5/Rtools/mingw_64/bin")
assignInNamespace("version_info", c(devtools:::version_info, list("3.5" = list(version_min = "3.3.0", version_max = "99.99.99", path = "bin"))), "devtools")

install_github("XiaomoWu/R-Play/03-Packages/utilr")
install_github("XiaomoWu/utilr")
install_github("wch/ggplot2")
githubinstall('utilr')
gh_install_packages('XiaomoWu/R-Play/03-Packages/utilr')

library(githubinstall)
pkg <- gh_list_packages(username = "xiaomowu")
pkg <- gh_list_packages(username = "hadley")


# Birthday problem
get_prob_naive <- function(n, k) {
    n.pair <- choose(k, 2)
    1 - (1 - 1 / n) ^ n.pair
}

get_prob_accurate <- function(n, k) {
    1 - prod(seq(n-(k-1), n-1) / n)
}

n <- 5000
k <- 150
#get_prob_naive(n, k)
#get_prob_accurate(n, k)

ks <- seq_len(k)
p.naive <- sapply(ks, partial(get_prob_naive, n = n))
p.accurate <- sapply(ks, partial(get_prob_accurate, n = n))
dt <- data.table(k = ks, p.naive = p.naive, p.accurate = p.accurate)

dt %>%
    ggplot(aes(x = k, y = p.accurate), fill = 'blue') +
    geom_line()


