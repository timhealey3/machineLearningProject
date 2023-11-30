# KNN
set.seed(6)
train.x <- cbind(energy_data_long$StateCode, energy_data_long$production)[train,]
train.y <- cbind(energy_data_long$StateCode, energy_data_long$production)[!train,]
train.highestProd <- energy_data_long$highestProd[train]
knn.pred <- knn(train.X, test.X, train.highestProd, k = 1)

# SVM
set.seed(1)
train_index <- createDataPartition(energy_data_long$highestProd, p = 0.7, list = FALSE)
training_data <- energy_data_long[train_index, ]
testing_data <- energy_data_long[-train_index, ]

# predict
prediction_data <- expand.grid(StateCode = unique(energy_data_long$StateCode), Year = 2035)
prediction_data$production <- 0
predicted_probs <- predict(glm.fits, newdata = prediction_data, type = "response")
predicted_labels <- ifelse(predicted_probs > 0.5, 1, 0)
num_renewable_states <- sum(predicted_labels == 1)
print(num_renewable_states)



# SVM
set.seed(200)
x <- energy_data_long
y <- energy_data_long$highestProd
dat <- data.frame(x = x, y = as.factor(y))
train_index <- createDataPartition(energy_data_long$highestProd, p = 0.7, list = FALSE)
training_data <- energy_data_long[train_index, ]
testing_data <- energy_data_long[-train_index, ]

train <- sample(200, 100)

svmfit <- svm(highestProd ~ , data = training_data, kernel = "radial")
summary(svmfit)

tune.out <- tune(svm, y~ ., data=dat[train, ],
                 kernel="polynomial",
                 ranges=list(
                   cost=c(0.1,1,10,100,1000),
                   gamma = c(0.5,1,2,3,4)
                 ))
summary(tune.out)
table (
  true = dat[-train, "y"],
  pred = predict(tune.out$best.model, newdata=dat[-train, ])
)
# create regression tree
set.seed(150)
train <- sample(1:nrow(energy_data_long), nrow(energy_data_long) / 2)
tree.energy <- tree (highestProd ~ StateCode + Year + production, energy_data_long, subset=train)
cv.energy <- cv.tree(tree.energy)
prune.energy <- prune.tree(tree.energy, best = 5)
yhat <- predict(tree.energy, newdata = energy_data_long[-train, ])
energy.test <- energy_data_long[-train, "highestProd"]
mean((yhat - energy.test)^2)
