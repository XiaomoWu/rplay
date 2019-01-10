require(data.table)
require(RPostgres)
require(stringr)

# initialize connection
# fill up the user and password!
wrds <- dbConnect(Postgres(),
                  host = 'wrds-pgdata.wharton.upenn.edu',
                  port = 9737,
                  dbname = 'wrds',
                  sslmode = 'require',
                  user = 'xiaomowu',
                  password = 'SLCyz2018')

# set year range
# for multiple years, use year <- c(2017, 2018) instead
year <- c(2018)

# get table name list (one table for each trading day)
lib.name <- str_c('taqm_', year)
sql <- sprintf("select distinct table_name
                   from information_schema.columns
                   where table_schema='%s'
                   order by table_name", lib.name)

res <- dbSendQuery(wrds, sql)
table.list <- dbFetch(res, n = -1)$table_name
dbClearResult(res)

# each month will be saved as a separate file 
# i: the number of month
for (i in 1:2) {
    output <- data.table()
    tbl.list <- str_subset(table.list, sprintf('^ctm_\\d{4}%02d\\d{2}', i))

    for (tbl in tbl.list[1:2]) {
        print(sprintf('month: %s, table: %s', i, tbl))
        tbl.full <- str_c(lib.name, '.', tbl)
        #sql <- sprintf("select date, date_trunc('minute', time_m) as minute, sym_root, sym_suffix, sum(size) as size, min(price) as min_price, max(price) as max_price from %s group by date, minute, sym_root, sym_suffix order by date, sym_root, sym_suffix, minute", tbl.full)

dt['new.variable'] = 111
dt[, ':='(new.var = 111)]
dt[, table(sym_root)]

dt[!is.na(q), as.list(residuals(lm(price~size))), keyby = q]

dt[order(date, time_m, sym_root)
        ][, .(size = sum(size), price = mean(price), last_price = price[.N]), 
            keyby = .(date, minute = minute(time_m), sym_root)
        ][i, 
           j, 
           by
        ][]

dt[, sum(price)]

dt[i, j, by]

df = data.frame()

dt[c(1, 2, 3), .(n = .N), keyby = .(-time_m, size)]




sum(dt['price'])

        sql1 <- sprintf("With tbl AS(
                        SELECT t.date, 
                            date_trunc('minute', t.time_m) as minute, 
                            t.price,
                            t.size,
                            t.sym_root, t.sym_suffix,
                            row_number() over(partition by t.date, date_trunc('minute', t.time_m), t.sym_root
                                order by t.time_m desc) as nid
                        FROM %s as t),
                        a as (SELECT date, minute, 
                            sym_root, sym_suffix,
                            sum(size) as size,
                            min(price) as min_price, 
                            max(price) as max_price
                        FROM tbl
                        GROUP BY date, minute, sym_root, sym_suffix
                        ORDER BY date, minute, sym_root, sym_suffix)
                        select 
                        from tbl  t1
                        join a t2
                        on t1.date = t2.date and t1.minute = t2.minute....

                        ", tbl.full)
        sql2 <- sprintf("
                        SELECT date, minute, 
                            sym_root, sym_suffix,
                            sum(size) as size,
                            min(price) as min_price, 
                            max(price) as max_price
                        FROM tbl
                        GROUP BY date, minute, sym_root, sym_suffix
                        ORDER BY date, minute, sym_root, sym_suffix;")
        sql3 <- sprintf("
                        SELECT date, minute, 
                            sym_root, sym_suffix, price as last_price
                        FROM tbl
                        where nid = 1")

        sql4 <- sprintf("
                       SELECT * FROM
                       (SELECT date, minute, 
                            sym_root, sym_suffix,
                            sum(size) as size,
                            min(price) as min_price, 
                            max(price) as max_price
                        FROM tbl
                        GROUP BY date, minute, sym_root, sym_suffix
                        ORDER BY date, minute, sym_root, sym_suffix) t1
                        JOIN
                        (SELECT date, minute, 
                            sym_root, sym_suffix, price as last_price
                        FROM tbl
                        where nid = 1) t2
                        ON t1.date = t2.date 
                            and t1.minute = t2.minute 
                            and t1.sym_root = t2.sym_root
                            and t1.sym_suffix = t2.sym_suffix")

        # get data

        dt1 <- dbSendQuery(wrds, str_c(sql1, sql2) %>% str_replace('\\n\\s+', ' ')) %>% dbFetch(n = -1) %>% setDT()
        dt2 <- dbSendQuery(wrds, str_c(sql1, sql3) %>% str_replace('\\n\\s+', ' ')) %>% dbFetch(n = -1) %>% setDT()
        dt <- dt1[dt2, on = .(date, minute, sym_root, sym_suffix)][order(date, minute, sym_root, sym_suffix)]

        # save
        output <- rbindlist(list(output, dt))
    }
    save(output, file = sprintf('%s_%02d.Rdata', lib.name, i))
}


