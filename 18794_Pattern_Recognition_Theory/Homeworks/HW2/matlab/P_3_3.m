%select maxn first eigenvectors for reconstruction 
n=[1,2,5,10,20];
maxn=max(n);

%collect part of training data, controlled by samplenum
samplenum=100;
train=double([train0(1:samplenum,:);train1(1:samplenum,:);train2(1:samplenum,:);train3(1:samplenum,:);train4(1:samplenum,:);
    train5(1:samplenum,:);train6(1:samplenum,:);train7(1:samplenum,:);train8(1:samplenum,:);train9(1:samplenum,:)]');
mu=mean(train,2);
ctrain=train-repmat(mu,1,size(train,2));

%PCA without Gram trick
S=ctrain*ctrain'./size(ctrain,2);
[V,D]=eigs(S,maxn);
%PCA with Gram trick
G_S=ctrain'*ctrain./size(ctrain,2);
[G_U,G_D]=eigs(G_S,maxn);
G_V=normc(ctrain*G_U);

%set how many test samples randomly extracted from each test data
m=3;

%collect test data
images=zeros(size(mu,1),10*m);
index=1;
images(:,index:index+m-1)=test0(randi([1 samplenum],1,m),:)';
index=index+m;
images(:,index:index+m-1)=test1(randi([1 samplenum],1,m),:)';
index=index+m;
images(:,index:index+m-1)=test2(randi([1 samplenum],1,m),:)';
index=index+m;
images(:,index:index+m-1)=test3(randi([1 samplenum],1,m),:)';
index=index+m;
images(:,index:index+m-1)=test4(randi([1 samplenum],1,m),:)';
index=index+m;
images(:,index:index+m-1)=test5(randi([1 samplenum],1,m),:)';
index=index+m;
images(:,index:index+m-1)=test6(randi([1 samplenum],1,m),:)';
index=index+m;
images(:,index:index+m-1)=test7(randi([1 samplenum],1,m),:)';
index=index+m;
images(:,index:index+m-1)=test8(randi([1 samplenum],1,m),:)';
index=index+m;
images(:,index:index+m-1)=test9(randi([1 samplenum],1,m),:)';

%For PCA without Gram trick
for nid=1:size(n,2)
    figure;
    %For all digits
    for i=1:10
        %For all test data of each digit
        for j=1:m
            id=(i-1)*m+j;
            %draw original image firstly
            subplot(10,2*m,2*(id-1)+1);
            originimageshow=reshape(images(:,id),[28,28])';
            image(originimageshow);
            title(sprintf('origin: w/o G, n=%d',n(nid)),'FontSize',8);
            %reconstruct image with n(nid) first eigenvectos
            muimage=images(:,id)-mu;
            eigenimage=muimage;
            for k=1:n(nid)
                coeff=V(:,k)'*muimage;
                eigenimage=eigenimage+V(:,k)*coeff;
            end
            %draw reconstrcuted image secondly
            subplot(10,2*m,2*(id-1)+2);
            eigenimageshow=reshape(eigenimage,[28,28])';
            image(eigenimageshow);
            %calculate MSE
            MSE=norm(images(:,id)-eigenimage);
            title(sprintf('MSE=%f',MSE),'FontSize',8);
        end
    end
end

%For PCA with Gram trick
for nid=1:size(n,2)
    figure;
    %For all digits
    for i=1:10
        %For all test data of each digit
        for j=1:m
            id=(i-1)*m+j;
            %draw original image firstly
            subplot(10,2*m,2*(id-1)+1);
            originimageshow=reshape(images(:,id),[28,28])';
            image(originimageshow);
            title(sprintf('origin: w G, n=%d',n(nid)),'FontSize',8);
            %reconstruct image with n(nid) first eigenvectos
            muimage=images(:,id)-mu;
            eigenimage=muimage;
            for k=1:n(nid)
                coeff=V(:,k)'*muimage;
                eigenimage=eigenimage+G_V(:,k)*coeff;
            end
            %draw reconstrcuted image secondly
            subplot(10,2*m,2*(id-1)+2);
            eigenimageshow=reshape(eigenimage,[28,28])';
            image(eigenimageshow);
            MSE=norm(images(:,id)-eigenimage);
            %calculate MSE
            title(sprintf('MSE=%f',MSE),'FontSize',8);
        end
    end
end
