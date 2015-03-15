function[data,days]=dataProc(ticker)

%% Grab Price Data
url = strcat('http://ichart.finance.yahoo.com/table.csv?s=',ticker,'&ignore=.csv');
price_file=urlwrite(url,strcat(ticker,'_prices.csv')); 
%% Data Processing
data_struct=importdata(price_file,',');
[days,~]=size(data_struct.data);
datenonvec=data_struct.textdata(2:end,1);
delete(strcat(ticker,'_prices.csv')); 


%% Convert to vector date format
date=zeros(days,6);
for day = 1:days
  date(day,:) = datevec(datenonvec(day)); 
end
date=date(:,1:3); %Remove time information - Date remains
data=data_struct.data;
data=[date,data]; %Combined date and data to restore data to previous state with vector data

data=flipud(data);
[days,~]=size(data);