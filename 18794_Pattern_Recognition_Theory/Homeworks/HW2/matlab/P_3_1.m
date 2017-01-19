load('mnist_all.mat');

figure;

%calculate digit 1's mean image and reshape it
mu1=mean(train1,1)';
mu1image=reshape(mu1,[28,28])';

%draw digit 1's mean image
subplot(3,5,1);
image(mu1image);

%collect part of training data, controlled by samplenum
samplenum=100;
train=double([train0(1:samplenum,:);train1(1:samplenum,:);train2(1:samplenum,:);train3(1:samplenum,:);train4(1:samplenum,:);
    train5(1:samplenum,:);train6(1:samplenum,:);train7(1:samplenum,:);train8(1:samplenum,:);train9(1:samplenum,:)]');
%calculate the global mean
mu=mean(train,2);

%centralize all data
ctrain=train-repmat(mu,1,size(train,2));

% Withouth Gram trick PCA to get the first 5 eigenvectos
tic
S=ctrain*ctrain'./size(ctrain,2);
[V,D]=eigs(S,5);
toc

%draw the first 5 eigenvector images
for i=1:5
    eigenimage=reshape(V(:,i),[28,28])'.*255;
    subplot(3,5,i+5);
    image(eigenimage);
end

% With Gram trick PCA to get the first 5 eigenvectos
tic
G_S=ctrain'*ctrain./size(ctrain,2);
[G_U,G_D]=eigs(G_S,5);
G_V=normc(ctrain*G_U);
toc

%draw the first 5 eigenvector images
for i=1:5
    eigenimage=reshape(G_V(:,i),[28,28])'.*255;
    subplot(3,5,i+10);
    image(eigenimage);
end