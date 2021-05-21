load lineIDs10pctXYID.mat
load VOT_ID.mat

filename = sprintf('IDXYAccessRevenueBooking2.xlsx');
xlswrite(filename,lineIDs10pctXYID,VOT_ID);