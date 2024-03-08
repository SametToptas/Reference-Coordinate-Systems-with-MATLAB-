% Abdulsamet Toptaş - 21905024
% I created the function specified in the assignment for the conversion
function [tai,gpst,tt]=converttime(utc); 

% I created a while loop and printed the conditions for a warning when a year is entered before leapsecond.(5-23 rows) 
% In addition, I provided a warning when values such as day, month and second of the day are exceeded.(5-23 rows)
while true
utc_year = input('Enter the UTC Year You Want to Convert: ');
utc_month = input('Enter the UTC Month You Want to Convert: ');
utc_day = input('Enter the UTC Day You Want To Convert: ');
utc_second_of_day = input('Enter the UTC Second of Day You Want To Convert: ');
utc = [utc_year, utc_month, utc_day, utc_second_of_day];

    if utc_year < 1972
        fprintf("WARNING!! A year before 1972 cannot be entered.\n");
    elseif utc_month < 1 || utc_month > 12
        fprintf("WARNING!! The month to be entered must be between 1 and 12.\n");
    elseif utc_day < 1 || utc_day > 31
        fprintf("WARNING!! The day to be entered must be between 1 and 31.\n");
    elseif utc_second_of_day < 0 || utc_second_of_day > 86400
        fprintf("WARNING!! Must be between 0 and 86400 as second of day.\n");
    else
        break
    end
end
% I made the hour, minute, second conversions with classical formulas.(26-38 rows)
% I converted all data to seconds using specific ordering.(26-38 rows)
min1 = (utc(4)/60);
min2 = mod(min1,60);
min3 = floor(min2);
hour1 = min1/60;
hour2 = floor(hour1);
sec = (utc(4) - ((hour2*60*60) + (min3*60)));
utc_epoch = [utc(1),utc(2),utc(3)];
utc_epoch(4) = hour2;
utc_epoch(5) = min3;
utc_epoch(6) = sec;
% I took the utc epochs as dates and converted them to julian dates.(36-37 rows)
date_convert = datetime(utc_epoch);
julian_convert = juliandate(date_convert);

% I created my vector using wikipedia leap second epoch information.(40-42 rows)
leapsec_vector = [1972,06,30,23,59,60;1972,12,31,23,59,60;1973,12,31,23,59,60;1974,12,31,23,59,60;1975,12,31,23,59,60;1976,12,31,23,59,60;1977,12,31,23,59,60;1978,12,31,23,59,60;1979,12,31,23,59,60;
    1981,06,30,23,59,60;1982,06,30,23,59,60;1983,06,30,23,59,60;1985,06,30,23,59,60;1987,12,31,23,59,60;1989,12,31,23,59,60;1990,12,31,23,59,60;1992,06,31,23,59,60;1993,06,30,23,59,60;
    1994,06,30,23,59,60;1995,12,31,23,59,60;1997,06,31,23,59,60;1998,12,31,23,59,60;2005,12,31,23,59,60;2008,12,31,23,59,60;2012,06,30,23,59,60;2015,06,30,23,59,60;2016,12,31,23,59,60];
% I converted leap seconds to julian date by creating a for loop and got all leap seconds in order.(45-52 rows)
for n = 1:length(leapsec_vector)
    sum_leapsec = leapsec_vector(n:27:27*6); 
    date_time = datetime(sum_leapsec);          
    s_j_d = juliandate(date_time);
    if s_j_d > julian_convert
        break
    end
end
% I converted the Julian dates I converted to the time we used using the datetime() function.(54-61 rows)
formula_tai = julian_convert + ((10 + n*1)/86400);
julian_tai = datetime(formula_tai,'convertfrom','juliandate');

formula_gpst = formula_tai - (19/86400);
julian_gpst = datetime(formula_gpst,'convertfrom','juliandate');

formula_tt = formula_tai + (32.184/86400);
julian_tt = datetime(formula_tt,'convertfrom','juliandate');

% I created a 1 row 4 column vector as requested in the assignment.(64 row)
% I scanned the vector using a for loop and correlated the tai,gpst,tt transformations using (53-60) rows.(66-79 rows)
% As stated in the output in the assignment, I printed the seconds of the day in seconds into vector. (72 row)
time_scales = [julian_tai,julian_gpst,julian_tt];
for n = 1:length(time_scales)
    data = time_scales(n);
    y = year(data);
    m = month(data);
    d = day(data);
    s_o_d = hour(data)*3600 + minute(data)*60 + floor(second(data));
    if time_scales(n) == julian_tai
        tai = [y, m, d,s_o_d]
    elseif time_scales(n) == julian_gpst
        gpst = [y, m, d,s_o_d]
    elseif time_scales(n) == julian_tt
        tt = [y, m, d,s_o_d]      
    end    
end
