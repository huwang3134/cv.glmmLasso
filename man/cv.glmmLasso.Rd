% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/cv.glmmLasso.R
\name{cv.glmmLasso}
\alias{cv.glmmLasso}
\title{cv.glmmLasso}
\usage{
cv.glmmLasso(fix, rnd, data, family = stats::gaussian(link = "identity"),
  kfold = 5, lambdas = NULL, nlambdas = 100,
  lambda.min.ratio = ifelse(nobs < nvars, 0.01, 1e-04), loss,
  lambda.final = c("lambda.1se", "lambda.min"), ...)
}
\arguments{
\item{fix}{A two-sided linear formula object describing the fixed-effects part of the model, with the response on the left of a ~ operator and the terms, separated by + operators, on the right. For categorical covariables use as.factor(.) in the formula. Note, that the corresponding dummies are treated as a group and are updated blockwise}

\item{rnd}{A two-sided linear formula object describing the random-effects part of the model, with the grouping factor on the left of a ~ operator and the random terms, separated by + operators, on the right; aternatively, the random effects design matrix can be given directly (with suitable column names). If set to NULL, no random effects are included.}

\item{data}{The data frame containing the variables named in formula.}

\item{family}{A GLM family, see \code{\link[=glm]{glm()}} and \code{\link[=family]{family()}}. Also ordinal response models can be fitted: use family=acat() and family=cumulative() for the fitting of an adjacent category or cumulative model, respectively. If family is missing then a linear mixed model is fit; otherwise a generalized linear mixed model is fit.}

\item{kfold}{Number of folds - default is 10. Although k-folds can be as large as the sample size (leave-one-out CV), it is not recommended for large datasets. Smallest value allowable is nfolds = 3}

\item{lambdas}{Optional user-supplied lambda sequence; default is NULL, and glmmLasso_MultLambdas chooses its own sequence}

\item{nlambdas}{The number of lambdas values, default value is 100 if lambdas is not user-supplied}

\item{lambda.min.ratio}{Smallest value for lambda, as a fraction of lambda.max, the (data derived) entry value (i.e. the smallest value for which all coefficients are zero). The default depends on the sample size nobs relative to the number of variables nvars. If nobs > nvars, the default is 0.0001, close to zero. If nobs < nvars, the default is 0.01.}

\item{loss}{Loss function used to calculate error, default values is based on family: \cr

\itemize{
\item gaussian = \code{\link[cv.glmmLasso:calc_mse]{cv.glmmLasso::calc_mse()}}
\item binomial = \code{\link[cv.glmmLasso:calc_logloss]{cv.glmmLasso::calc_logloss()}}
\item multinomial = \code{\link[cv.glmmLasso:calc_multilogloss]{cv.glmmLasso::calc_multilogloss()}}
\item poisson = \code{\link[cv.glmmLasso:calc_deviance]{cv.glmmLasso::calc_deviance()}}
}}

\item{lambda.final}{Choice for final model to use lambda.1se or lambda.min, default is lambda.1se}

\item{\dots}{can receive parameters accepted by glmmLasso}
}
\value{
A list of cross-validation values including: \cr

\describe{
\item{lambdas}{The values of lambda used in the fits}
\item{cvm}{The mean cross-validated error - a vector of length length(lambda)}
\item{cvsd}{Estimate of standard error of cvm.}
\item{cvup}{Upper curve = cvm+cvsd.}
\item{cvlo}{Lower curve = cvm-cvsd.}
\item{glmmLasso.final}{A fitted glmmLasso object for the full data}
\item{lambda.min}{Value of lambda that gives minimum cvm}
\item{lambda.1se}{Largest value of lambda such that error is within 1 standard error of the minimum}
}
}
\description{
Does k-fold cross validation for glmmLasso
}
\details{
Build multiple models given a sequence of lambda values
}
\examples{
data("soccer", package = "glmmLasso")
soccer[,c(4,5,9:16)]<-scale(soccer[,c(4,5,9:16)],center=TRUE,scale=TRUE)
soccer <- data.frame(soccer)

mod1 <- cv.glmmLasso(fix = points ~ transfer.spendings + ave.unfair.score + 
ball.possession + tackles, rnd = list(team=~1), data = soccer, 
family = gaussian(link = "identity"), kfold = 5, lambda.final = 'lambda.1se')
}
\author{
Pirapong Jitngamplang, Jared Lander
}
