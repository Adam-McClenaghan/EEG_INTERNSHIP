%% instantiate the library
fs = 125;
trial_length = 5;
stimfreq = [8,9,10,11,12,13,14,15];
roi = [1,2,7,8,11,12,15,16]
num_chan = 16;
Data_arr = zeros(fs*trial_length, num_chan);
CCA_data = zeros(fs*trial_length, length(roi));
uVscale = (4500000 / 24 / (2^23 -1));

%% Create comparisson matrix

S = fs;
T = size(Data_arr, 1);
t = (1/S:1/S:T/S);
num_harmonics = 4;
num_inputs = length(stimfreq);

compmat = zeros(2*num_harmonics,length(t),num_inputs);

for i = 1:length(compmat(1,1,:))


input_freq = stimfreq(i);
 
    for k = 1:2:2*num_harmonics
    compmat(k,:,i) = sin((k+1)*pi*input_freq*t);
    end

    for j = 2:2:2*num_harmonics
    compmat(j,:,i) = cos(j*pi*input_freq*t);    
    end

end

%% Get LSL data

disp('Loading the library...');
lib = lsl_loadlib(); 
version = lsl_library_version(lib);

% resolve a stream...
disp('Resolving an EEG stream...');
result = {};
while isempty(result)
    result = lsl_resolve_byprop(lib,'type','EEG'); end

% create a new inlet
disp('Opening an inlet...');
inlet = lsl_inlet(result{1});

disp('Now receiving data...');
while true
    count = 1;
    while count <= size(Data_arr, 1)
        % get data from the inlet
        [vec,ts] = inlet.pull_sample();
        % and display it
        Data_arr(count,:) = vec.*uVscale;
        
        count = count + 1;
       
%         fprintf('%.2f\t',vec);
%         fprintf('%.5f\n',ts);
    end
    CCA_live
end
