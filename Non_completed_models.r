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
