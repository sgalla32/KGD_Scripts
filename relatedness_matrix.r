#Removes everything from the R environment. Only use when fresh start needed. 
rm(list=ls())

#Reads your csv relatedness matrix into R. 
M <- as.matrix(read.csv("Killdeer_Resequencing_Matrix_NoIDs.csv", header = FALSE))

#The function diag(x) extracts or replaces the diagonol of a matrix, or construct a diagonal matrix.
#x can specify a matrix, when it extracts the diagonal. 
#x can be missing and nrow is specified, it returns an identity matrix 
#x can be scalar (length-one vector) and the only argument it returns a square identity matrix of size given by the scalar.
#x can be a ???numeric??? (complex, numeric, integer, logical, or raw) vector, either of length at least 2 or there were further arguments. This returns a matrix with the given diagonal and zero off-diagonal entries.
D <- diag(36) * 1/sqrt(diag(M))

#This creates a scaled matrix with ones as the diagonols.
#Note, % is an infix operator that does math in the background (in this case, multiplying).
ScaledMatrix <- D %*% M %*% D

#Converts a covariate matrix to a correlation matrix. 
ScaledMatrix_Correlation <- cov2cor(ScaledMatrix)

write.table(ScaledMatrix_Correlation, file="Killdeer_Scaled_Matrix_Correlation.txt", sep= " ")

write.csv(ScaledMatrix_Correlation, file="Killdeer_Scaled_Matrix_Correlation.csv")

#############################
#Mantel Test
#############################
#Make sure the programme Ape is installed. 
M1 <- as.matrix(read.csv("Kaki_Scaled_Matrix_Correlation_NoIDs.csv", header = FALSE))
M2 <- as.matrix(read.csv("AusPied_Scaled_Matrix_Correlation_NoIDs.csv", header = FALSE))
M3 <- as.matrix(read.csv("Avocet_Scaled_Matrix_Correlation_NoIds.csv", header = FALSE))
M4 <- as.matrix(read.csv("Killdeer_Scaled_Matrix_Correlation_NoIDs.csv", header = FALSE))

sink("MantelTests.txt")
mantel.test(M1, M2, nperm = 1000, graph = TRUE,
            alternative = "two.sided")
mantel.test(M1, M3, nperm = 1000, graph = TRUE,
            alternative = "two.sided")
mantel.test(M1, M4, nperm = 1000, graph = TRUE,
            alternative = "two.sided")
sink()

#############################
#Daniel's original script
#############################

M <- rbind(c(2, 2),
           c(2, 3))
D <- diag(2) * 1/sqrt(diag(M))
D %*% M %*% D
cov2cor(M)
