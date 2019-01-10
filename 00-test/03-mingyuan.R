require(data.table)

# read csv file
dt <- fread("MCID error bar.csv", header = T)
# remove first column
dt[, 'V1' := NULL]
# convert column names to lower cases
setnames(dt, names(dt), tolower(names(dt)))

# prepare the dataset for ploting
plot <- dt[kccq_mcid != 'NA'   # remove NA
    ][, ':='(n.type = .N), keyby = .(hf_type)  # count subgroup size
    ][, .(pct = .N / n.type[1]*100, n.type = n.type[1]), keyby = .(hf_type, kccq_mcid)   # calculate percentage
    ][, ':='(se = sqrt(pct * (100 - pct) / n.type)) # calculate se
    ][, ':='(up = pct + se, low = pct - se)] # calculate error bar



# plot
plot %>%
    ggplot(aes(x = kccq_mcid, y = pct, fill = hf_type)) +
    geom_bar(stat = 'identity', position=position_dodge()) + 
    geom_errorbar(aes(ymin = low, ymax = up), width=.2, position = position_dodge(.9)) +
    scale_fill_manual(values = c('#D85B63',  '#5C5C5C',  '#FDC47D')) +
    ylab('% of patients')+
    xlab('')+
    ggtitle('KCCQ')+
    scale_x_discrete(limits=c('death/tranplant/lvad','worsening','no change','improvement'), labels=c('death/transplant/lvad','worsening','no change','improvement'))+
    theme(plot.title = element_text(hjust=0.5, face = "bold"), 
          legend.title=element_blank())
    