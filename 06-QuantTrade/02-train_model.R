# ע�⣡��Ҫ����Microsoft R Open!
library(caret)
library(ranger)
library(dplyr)
library(e1071)
library(lubridate)

# ����ѵ���ļ�
folder <- "C:/Users/rossz/OneDrive/App/R/R-Play/06-QuantTrade/train model"
all <- fread(file.path(folder, '15rank.csv'))[, ':='(V1 = NULL, delta1 = NULL, code = NULL, day = NULL, date = today())]

# ����ѵ�����ݼ����������ʱ��͹�Ʊ���й۲⣬��ô��һ�����ɵ�train����һ����all��һ���ģ�
start <- as.Date('2018-01-01')
end <- as.Date('2018-05-01')
train <- all[date %between% c(start, end)
    ][, ':='(date = NULL)]

# ����Ԥ�⼯
pred <- fread(file.path(folder, 'day.csv'))[, ':='(V1 = NULL, delta1 = NULL, DATETIME = NULL, delta = NULL)]
setnames(pred, names(pred), tolower(names(pred)))

# �趨ģ��
fitControl <- trainControl(method = 'none', trim = T, allowParallel = T)
parm <- data.frame(
                   mtry = 4, # ���������Ƽ�Ϊ��������ƽ����������һ����16�����ӣ���ô�������Ƽ�Ϊ4
                   min.node.size = 5,
                   splitrule = 'extratrees' # extratress �ǱȽϿ���㷨������Ըĳɡ�variance�����ٶȸ����������޺û�֮��
                   )

# ��ʼѵ��
model <- train(
    delta ~ ma5 + ma10 + ma60 + rsi6 + k + d + m1 + m5 + m10 + m20 + kup + klow + kbody + bbdn + bbmavg + bbup,
    data = train,
    method = 'ranger',
    trControl = fitControl,
    num.trees = 100, # ���Ŀ���
    tuneGrid = parm
)
model <- model$finalModel


# ��ʼѵ�� - no caret
model <- ranger(delta ~ ma5 + ma10 + ma60 + rsi6 + k + d + m1 + m5 + m10 + m20 + kup + klow + kbody + bbdn + bbmavg + bbup,
    data = train,
    num.trees = 100,
    mtry = 4,
    splitrule = 'extratrees')

# ����Ԥ�⣬����������մӸߵ�������
rank <- pred[, ':='(delta.pred = predict(model, data = pred)$predictions)
    ][order(-delta.pred)]


# ����ģ����Ӳ��
save(list = "model", file = 'model.Rdata')

# ����Ԥ�⣬����������մӸߵ�������
rank <- copy(pred)[, ':='(pred = predict(fit, newdata = pred))
    ][order(-pred)]


