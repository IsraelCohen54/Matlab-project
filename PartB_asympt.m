function [calcConst,Confidence,index] = PartB_asympt(array,eps)

%function find place and value of stabilaze graph point
%input: 1d array and stabilization criterion as 'eps'
%output:
% 1. estimated place of stabilization
% 2. space/range +- it happens, as 2 nums
% 3. index/place from which stabilization start

%B)
     %iii)
        lastFive = array (end-5:end);
        esConst = mean(lastFive);
        esNoise = std (array); %stiyat teken, estimeted noise value
   %(4)
      while true
        %(a)
        diff = abs(array - esConst); %len from constant
        %(b)
        index = find (diff < esNoise,1); %get first index its value lower than noise estimated value
        %(c)
        newArray = array (index:end); 
        calcConst = mean(newArray); %estimated of the constant value
        %(d)
        calcNoise = std(newArray); %noise estimation
        %(e)
        conv = (abs (esConst - calcConst)) / calcConst; 
        %(f)
        if conv < eps
           break
           %(g) updating values to next iteration:
           else
            esConst = calcConst;
           esNoise = calcNoise;
        end 
      end 

   %(6)
        lower_bound = calcConst - 2 * calcNoise;
        upper_bound = calcConst + 2 * calcNoise;
        Confidence = [lower_bound upper_bound];
end


