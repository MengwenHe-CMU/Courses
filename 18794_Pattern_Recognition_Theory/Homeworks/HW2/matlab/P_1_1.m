figure;
hold on;

%load data
c1=[2,2,2;1,2,3];
c2=[4,5,6;3,3,4];
c=[c1,c2];

%(1) calculate mean
mu=mean(c,2);

%draw data points
plot(c1(1,:),c1(2,:),'rx',c2(1,:),c2(2,:),'bo');
axis([0,7,0,7]);
axis equal;

%(2) centralize data points
cc1=c1-repmat(mu,1,size(c1,2));
cc2=c2-repmat(mu,1,size(c2,2));
cc=[cc1,cc2];

%(3) calculate covariant matrix S
S=cc*cc'./size(cc,2);
%(4) calculate eigenvectors and eigenvalues of S;
[V,D]=eig(S);
%(5) sort eigenvalues and eigenvectors;
[E,I]=sort(diag(D),'descend');
V=V(:,I);

%(6) calcuate w, the normal vector of the projection line
tempw=cross([0;0;1],[V(:,1);0]);
w=tempw(1:2,1);
w=w/norm(w); %the normal vector of the desired projection line 
%(7) calculate w0
w0=-w'*mu;

%draw projection line
fh=@(x1,x2) w(1)*x1+w(2)*x2+w0;
ezplot(fh,[0,7,0,7]);
axis equal;

%projected points
pc=V(:,1)*(V(:,1)'*cc)+repmat(mu,1,size(cc,2));

%draw projections
for i=1:size(pc,2)
    plot([c(1,i);pc(1,i)],[c(2,i);pc(2,i)],'black');
end

%(8) calculate MSE
MSE=sum(sum((c-pc).^2,1),2)/size(c,2)

%(9) calculate Fisher ratio
pcc1=V(:,1)'*cc1;
pcc2=V(:,1)'*cc2;
pmu1=mean(pcc1,2);
pmu2=mean(pcc2,2);
pccc1=(pcc1-pmu1);
pccc2=(pcc2-pmu2);
ps1=(pccc1*pccc1')/size(pccc1,2);
ps2=(pccc2*pccc2')/size(pccc2,2);
FR=(pmu1-pmu2)^2/(ps1+ps2)

%set title
title(sprintf('[%f,%f]*x+%f=0; MSE=%f, FR=%f',w(1),w(2),w0,MSE,FR));