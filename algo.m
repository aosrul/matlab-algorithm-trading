clear;clc;clf

%% Intial Investing Conditions
capital = 100000; %Intial Investment Amount
stock=0; %Intial Stock Held
ticker = 'GOOG';

%% Grab Data
[data,days] = dataProc(ticker);

% Data now presented in the following format
% Year-Month-Date-Opening Price-High-Low-Closing Price-Volume-Adj. Closing Price

%%
for i = 3:days
  %% Buying Algorithm
  %Buy Action - Buy at open price
  if data(i-1,6)<0 && data(i-2,6)<0
    if capital > 0
      percent = (data(i,7)+data(i-1,7))/2; %Find average percentage change over the two days
      stockorder = floor( capital./data(i,4)* 20*abs(percent)); %Excute number of stock buying
      stock = stock + stockorder; %Update Portfolio Holdings
      capital = capital - stockorder*data(i,4); %Update Portfolio Cash Flow
      %disp(['Bought ' num2str(stockorder) ' Stock at Price ' num2str(data(i,4)*stockorder)])     
    end
  end
  %% Selling Algorithm
  %Sell Action - Sell at close price
  if data(i,6)>0 && data(i-1,6)>0
    if stock > 0
      percent = (data(i,7)+data(i-1,7))/2;
      stockorder = floor( stock*20*abs(percent));
      stock = stock - stockorder;
      capital = capital + stockorder*data(i,5);
    end
  end
  
  %profit(i)=capital+stock*data(i,5)-100000;
  %profit = profit';
end


x=1:days;
clear i days
%% Plot Stock Price Performance and Portfolio Profit Performance

subplot(1,2,1), plot(x,data(:,4)); title('Price')
%subplot(1,2,2), plot(x,profit); title('Net Profit')
