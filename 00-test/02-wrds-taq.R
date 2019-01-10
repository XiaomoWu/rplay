#require(data.table)
#require(RPostgres)
#require(RMariaDB)
require(DBI)
#require(stringr)
#require(odbc)


# initialize WRDS connection
conn.wrds <- dbConnect(RPostgres::Postgres(),
                  host = 'wrds-pgdata.wharton.upenn.edu',
                  port = 9737,
                  dbname = 'wrds',
                  sslmode = 'require',
                  user = 'xiaomowu',
                  password = 'SLCyz2018')

# get data
query <- "
    select distinct t2.date, 
        t2.sym_root, t2.sym_suffix,
        t2.minute, 
        t2.max_price, t2.min_price, t1.price as last_price
    from taqm_2018.ctm_20180215 as t1
    inner join (
        select date, date_trunc('minute', time_m) as minute, 
            sym_root, sym_suffix,
            max(time_m) as max_time, 
            max(price) as max_price,
            min(price) as min_price
        from taqm_2018.ctm_20180215
        group by date, minute, sym_root, sym_suffix) as t2
        on t1.date = t2.date and t1.time_m = t2.max_time
            and t1.sym_root = t2.sym_root
            and t1.sym_suffix = t2.sym_suffix "

query <- "with ranked as (
    select *, row_number() over (partition by sym_root, sym_suffix order by time_m desc, qu_seqnum desc) as nid
    from taqm_2018.cqm_20180215)
    select * from ranked
    where nid = 1;"

res <- dbSendQuery(conn.wrds, query)
dt <- dbFetch(res, n = -1)
dbClearResult(res)

dbWriteTable(conn, dt)



## get all libraries 
#res <- dbSendQuery(conn.wrds, "select distinct table_schema
                   #from information_schema.tables
                   #where table_type ='VIEW'
                   #or table_type ='FOREIGN TABLE'
                   #order by table_schema")
#data <- dbFetch(res, n = -1)
#dbClearResult(res)
#data

## get all tables within a library
#res <- dbSendQuery(conn.wrds, "select distinct table_name
                   #from information_schema.columns
                   #where table_schema='taqm_2018'
                   #order by table_name")
#data <- dbFetch(res, n = -1)
#dbClearResult(res)
#data



#############################
#### Import Rdata into MySQL ####
#############################
# initialize MySQL connection
#conn.mysql <- dbConnect(RMariaDB::MariaDB(),
                 #host = 'localhost',
                 #port = 3306,
                 #user = 'yu',
                 #password = 'SLCyz2018',
                 #dbname = "wrds")

#dbDisconnect(conn.wrds)

