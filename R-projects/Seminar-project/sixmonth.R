library(tidyverse)
indicators <- read_csv("Data/Aggregated Data/indicators.csv",col_types = cols(USREC = col_integer(),raDATE = col_date(format = "%Y-%m")))
sixmonth <- lag(indicators$SPREAD, 6)
sixmonth.t <- tail(sixmonth, 792)
suUSREC.sm <- tail(indicators$USREC, 792)
date.sm <- tail(indicators$raDATE, 792)
modelsm <- glm(USREC.sm ~ sixmonth.t, family = binomial(link="probit"))
summary(modelsm)
sixmonthz <- predict(modelsm)
sixmonthp <- pnorm(sixmonthz)
p1 <- ggplot() + geom_line(aes(x=date.sm, y=sixmonthp), color="blue")
p1+geom_col(aes(x=date.sm, y=USREC.sm), alpha=0.3) + xlab("") + ylab("Probability")
