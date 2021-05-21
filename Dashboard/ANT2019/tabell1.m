%CIARI

load lineIDs10pctXYID.mat
load VOT_ID.mat
load AccessTime1.mat
load AccessTime3.mat
load AccessTime4.mat
load AccessTime6.mat
load AccessTime7.mat
load AccessTime9.mat
load AccessTime11.mat
load AccessTime12.mat
load Revenue1.mat
load Revenue3.mat
load Revenue4.mat
load Revenue6.mat
load Revenue7.mat
load Revenue9.mat
load Revenue11.mat
load Revenue12.mat
load Booking_Time_1.mat
BookingTime1 = BookingTimePercentage;
load Booking_Time_3.mat
BookingTime3 = BookingTimePercentage;
load Booking_Time_4.mat
BookingTime4 = BookingTimePercentage;
load Booking_Time_6.mat
BookingTime6 = BookingTimePercentage;
load Booking_Time_7.mat
BookingTime7 = BookingTimePercentage;
load Booking_Time_9.mat
BookingTime9 = BookingTimePercentage;
load Booking_Time_11.mat
BookingTime11 = BookingTimePercentage;
load Booking_Time_12.mat
BookingTime12 = BookingTimePercentage;


lineIDs10pctXYID = str2double(lineIDs10pctXYID);
VOT_ID = str2double(VOT_ID);

Tabellone = [lineIDs10pctXYID VOT_ID(:,2)];

for i=1:numel(Tabellone(:,1))
    for j=1:numel(AccessTime1(:,1))
        if Tabellone(i,1) == AccessTime1(j,2)
            Tabellone(i,5) = AccessTime1(j,1);
        end
    end
end

clear i
clear j

for i=1:numel(Tabellone(:,1))
    for j=1:numel(AccessTime3(:,1))
        if Tabellone(i,1) == AccessTime3(j,2)
            Tabellone(i,6) = AccessTime3(j,1);
        end
    end
end

clear i
clear j

for i=1:numel(Tabellone(:,1))
    for j=1:numel(AccessTime4(:,1))
        if Tabellone(i,1) == AccessTime4(j,2)
            Tabellone(i,7) = AccessTime4(j,1);
        end
    end
end

clear i
clear j

for i=1:numel(Tabellone(:,1))
    for j=1:numel(AccessTime6(:,1))
        if Tabellone(i,1) == AccessTime6(j,2)
            Tabellone(i,8) = AccessTime6(j,1);
        end
    end
end

clear i
clear j

for i=1:numel(Tabellone(:,1))
    for j=1:numel(AccessTime7(:,1))
        if Tabellone(i,1) == AccessTime7(j,2)
            Tabellone(i,9) = AccessTime7(j,1);
        end
    end
end

clear i
clear j

for i=1:numel(Tabellone(:,1))
    for j=1:numel(AccessTime9(:,1))
        if Tabellone(i,1) == AccessTime9(j,2)
            Tabellone(i,10) = AccessTime9(j,1);
        end
    end
end

clear i
clear j

for i=1:numel(Tabellone(:,1))
    for j=1:numel(AccessTime11(:,1))
        if Tabellone(i,1) == AccessTime11(j,2)
            Tabellone(i,11) = AccessTime11(j,1);
        end
    end
end

clear i
clear j

for i=1:numel(Tabellone(:,1))
    for j=1:numel(AccessTime12(:,1))
        if Tabellone(i,1) == AccessTime12(j,2)
            Tabellone(i,12) = AccessTime12(j,1);
        end
    end
end

clear i
clear j

for i=1:numel(Tabellone(:,1))
    for j=1:numel(Revenue1(:,1))
        if Tabellone(i,1) == Revenue1(j,1)
            Tabellone(i,13) = Revenue1(j,3);
        end
    end
end

clear i
clear j

for i=1:numel(Tabellone(:,1))
    for j=1:numel(Revenue3(:,1))
        if Tabellone(i,1) == Revenue3(j,1)
            Tabellone(i,14) = Revenue3(j,3);
        end
    end
end

clear i
clear j

for i=1:numel(Tabellone(:,1))
    for j=1:numel(Revenue4(:,1))
        if Tabellone(i,1) == Revenue4(j,1)
            Tabellone(i,15) = Revenue4(j,3);
        end
    end
end

clear i
clear j

for i=1:numel(Tabellone(:,1))
    for j=1:numel(Revenue6(:,1))
        if Tabellone(i,1) == Revenue6(j,1)
            Tabellone(i,16) = Revenue6(j,3);
        end
    end
end

clear i
clear j

for i=1:numel(Tabellone(:,1))
    for j=1:numel(Revenue7(:,1))
        if Tabellone(i,1) == Revenue7(j,1)
            Tabellone(i,17) = Revenue7(j,3);
        end
    end
end

clear i
clear j

for i=1:numel(Tabellone(:,1))
    for j=1:numel(Revenue9(:,1))
        if Tabellone(i,1) == Revenue9(j,1)
            Tabellone(i,18) = Revenue9(j,3);
        end
    end
end

clear i
clear j

for i=1:numel(Tabellone(:,1))
    for j=1:numel(Revenue11(:,1))
        if Tabellone(i,1) == Revenue11(j,1)
            Tabellone(i,19) = Revenue11(j,3);
        end
    end
end

clear i
clear j

for i=1:numel(Tabellone(:,1))
    for j=1:numel(Revenue12(:,1))
        if Tabellone(i,1) == Revenue12(j,1)
            Tabellone(i,20) = Revenue12(j,3);
        end
    end
end

clear i
clear j

for i=1:numel(Tabellone(:,1))
    for j=1:numel(BookingTime1(:,1))
        if Tabellone(i,1) == BookingTime1(j,3)
            Tabellone(i,21) = BookingTime1(j,2);
        end
    end
end

clear i
clear j

for i=1:numel(Tabellone(:,1))
    for j=1:numel(BookingTime3(:,1))
        if Tabellone(i,1) == BookingTime3(j,3)
            Tabellone(i,22) = BookingTime3(j,2);
        end
    end
end

clear i
clear j

for i=1:numel(Tabellone(:,1))
    for j=1:numel(BookingTime4(:,1))
        if Tabellone(i,1) == BookingTime4(j,3)
            Tabellone(i,23) = BookingTime4(j,2);
        end
    end
end

clear i
clear j

for i=1:numel(Tabellone(:,1))
    for j=1:numel(BookingTime6(:,1))
        if Tabellone(i,1) == BookingTime6(j,3)
            Tabellone(i,24) = BookingTime6(j,2);
        end
    end
end

clear i
clear j

for i=1:numel(Tabellone(:,1))
    for j=1:numel(BookingTime7(:,1))
        if Tabellone(i,1) == BookingTime7(j,3)
            Tabellone(i,25) = BookingTime7(j,2);
        end
    end
end

clear i
clear j

for i=1:numel(Tabellone(:,1))
    for j=1:numel(BookingTime9(:,1))
        if Tabellone(i,1) == BookingTime9(j,3)
            Tabellone(i,26) = BookingTime9(j,2);
        end
    end
end

clear i
clear j

for i=1:numel(Tabellone(:,1))
    for j=1:numel(BookingTime11(:,1))
        if Tabellone(i,1) == BookingTime11(j,3)
            Tabellone(i,27) = BookingTime11(j,2);
        end
    end
end

clear i
clear j

for i=1:numel(Tabellone(:,1))
    for j=1:numel(BookingTime12(:,1))
        if Tabellone(i,1) == BookingTime12(j,3)
            Tabellone(i,28) = BookingTime12(j,2);
        end
    end
end

clear i
clear j

Tabellone(Tabellone == 0) = -99; 

filename = sprintf('IDXYAccessRevenueBooking.xlsx');
xlswrite(filename,Tabellone);