load Agents.mat
load MembersMinus1010.mat

%MembersAgents = MembersAgents';
% Agents = str2double(Agents);
% Members = str2double(Members);

minDist = [inf,0,0,0,0];
DistAgentsMembers = zeros(numel(Members(:,2)),numel(minDist));
candidables=true(size(Agents,1),1);
minAgent=nan;
for i = 1:numel(Members(:,2))
    for j = 1:numel(Agents(:,2))
        if ~candidables(j)
            continue
        end
        TempDist= sqrt((Agents(j,3)-Members(i,3)).^2+((Agents(j,4)-Members(i,4)).^2));
        if TempDist < minDist(1,1)
            minDist(1,1) = TempDist(1,1);
            minDist(1,2) = Members(i,2);
            minDist(1,3:5) = Agents(j,2:4);
            minAgent=j;
        end
    end
    DistAgentsMembers(i,:) = minDist(:,:);
    minDist = [inf,0,0,0,0];
    candidables(minAgent)=false;
end
