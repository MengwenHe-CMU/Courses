clc;
tasknum=5;
ct=sort(randi(1000,tasknum,2),2);
[U,I]=sort(ct(:,1)./ct(:,2),1,'descend');
ct=ct(I,:);
disp('cd data');
disp('./hotplug_cpu_all_on.sh sysclock');
for i=1:tasknum
    disp(sprintf('./easyperiodic &'));
    disp(sprintf('T%d=$!',i));
end
disp('ps | grep easy');
disp('./reserve');
disp(sprintf('\n'));
for i=1:tasknum
    disp(sprintf('./reserve set $T%d %d %d -1',i,ct(i,1),ct(i,2)));
end
disp(sprintf('\n'));
for i=1:tasknum
    disp(sprintf('./reserve cancel $T%d',i));
end
disp(sprintf('\n'));
tu=0;
for i=1:tasknum
    disp(sprintf('%d\t%d\t%f',ct(i,1),ct(i,2),ct(i,1)/ct(i,2)));
    tu=tu+ct(i,1)/ct(i,2);
end
tu
disp(sprintf('\n'));
for i=1:tasknum
    disp(sprintf('kill $T%d',i));
end