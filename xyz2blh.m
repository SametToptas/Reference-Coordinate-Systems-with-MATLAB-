% Abdulsamet Toptaş - 21905024
% I created the function specified in the assignment 3 for the transformation 
% from Cartesian to Ellipsoidal Coordinates. Reference ellipsoid is GRS80.
function [b,l,h] = xyz2blh(x,y,z)

% X Coordinates in Meters For the GLOBAL2LOCAL Observation Point (row 9)
% Y Coordinates in Meters For the GLOBAL2LOCAL Observation Point (row 10)
% Z Coordinates in Meters For the GLOBAL2LOCAL Observation Point (row 11)
x = 4208830.726
y = 2334850.0235
z = 4171267.089

% Semi-major axis a, given in assignment 3. (row 14)
a_major = 6378137.0;
% Semi-minor axis b, given in assignment 3. (row 16)
b_minor = 6356752.3141;
% e is eccentricity,(formula) 3rd slide referenced. (row 18)
e = (a_major^2-b_minor^2)/a_major^2;

% variables for iteration (21-24 rows).
phi_2 = 0;
phi_abs = 1;
N = 1;
h = 0;
% I created a while loop for the conversion
% it returns the absolute value of the difference between both 'Phi' values until they drop below 10^-12 degrees.
while phi_abs > 10^(-12)
    % b is "φ - ellipsoidal latitude", in other words phi,'formula' -> 3rd slide referenced.(row 29)
    b = atand((z/sqrt(x^2+y^2))*(1-((e)*(N/(N+h))))^-1); 
    % The absolute value of the difference of two phi values. (row 31)
    phi_abs = abs(phi_2 - b);
    phi_2 = b;
    % N is radius of curvature in the prime vertical,'formula' -> 3rd slide referenced. (row 34)
    N = a_major/sqrt(1-(e)*(sind(b))^2);
    % h is "h - ellipsoidal height",'formula' -> 3rd slide referenced. (row 36)
    h = ((sqrt(x^2+y^2))/cosd(b))-(N);
end
% l is "λ - ellipsoidal longitude", in other words lambda.'formula' -> 3rd slide referenced.(row 40)
% atan2d(Y,X) returns the four-quadrant inverse tangent (tan-1) of Y and X, which must be real. (row 40)
l = atan2d(y,x);

fprintf("Phi was found as %.4f in degrees, Lambda as %.4f in degrees, and Height as %.4f in meters.",b,l,h)
end