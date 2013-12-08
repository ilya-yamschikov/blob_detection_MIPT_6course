% function to log progress

% INPUT:
% 1. value - number that indicates current progress
% 2. range - value should be in [0 ... range]
% 3. next_step - next output (when proress reach next_step*100% message will be outputted) 
% 4. step - function outputs current progress every step*100% percents

% OUTPUT:
% 1. next_step - next output

function next_step = log_progress(value, range, next_step, step)
    rate = value / range; 
    if (rate > next_step)
        disp(['progress: ' num2str(next_step * 100) '%...']);
        while (next_step < rate)
            next_step = next_step + step; 
        end
    end
end