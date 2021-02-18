#install keras R package
install.packages("keras")


#install the core keras library and tensorflow
library(keras)
install_keras()

#install_keras(tensorflow = "gpu")

fashion_mnist <- dataset_fashion_mnist()

#test train split
#train_images <- fashion_mnist$train$x
c(train_images, train_labels) %<-% fashion_mnist$train
c(test_images , test_labels) %<-% fashion_mnist$test

dim(train_images)
str(train_images)

#plotting the images
fobject <- train_images[1,,]
plot(as.raster(fobject,max =255))

class_names = c('T-shirt/top',
                'Trouser',
                'Pullover',
                'Dress',
                'Coat',
                'Sandal',
                'Shirt',
                'Sneaker',
                'Bag',
                'Ankle boot')
class_names[train_labels[1]+1]

#normalize [(x-mean)/std.Dev]

train_images <- train_images / 255
test_images <- test_images /255
