fs = 1000; % Sampling frequency in Hz
unit_duration = 0.82533333333; % Duration of one ECG cycle
num_cycles = ceil(10 / unit_duration); % Number of cycles needed for 10 seconds

% Generate synthetic ECG for one cycle
t_unit = 0:1/fs:unit_duration; % Time vector for one unit cycle
ecg_unit = ecg(length(t_unit))'; % Generate ECG signal for one unit and ensure it is a column vector

% Repeat the ECG signal to create a 10-second-long waveform
t = (0:1/fs:(num_cycles * unit_duration))'; % Time vector for all cycles
ecg_signal = repmat(ecg_unit, num_cycles, 1); % Repeat the ECG unit signal

% Trim to exactly 10 seconds
valid_indices = t <= 10; % Logical indices for trimming
t = t(valid_indices);
ecg_signal = ecg_signal(1:length(t));

% Combine time and value pairs
pwl_data = [t, 0.001*ecg_signal]; % Ensure both t and ecg_signal are column vectors

% Save to PWL file
dlmwrite('ecg_pwl_fixed2.txt', pwl_data, 'delimiter', ' ', 'precision', 6);

% Verify by plotting
figure;
plot(pwl_data(:, 1), pwl_data(:, 2));
xlabel('Time (s)');
ylabel('Amplitude (V)');
title('10-Second ECG Signal Generated Using "ecg" Function');