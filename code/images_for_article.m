IMG_SIZE=128;
X = 1:1:IMG_SIZE;
sigma=10;

Y = exp(-(X-(IMG_SIZE/2)).^2/(2*sigma^2));

plot(X,Y,'b-');