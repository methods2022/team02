library(dplyr)
library(ggplot2)
install.packages("bayesforecast")
library(bayesforecast)
library(forecast)
library(caret)
library(lattice)
library(ggplot2)
library(RANN)

diagnosis_matrix <- as.data.frame(diagnosis)

#plotting the initial distribution
ggplot(data = diagnosis_matrix, aes(x = Date, y = Frequency))+ geom_line()+ geom_point() + 
  labs(x = "Date", y = "Frequency", title = "Publication rates of Diagnosis related Mesh headers") +
  theme_minimal()

#declare this as time series data
time_series_data <- ts(diagnosis_matrix[,2], start = c(2019, 12), frequency = 12)

##########################
###Preliminary analysis###
##########################
#Timeplot
autoplot(time_series_data) + ggtitle("Publication rates of Diagnosis related Mesh headers") + ylab("Frequency of publication") +theme_minimal()

#fitting the model
fit_ar <- auto.arima(Y, d=1, D=1, stepwise = FALSE, approximation = FALSE, trace = TRUE)
print(summary(fit_ar))
checkresiduals(fit_ar) +ggtitle("Residuals for Forecast Prediction for Diagnosis") + theme_minimal() + theme(
  panel.border = element_blank(),
  panel.grid.major = element_blank(),
  panel.grid.minor = element_blank(),
  axis.line = element_line(colour = "black"))  +theme(text = element_text(size = 16))

#forecast 
my_forecast <- forecast(fit_arima, h=12)
autoplot(my_forecast) +ylab("Publication Number") + xlab("Year")+ ggtitle("Forecast Prediction for Diagnosis") 
  # theme_minimal() + theme(
  # panel.border = element_blank(),
  # panel.grid.major = element_blank(),
  # panel.grid.minor = element_blank(),
  # axis.line = element_line(colour = "black"))  +theme(text = element_text(size = 16))

print(summary(my_forecast))


##### OTHER TRIALS AND ERRORS #####

# intrain <- createDataPartition(y = t(diagnosis_matrix)[,1], p= 0.7)[[1]]
# # seperate test and training sets
# training <- diagnosis_matrix[-intrain,]
# testing <- diagnosis_matrix[intrain,]
# 
# naiv = training %>% 
#   snaive(h=length(testing), bootstrap = T, level = 0.89) 
# naiv %>% 
#   forecast_eval(model_name = "Seaonal Naive")

