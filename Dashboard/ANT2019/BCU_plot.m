%BOOKING COST X USER -SUM(bcu)/TotUsers = (AVGcost * Users with that cost)/TotUsers plot

daytimemin = 1800;
daytimesec = 1800*60;
step = 30;
timestep = (1:120);
timestep = timestep * step;
timestepmin = timestep';
timestep = timestep' * 60;
timestep(end) = [];
timestep = timestep ./ 3600;
sims = [1,3,4,6,7,9,11,12];


for s=sims
    filename = sprintf('BookingCostXUser%i.mat',s);
    load(filename);
    BookingCostXUserMatrix = cell2mat(BookingCostXUserMatrix);
    plot(timestep/2,BookingCostXUserMatrix*10);
    filename1 = sprintf('Booking cost per User%i',s)
    title(filename1);
    xlabel('Time [h]');
    ylabel('Average cost per booking [€cent/min]');
    xlabel('Time [h]');
    filename = sprintf('BookingCostXUser%i.png',s);
    saveas(gca,filename);
end
