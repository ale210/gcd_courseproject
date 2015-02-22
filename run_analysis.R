zip_filename <- "data.zip"
if(!file.exists(zip_filename)) {
    file.download("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", zip_filename)
    unzip("data.zip")
}


root_dir_name <- "UCI HAR Dataset"

load_data <- function(set_name) {    
    feature_file_name <- paste(root_dir_name, "//", "features.txt", sep = "")
    features <- read.table(feature_file_name, stringsAsFactors=FALSE)
    
    dir_name <- paste(root_dir_name, "//", set_name, sep = "")
    
    data_table <- read.table(paste(dir_name, "//", "X_", set_name ,".txt", sep = ""))
    names(data_table) <- features$V2
    
    data_labels <- read.table(paste(dir_name, "//", "y_" , set_name, ".txt", sep = ""))
    data_table <- cbind(data_labels$V1, data_table)
    names(data_table)[1] <- "activity_id"
    
    data_subjects <- read.table(paste(dir_name, "//", "subject_", set_name, ".txt", sep = ""))
    data_table <- cbind(data_subjects$V1, data_table)
    names(data_table)[1] <- "subject_id"
    
    data_table
}

test_data <- load_data("test")
train_data <- load_data("train")

all_data <- rbind(test_data, train_data)

col_names <- names(all_data)
std_cols <- grep("std()", col_names)
mean_cols <- grep("mean()", col_names)

rel_data <- all_data[, sort(c(1, 2, std_cols, mean_cols))]

activity_labels <- read.table(paste(root_dir_name, "//", "activity_labels.txt", sep = ""))

merged_data <- merge(rel_data, activity_labels, by.x = "activity_id", by.y = "V1" )
names(merged_data)[length(merged_data)] <- "activity"
merged_data <- merged_data[, -c(1)]


library(reshape)
melted <- melt(merged_data, id.vars = c("subject_id", "activity"))
tidy <- cast(subject_id + activity + variable ~ ., data = melted, fun = mean)
names(tidy)[4] <- "mean"

write.table(tidy, file = "data.txt", row.name=FALSE)
