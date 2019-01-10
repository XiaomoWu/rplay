# 注意！需要下载Microsoft R Open!
library(caret)
library(ranger)
library(dplyr)
library(e1071)
library(lubridate)

# 导入训练文件
folder <- "C:/Users/rossz/OneDrive/App/R/R-Play/06-QuantTrade/train model"
all <- fread(file.path(folder, '15rank.csv'))[, ':='(V1 = NULL, delta1 = NULL, code = NULL, day = NULL, date = today())]

# 生成训练数据集（如果不对时间和股票进行观测，那么这一步生成的train和上一步的all是一样的）
start <- as.Date('2018-01-01')
end <- as.Date('2018-05-01')
train <- all[date %between% c(start, end)
    ][, ':='(date = NULL)]

# 生成预测集
pred <- fread(file.path(folder, 'day.csv'))[, ':='(V1 = NULL, delta1 = NULL, DATETIME = NULL, delta = NULL)]
setnames(pred, names(pred), tolower(names(pred)))

# 设定模型
fitControl <- trainControl(method = 'none', trim = T, allowParallel = T)
parm <- data.frame(
                   mtry = 4, # 特征数，推荐为总特征的平方根。比如一共有16个因子，那么特征数推荐为4
                   min.node.size = 5,
                   splitrule = 'extratrees' # extratress 是比较快的算法，你可以改成“variance”，速度更慢。两者无好坏之分
                   )

# 开始训练
model <- train(
    delta ~ ma5 + ma10 + ma60 + rsi6 + k + d + m1 + m5 + m10 + m20 + kup + klow + kbody + bbdn + bbmavg + bbup,
    data = train,
    method = 'ranger',
    trControl = fitControl,
    num.trees = 100, # 树的棵树
    tuneGrid = parm
)
model <- model$finalModel


# 开始训练 - no caret
model <- ranger(delta ~ ma5 + ma10 + ma60 + rsi6 + k + d + m1 + m5 + m10 + m20 + kup + klow + kbody + bbdn + bbmavg + bbup,
    data = train,
    num.trees = 100,
    mtry = 4,
    splitrule = 'extratrees')

# 进行预测，并将结果按照从高到低排列
rank <- pred[, ':='(delta.pred = predict(model, data = pred)$predictions)
    ][order(-delta.pred)]


# 保存模型至硬盘
save(list = "model", file = 'model.Rdata')

# 进行预测，并将结果按照从高到低排列
rank <- copy(pred)[, ':='(pred = predict(fit, newdata = pred))
    ][order(-pred)]



