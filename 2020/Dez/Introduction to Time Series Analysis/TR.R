
Cola<-read.table('sales.csv',header=TRUE,sep=';') 
Cola
sales.Cola<-ts(Cola,start=2001, frequency=12) 
sales.Cola

plot(sales.Cola)

lines(meanf(window(sales.Cola, start = 2001, end = 2003),h=24)$mean,col=2,lwd=3)
lines(naive(window(sales.Cola, start = 2001, end = 2003),h=24)$mean,col=3,lwd=3)
lines(snaive(window(sales.Cola, start = 2001, end = 2003),h=24)$mean,col=4,lwd=3)
lines(rwf(window(sales.Cola, start= 2001, end = 2003),drift=T,h=24)$mean,col=5,lwd=3)
text<-c("Mean method","Naive method", "Seasonal naive method", "Drift method")
legend("topright",text,col=2:5,lty=1,ncol=1,cex=1,lwd=3)

monthplot(sales.Cola) # to test seasonality
BoxCox.lambda(sales.Cola) # to test variance

par(mfrow=c(2,1))
acf(sales.Cola) # to test MA and AR
pacf(sales.Cola, main="PACF") # to test AR and MA

log.sales<-log(sales.Cola)

# Apply both a non-seasonal and seasonal diference to the data

diff1 <- diff(log.sales,1)
plot(diff1)
diff1and12 = diff(diff1,12)
plot(diff1and12)

# Apply a first diference

diff1 <- diff(log.sales)
plot(diff1)
diff1and2 = diff(diff1)
plot(diff1and2)

par(mfrow=c(2,1))
acf(diff1and2)
pacf(diff1and2)

#Fit Model, First try

fit<-arima(log.sales,order = c(1,2,0))
fit

# The statistics for the model

n = length(diff1and2)
k = length(fit$coef)
log(fit$sigma2)+((n+2*k)/n)
BIC = log(fit$sigma2)+(k*log(n)/n)
AICc = log(fit$sigma2)+((n+k)/(n-k-2))
AIC = log(fit$sigma2)+((n+2*k)/n)
AIC
AICc
BIC 

# The residuals for the model

tsdiag(fit)
plot(as.vector(fitted(fit)),as.vector(residuals(fit)),xlab="Fitted values", ylab="Residuals")
abline(h=0)
hist(fit$res)


#Segunda tentativa

fit1<-arima(log.sales,order = c(0,2,1))
fit1

# The statistics for the model

n = length(diff1and2)
k = length(fit1$coef)
log(fit1$sigma2)+((n+2*k)/n)
BIC = log(fit1$sigma2)+(k*log(n)/n)
AICc = log(fit1$sigma2)+((n+k)/(n-k-2))
AIC = log(fit1$sigma2)+((n+2*k)/n)
AIC
AICc
BIC 

# The residuals for the model

tsdiag(fit1)
plot(as.vector(fitted(fit1)),as.vector(residuals(fit1)),xlab="Fitted values", ylab="Residuals")
abline(h=0)
hist(fit1$res)


#Terceira tentativa, aplicando a componente sazonal

fit2<-arima(log.sales,order = c(1,2,0), seasonal=list(order=c(0,0,3),period=12))
fit2

# The statistics for the model

n = length(diff1and2)
k = length(fit2$coef)
log(fit2$sigma2)+((n+2*k)/n)
BIC = log(fit2$sigma2)+(k*log(n)/n)
AICc = log(fit2$sigma2)+((n+k)/(n-k-2))
AIC = log(fit2$sigma2)+((n+2*k)/n)
AIC
AICc
BIC 

# The residuals for the model

tsdiag(fit2)
plot(as.vector(fitted(fit2)),as.vector(residuals(fit2)),xlab="Fitted values", ylab="Residuals")
abline(h=0)
hist(fit2$res)


#Quarta tentativa

fit3<-arima(log.sales,order = c(0,2,1), seasonal=list(order=c(0,0,3),period=12))
fit3

# The statistics for the model

n = length(diff1and2)
k = length(fit3$coef)
log(fit3$sigma2)+((n+2*k)/n)
BIC = log(fit3$sigma2)+(k*log(n)/n)
AICc = log(fit3$sigma2)+((n+k)/(n-k-2))
AIC = log(fit3$sigma2)+((n+2*k)/n)
AIC
AICc
BIC 

# The residuals for the model

tsdiag(fit3)
plot(as.vector(fitted(fit3)),as.vector(residuals(fit3)),xlab="Fitted values", ylab="Residuals")
abline(h=0)
hist(fit3$res)

# Quinta tentativa

fit4<-arima(log.sales,order = c(2,2,1), seasonal=list(order=c(0,0,2),period=12))
fit4

# The statistics for the model

n = length(diff1and2)
k = length(fit4$coef)
log(fit4$sigma2)+((n+2*k)/n)
BIC = log(fit4$sigma2)+(k*log(n)/n)
AICc = log(fit4$sigma2)+((n+k)/(n-k-2))
AIC = log(fit4$sigma2)+((n+2*k)/n)
AIC
AICc
BIC 

# The residuals for the model

tsdiag(fit4)
plot(as.vector(fitted(fit4)),as.vector(residuals(fit4)),xlab="Fitted values", ylab="Residuals")
abline(h=0)
hist(fit4$res)


#Sexta tentativa

fit5<-arima(log.sales,order = c(0,2,3), seasonal=list(order=c(0,0,3),period=12))
fit5

#The statistics for the model

n = length(diff1and2)
k = length(fit5$coef)
log(fit5$sigma2)+((n+2*k)/n)
BIC = log(fit5$sigma2)+(k*log(n)/n)
AICc = log(fit5$sigma2)+((n+k)/(n-k-2))
AIC = log(fit5$sigma2)+((n+2*k)/n)
AIC
AICc
BIC 

# The residuals for the model
tsdiag(fit5)
plot(as.vector(fitted(fit5)),as.vector(residuals(fit5)),xlab="Fitted values", ylab="Residuals")
abline(h=0)
hist(fit5$res)

forecasts <- forecast(fit5, h=12)
forecasts
plot.forecast(forecasts)


